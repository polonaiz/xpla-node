IMAGE_NAME = xpla-node
IMAGE_VERSION = 1.0.0
IMAGE_TAG = ${IMAGE_NAME}:${IMAGE_VERSION}
CONTAINER_NAME = ${IMAGE_NAME}-local
VOLUME = ${IMAGE_NAME}-data
CHAIN_ID = dimension_37-1

build:
	docker build -t ${IMAGE_TAG} \
		./container.image.d \
		-f ./container.image.d/Dockerfile_1.0.0

build-nocache:
	docker build -t ${IMAGE_TAG} \
		./container.image.d \
		-f ./container.image.d/Dockerfile_1.0.0 \
		--no-cache

init:
	docker run \
		--rm \
		--name ${CONTAINER_NAME} \
		--volume ${VOLUME}:/data/lib/xplad/${CHAIN_ID} \
		--env XPLA_HOME=/data/lib/xplad/${CHAIN_ID} \
		--env CHAIN_ID=${CHAIN_ID} \
		--env MONIKER=xpla-dimension-0 \
		${IMAGE_TAG} \
		./dimension-init

start:
	docker run \
		--rm -it \
		--name ${CONTAINER_NAME} \
		--volume ${VOLUME}:/data/lib/xplad/${CHAIN_ID} \
		${IMAGE_TAG} \
		./dimension-start

rm:
	docker volume rm ${VOLUME}

shell:
	docker run \
		--rm -it \
		--name ${CONTAINER_NAME} \
		--volume ${VOLUME}:/data/lib/xplad/${CHAIN_ID} \
		${IMAGE_TAG} \
		bash
