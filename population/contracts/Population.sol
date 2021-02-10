pragma solidity^0.5.9 ;

contract Population{
    string public countryName ;
    uint public currentPopulation ;

    constructor() public{
        countryName = "Unknown" ;
        currentPopulation = 0 ;
    }

    function set(string memory name, uint popCount) public{
        countryName = name ;
        currentPopulation = popCount ;
    }

    function decrement(uint decrementBy) public{
        currentPopulation -= decrementBy ;
    }


    function increment(uint incrementBy) public{
        currentPopulation += incrementBy ;
    }

}