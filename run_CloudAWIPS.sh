#!/usr/bin/env bash

CONTANR=csdebug
docker rm $CONTANR

ORG="jimb4"
PROJ="cloudstream"
TAG="latest"

IMAGE=${ORG}\/${PROJ}\:${TAG}

# Run on port 6080

docker run -p 6080:6080 -e SIZEW=1792 -e SIZEH=1344 -e DISPLAY=:1 --name $CONTANR -v /sys/fs/cgroup:/sys/fs/cgroup -v /dev/shm:/dev/shm --mount type=tmpfs,destination=/tmp,tmpfs-size=20480000,tmpfs-mode=1777 -it $IMAGE /bin/bash

# Standard screen resolutions
# sz1 = 1792 x 1344
# sz2 = 1920 x 1080
# sz3 = 1920 x 1440
# sz4 = 1856 x 1392
# sz5 = 2540 x 1400
