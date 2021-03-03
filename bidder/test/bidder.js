const Bidder = artifacts.require("Bidder") ;

contract("Bidder" , () => {
    let bidder = null ;
    before(async () => {
        bidder = await Bidder.deployed() ;
    });

    it("Setting the Bidder - Positive" ,async () => {
        await bidder.setBidder("Aniket" , 5550) ;
        const name = await bidder.bidderName() ;
        const amount = await bidder.bidAmount();
        const eligible = await bidder.displayEligibility() ;

        assert(name === "Aniket");
        assert(amount.toNumber() === 5550);
        assert(eligible === true) ;
    });

    it("Setting the Bidder - Negative" ,async () => {
            await bidder.setBidder("Aniket" , 4999) ;
            const name = await bidder.bidderName() ;
            const amount = await bidder.bidAmount();
            const eligible = await bidder.displayEligibility() ;

            assert(name === "Aniket");
            assert(amount.toNumber() === 4999);
            assert(eligible === false) ;
        });
});