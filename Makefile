IMAGE_NAME = xpla-node
CONTAINER_NAME = ${IMAGE_NAME}-local
VOLUME = ${IMAGE_NAME}-data
CHAIN_ID = dimension_37-1

build:
	docker build -t ${IMAGE_NAME}:1.0.0 \
		-f ./container.image.d/Dockerfile_1.0.0 \
		./container.image.d
	docker build -t ${IMAGE_NAME}:1.1.0 \
		-f ./container.image.d/Dockerfile_1.1.0 \
		./container.image.d

init:
	docker run \
		--name ${CONTAINER_NAME} \
		--volume ${VOLUME}:/data/lib/xplad/${CHAIN_ID} \
		--env XPLA_HOME=/data/lib/xplad/${CHAIN_ID} \
		--env CHAIN_ID=${CHAIN_ID} \
		--env MONIKER=xpla-dimension-0 \
		--rm \
		${IMAGE_NAME}:1.0.0 \
		./init.sh

start-1.0.0:
	docker rm -f ${CONTAINER_NAME}
	docker run \
		--name ${CONTAINER_NAME} \
		--volume ${VOLUME}:/data/lib/xplad/${CHAIN_ID} \
		--env XPLA_HOME=/data/lib/xplad/${CHAIN_ID} \
		--publish 26657:26657 \
		--detach \
		${IMAGE_NAME}:1.0.0 \
		./start.sh

start-1.1.0:
	docker rm -f ${CONTAINER_NAME}
	docker run \
		--name ${CONTAINER_NAME} \
		--volume ${VOLUME}:/data/lib/xplad/${CHAIN_ID} \
		--env XPLA_HOME=/data/lib/xplad/${CHAIN_ID} \
		--publish 26657:26657 \
		--detach \
		${IMAGE_NAME}:1.1.0 \
		./start.sh

log-follow:
	docker logs -f ${CONTAINER_NAME}

log-tail:
	watch --color -n3 docker logs xpla-node-local -n20

# rm:
# 	docker rm -f ${CONTAINER_NAME}
# 	docker volume rm ${VOLUME}

shell:
	docker run \
		--rm -it \
		--name ${CONTAINER_NAME} \
		--volume ${VOLUME}:/data/lib/xplad/${CHAIN_ID} \
		${IMAGE_NAME}:1.0.0 \
		bash

# wscat --connect ws://localhost:26657/websocket
# {"jsonrpc": "2.0","method": "subscribe","id": 0,"params": {"query": "tm.event='NewBlock'"}}
# {"jsonrpc": "2.0","method": "subscribe","id": 0,"params": {"query": "tm.event='Tx'"}}
