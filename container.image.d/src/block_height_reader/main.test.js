
test('decode', async () => {
    const protobuf = require("protobufjs");
    const root = await protobuf.load("./types.proto")
    const BlockStoreState = root.lookupType("BlockStoreState")
    const message = BlockStoreState.decode(new Uint8Array([8, 1, 16, 170, 141, 17]))
    expect(message.height.high).toBe(0)
    expect(message.height.low).toBe(280234)

})

test('level', async () => {
    const { Level } = require('level')
    const db = new Level('/data/lib/xpla/data/blockstore.db')
    // not found

    const value = await db.get('blockStore', { valueEncoding: 'buffer' })
    // const value = await db.get(new Uint8Array([98, 108, 111, 99, 107, 83, 116, 111, 114, 101]))

    const protobuf = require("protobufjs");
    const root = await protobuf.load("./types.proto")
    const BlockStoreState = root.lookupType("BlockStoreState")
    const message = BlockStoreState.decode(value)
    console.log({message})
})

// time tar -c --zstd -f xpla__archive__dimension_37-1__data__0000400000.tar.zst ./data/
// time tar -c --zstd -f xpla__archive__dimension_37-1__data__0000500000.tar.zst ./data/
// time tar -c --zstd -f xpla__archive__dimension_37-1__data__0000600000.tar.zst ./data/
// time tar -c --zstd -f xpla__archive__dimension_37-1__data__0000700000.tar.zst ./data/

// time tar -x --zstd -f xpla__archive__dimension_37-1__data__0000100000.tar.zst
// time tar -x --zstd -f xpla__archive__dimension_37-1__data__0000400000.tar.zst

