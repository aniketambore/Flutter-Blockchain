pragma solidity ^0.5.9 ;

contract Bidder{
    string public bidderName ;
    uint public bidAmount ;
    uint public minBid = 5000;


    function setBidder(string memory nm, uint amount) public{
        bidderName = nm ;
        bidAmount = amount ;
    }

    function displayEligibility() public view returns(bool){
        if(bidAmount >= minBid) return true ;
        else return false ;
    }
}