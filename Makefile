# Management of docker containers and images is up to you
#
# to remove a stopped container:
#     docker rm <container name>
#
# to remove an image 
#     docker rmi <image:tag>
#
 
ORG = jimb4
PROJ = cloudstream
TAG = latest

IMAGE = $(ORG)/$(PROJ):$(TAG)

.PHONY: all
#all: clean build
all: build

.PHONY: build
#build: clean docker_build
build: docker_build

docker_build:
	docker build  \
		-t $(IMAGE) \
		-f Dockerfile \
		--build-arg IMAGE=$(IMAGE) \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--build-arg VCS_URL=`git config --get remote.origin.url` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		.

#.PHONY: clean
#clean:
#     docker rmi $(IMAGE) --force
