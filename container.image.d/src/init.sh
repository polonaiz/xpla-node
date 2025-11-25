#!/usr/bin/env bash

set -x
echo XPLA_HOME=${XPLA_HOME}
echo CHAIN_ID=${CHAIN_ID}
echo MONIKER=${MONIKER}

rm -f ${XPLA_HOME}/config/genesis.json && \
xplad init --chain-id=${CHAIN_ID} --home=${XPLA_HOME} ${MONIKER} && \
wget -O ${XPLA_HOME}/config/genesis.json https://raw.githubusercontent.com/xpladev/mainnet/main/dimension_37-1/genesis.json && \

## app.toml
## 
## not enough pruning-keep-recent value can make suddden crash on parallel process lagging
sed -i -e 's/minimum-gas-prices = \"\"/minimum-gas-prices = \"850000000000axpla\"/g' ${XPLA_HOME}/config/app.toml && \
sed -i -e 's/pruning = \"default\"/pruning = \"custom\"/g' ${XPLA_HOME}/config/app.toml && \
sed -i -e 's/pruning-keep-recent = \"0\"/pruning-keep-recent = \"1000\"/g' ${XPLA_HOME}/config/app.toml && \
sed -i -e 's/pruning-keep-every = \"0\"/pruning-keep-every = \"0\"/g' ${XPLA_HOME}/config/app.toml && \
sed -i -e 's/pruning-interval = \"0\"/pruning-interval = \"10\"/g' ${XPLA_HOME}/config/app.toml && \
sed -i -e '/\[api\]/,+3 s/enable = false/enable = true/g' ${XPLA_HOME}/config/app.toml && \
sed -i -e '/\[api\]/,+6 s/swagger = false/swagger = true/g' ${XPLA_HOME}/config/app.toml && \

## config.toml
sed -i -e 's/indexer = \"kv\"/indexer = \"null\"/g' ${XPLA_HOME}/config/config.toml && \
sed -i -e 's/seeds = \"\"/seeds = \"e7b6016ce5663a69ba71a982072315545eb0d5f6@seed.xpla.delightlabs.io:26656\"/g' ${XPLA_HOME}/config/config.toml && \
sed -i -e 's/max_packet_msg_payload_size = 1024/max_packet_msg_payload_size = 4096/g' ${XPLA_HOME}/config/config.toml
sed -i -e 's/recv_rate = 5120000/recv_rate = 52428800/g' ${XPLA_HOME}/config/config.toml
sed -i -e 's/laddr = \"tcp:\/\/127.0.0.1:26657\"/laddr = \"tcp:\/\/0.0.0.0:26657\"/g' ${XPLA_HOME}/config/config.toml
