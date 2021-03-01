const Minter = artifacts.require("Minter") ;

contract("Minter" , () => {
    let minter = null ;
    before(async () => {
        minter = await Minter.deployed() ;
    });

    it("Should Mint coins", async () => {
        await minter.mint("0x5c0D66B82c3087A5693dFCb31b5c0BB11C9AB624",197);
        const balance = await minter.balance("0x5c0D66B82c3087A5693dFCb31b5c0BB11C9AB624") ;
        assert(balance.toNumber() === 197);
    });

    it("Should Send coins", async () => {
        await minter.send("0x5c0D66B82c3087A5693dFCb31b5c0BB11C9AB624" , "0x88af3a7995072D761d0B4893210e0944ff53bC36" , 97);
        const senderBalance = await minter.balance("0x5c0D66B82c3087A5693dFCb31b5c0BB11C9AB624") ;
        const receiverBalance = await minter.balance("0x88af3a7995072D761d0B4893210e0944ff53bC36") ;
        assert(senderBalance.toNumber() === 100);
        assert(receiverBalance.toNumber() === 97);
    });
});