const readBlockHeight = async () => {
    const { Level } = require('level')
    const db = new Level('/data/lib/xpla/data/blockstore.db')
    const value = await db.get('blockStore', { valueEncoding: 'buffer' })

    const protobuf = require("protobufjs");
    const root = await protobuf.load(`${__dirname}/types.proto`)
    const BlockStoreStateType = root.lookupType("BlockStoreState")
    const blockStoreState = BlockStoreStateType.decode(value)
    const blockHeight = blockStoreState.height.low
    return blockHeight
}

process.on('uncaughtException', (exception) => {
    console.log({ type: "uncaughtException", message: exception.toString(), stack: exception.stack })
    process.exit(1)
})
process.on('unhandledRejection', (exception, promise) => {
    console.log({ type: "unhandledRejection", message: exception.toString(), stack: exception.stack })
    process.exit(1)
})

const main = async () => {
    try {
        const blockHeight = await readBlockHeight()
        console.log(blockHeight)
    }
    catch (e) {
        throw e
    }
}

main()
