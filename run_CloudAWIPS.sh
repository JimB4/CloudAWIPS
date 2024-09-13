#!/usr/bin/env bash

if [ "$1" == "" ]; then
    echo "No container name  provided"
    echo "Using default of cs-cave"
    CONTANR="cs-cave"
else
    CONTANR=$1
fi

docker rm ${CONTANR}

ORG="jimb4"
PROJ="cloudstream"
TAG="latest"
IMAGE=${ORG}\/${PROJ}\:${TAG}

DPLAY=":1"

DWIDE=1792
DHIGH=1344

# Run on port 6080

docker run \
-p 6080:6080 \
-e DISPLAY=${DPLAY} \
-e SIZEW=${DWIDE} \
-e SIZEH=${DHIGH} \
-v /sys/fs/cgroup:/sys/fs/cgroup \
-v /dev/shm:/dev/shm \
--name ${CONTANR} \
--mount type=tmpfs,destination=/tmp,tmpfs-size=20480000,tmpfs-mode=1777 \
--cap-drop all \
--security-opt=no-new-privileges \
--ulimit nofile=500 \
-it $IMAGE

# Standard screen resolutions
# sz1 = 1792 x 1344
# sz2 = 1920 x 1080
# sz3 = 1920 x 1440
# sz4 = 1856 x 1392
# sz5 = 2540 x 1400

