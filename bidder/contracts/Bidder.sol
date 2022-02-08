// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0 ;

contract Bidder{
    string public bidderName;
    uint public bidAmount;
    uint public minBidAmount = 1000 ;

    function setBidder(string memory name,uint amount) public{
        bidderName = name ;
        bidAmount = amount ;
    }

    function displayEligibility() public view returns(bool){
        if(bidAmount >= minBidAmount) return true;
        else return false;
    }
}