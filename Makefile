# Management of docker containers and images is up to you
#
# to remove a stopped container:
#     docker rm <container name>
#
# to remove an image 
#     docker rmi <image:tag>
#
 
ORG = jimb4
IMAGE = cloudstream
TAG = latest

all: build

build:
	docker build  \
		-t $(ORG)/$(IMAGE):$(TAG) \
		-f Dockerfile \
		--no-cache \
		--build-arg IMAGE=$(ORG)/$(IMAGE):$(TAG) \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--build-arg VCS_URL=`git config --get remote.origin.url` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		.

.PHONY: build
