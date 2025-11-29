IMAGE_NAME = xpla-node
CONTAINER_NAME = ${IMAGE_NAME}-local
VOLUME = ${IMAGE_NAME}-data
VOLUME_ARCH = xpla-node-arch
CHAIN_ID = dimension_37-1

build:
	docker build -t ${IMAGE_NAME}:1.0.0 \
		-f ./container.image.d/Dockerfile_1.0.0 \
		./container.image.d
	docker build -t ${IMAGE_NAME}:1.1.0 \
		-f ./container.image.d/Dockerfile_1.1.0 \
		./container.image.d
	docker build -t ${IMAGE_NAME}:1.2.0 \
		-f ./container.image.d/Dockerfile_1.2.0 \
		./container.image.d
	docker build -t ${IMAGE_NAME}:1.3.3 \
		-f ./container.image.d/Dockerfile_1.3.3 \
		./container.image.d
	docker build -t ${IMAGE_NAME}:1.4.1 \
		-f ./container.image.d/Dockerfile_1.4.1 \
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

# 6:16AM ERR UPGRADE "XplaReward" NEEDED at height: 755000: {"fee_pool_rate": "0.2","community_
# pool_rate": "0.79","reserve_rate": "0.01","reserve_account": "xpla10ksn9528f82uwnmz3sgr4n42l0
# nucmzntjrg00","reward_distribute_account": "xpla19dacf8gzsvuj9txzw0wmtfpdg8swpd4jxl3ks2"}
# panic: UPGRADE "XplaReward" NEEDED at height: 755000: {"fee_pool_rate": "0.2","community_pool
# _rate": "0.79","reserve_rate": "0.01","reserve_account": "xpla10ksn9528f82uwnmz3sgr4n42l0nucm
# zntjrg00","reward_distribute_account": "xpla19dacf8gzsvuj9txzw0wmtfpdg8swpd4jxl3ks2"}		

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

start-1.2.0:
	docker rm -f ${CONTAINER_NAME}
	docker run \
		--name ${CONTAINER_NAME} \
		--volume ${VOLUME}:/data/lib/xplad/${CHAIN_ID} \
		--env XPLA_HOME=/data/lib/xplad/${CHAIN_ID} \
		--publish 26657:26657 \
		--detach \
		${IMAGE_NAME}:1.2.0 \
		./start.sh

start-1.3.3:
	docker rm -f ${CONTAINER_NAME}
	docker run \
		--name ${CONTAINER_NAME} \
		--volume ${VOLUME}:/data/lib/xplad/${CHAIN_ID} \
		--env XPLA_HOME=/data/lib/xplad/${CHAIN_ID} \
		--publish 26657:26657 \
		--detach \
		${IMAGE_NAME}:1.3.3 \
		./start.sh

start-1.4.1:
	docker rm -f ${CONTAINER_NAME}
	docker run \
		--name ${CONTAINER_NAME} \
		--volume ${VOLUME}:/data/lib/xplad/${CHAIN_ID} \
		--env XPLA_HOME=/data/lib/xplad/${CHAIN_ID} \
		--publish 26657:26657 \
		--detach \
		${IMAGE_NAME}:1.4.1 \
		./start.sh

log-follow:
	docker logs -f ${CONTAINER_NAME}

log-tail:
	watch --color -n1 docker logs xpla-node-local -n30

# rm:
# 	docker rm -f ${CONTAINER_NAME}
# 	docker volume rm ${VOLUME}

shell:
	docker run \
		--rm -it \
		--name ${CONTAINER_NAME} \
		--volume ${VOLUME}:/data/lib/xplad/${CHAIN_ID} \
		--volume ${VOLUME_ARCH}:/arch/lib/xplad \
		${IMAGE_NAME}:1.3.3 \
		bash

subscribe:
	wscat \
		--connect ws://localhost:26657/websocket \
		--wait 600 \
		--execute "{\"jsonrpc\": \"2.0\",\"method\": \"subscribe\",\"id\": 0,\"params\": {\"query\": \"tm.event='Tx'\"}}"

volume-arch-create:
	docker volume create \
		--driver local \
		-o o=bind \
		-o type=none \
		-o device=/Users/polonaiz/workspaces/xpla-node-arch \
		xpla-node-arch

volume-data-create:
	docker volume create \
		--driver local \
		--opt type=none \
		--opt device=/data/lib/xplad \
		--opt o=bind \
		xplad-data

# tar -zcvf /arch/lib/xplad__dimension_37-1__data__0-755000__1.0.0.tar.gz -C /data/lib/xplad/dimension_37-1 data
