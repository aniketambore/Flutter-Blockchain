const Minter = artifacts.require("Minter") ;

contract("Minter" , () => {
    let minter = null ;
    before(async () => {
        minter = await Minter.deployed() ;
    });

    it("Should Mint coins", async () => {
        await minter.mint("0x05b3385e1375b1dff101D0043B6496be22eE3DB2",197);
        const balance = await minter.balance("0x05b3385e1375b1dff101D0043B6496be22eE3DB2") ;
        assert(balance.toNumber() === 197);
    });

    it("Should Send coins", async () => {
        await minter.send("0x05b3385e1375b1dff101D0043B6496be22eE3DB2" , "0x403e69D7adB0BD9Da3793EbD5401a5c41445Ff8F" , 97);
        const senderBalance = await minter.balance("0x05b3385e1375b1dff101D0043B6496be22eE3DB2") ;
        const receiverBalance = await minter.balance("0x403e69D7adB0BD9Da3793EbD5401a5c41445Ff8F") ;
        assert(senderBalance.toNumber() === 100);
        assert(receiverBalance.toNumber() === 97);
    });
});