pragma solidity ^0.5.9 ;

contract CatAdoption{
    address[5] public adopters ;

    function adopt(uint catId, address adopter) public returns(uint){
        require(catId>=0 && catId<=4) ;
        adopters[catId] = adopter ;
        return catId ;
    }

    function getAdopters() public view returns(address[5] memory){
        return adopters ;
    }
}