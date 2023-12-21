IMAGE_NAME = xpla-node
TAG_NAME = 20231215
IMAGE_TAG = ${IMAGE_NAME}:${TAG_NAME}
CONTAINER_NAME = ${IMAGE_NAME}

build:
	docker build -t ${IMAGE_TAG} -f ./container.image.d/Dockerfile ./container.image.d/

build-nocache:
	# need new tag added
	docker build -t ${IMAGE_TAG} -f ./container.image.d/Dockerfile ./container.image.d/ --no-cache

start-container:
	docker run \
		--rm --detach \
		--name ${CONTAINER_NAME} \
		--mount type=bind,source=/data/lib/xplad,target=/data/lib/xplad \
		--mount type=bind,source=/data/app/xpla-node,target=/data/app/xplad \
		${IMAGE_TAG} \
		sleep infinity

stop-container:
	docker stop ${CONTAINER_NAME}

shell-container:
	docker exec -it ${CONTAINER_NAME} bash

