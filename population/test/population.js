const Population = artifacts.require("Population") ;

contract("Population" , () =>{
    let population = null ;
    before(async () => {
        population = await Population.deployed() ;
    });

    it("Setting Current Population" , async () => {
        await population.set("India" , 1388901219) ;
        const name = await population.countryName() ;
        const pop = await population.currentPopulation();
        assert(name === "India") ;
        assert(pop.toNumber() === 1388901219) ;
    });

    it("Decrement Current Population" , async () => {
        await population.decrement(100) ;
        const pop = await population.currentPopulation() ;
        assert(pop.toNumber() === 1388901119);
    });

    it("Increment Current Population" , async () => {
            await population.increment(200) ;
            const pop = await population.currentPopulation() ;
            assert(pop.toNumber() === 1388901319);
        });
});
