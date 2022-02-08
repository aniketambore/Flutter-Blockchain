// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0 ;

contract Population{
    string public countryName ;
    uint public currentPopulation ;

    constructor(){
        countryName = "Unknown" ;
        currentPopulation = 0 ;
    }

    function set(string memory name, uint populationCount) public{
        countryName = name ;
        currentPopulation = populationCount ;
    }

    function decrement(uint decrementBy) public{
        currentPopulation -= decrementBy ;
    }

    function increment(uint incrementBy) public{
        currentPopulation += incrementBy ;
    }
}