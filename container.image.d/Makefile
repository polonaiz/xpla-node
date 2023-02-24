IMAGE_NAME = xpla-node
TAG_NAME = 20230227
IMAGE_TAG = ${IMAGE_NAME}:${TAG_NAME}
CONTAINER_NAME = ${IMAGE_NAME}
VOLUME_NAME = xpla-node-data

build:
	docker build -t ${IMAGE_TAG} -f Dockerfile .

build-nocache:
	# need new tag added
	docker build -t ${IMAGE_TAG} -f Dockerfile --no-cache .

login:
	docker login

push:
	docker push ${CONTAINER_NAME}

create-volume:
	docker volume create \
		${VOLUME_NAME}

remove-volume:
	docker volume rm \
		${VOLUME_NAME}

start-container:
	docker run \
		--rm --detach \
		--name ${CONTAINER_NAME} \
		--mount type=volume,target=/data \
		${IMAGE_TAG} \
		sleep infinity

stop-container:
	docker stop ${CONTAINER_NAME}

shell-container:
	docker exec -it ${CONTAINER_NAME} bash

init-xplad:
	docker exec -it ${CONTAINER_NAME} sh -c /root/init.sh

start-xplad:
	docker exec -it ${CONTAINER_NAME} sh -c /root/start.sh

