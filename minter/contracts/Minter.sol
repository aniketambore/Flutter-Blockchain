// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0 ;

contract Minter{
    address public minter ;
    mapping(address => uint) public balance ;

    // Events allow light client to react on changes effectively
    event Sent(address from, address to, uint amount) ;

    constructor(){
        minter = msg.sender ;
        
    }

    function mint(address receiver, uint amount) public{
        if(msg.sender != minter) return ;
        balance[receiver] += amount ;
    }

    function send(address sender, address receiver, uint amount) public{
        if(balance[sender] < amount) revert() ;
        balance[sender] -= amount ;
        balance[receiver] += amount ;
        emit Sent(sender,receiver,amount) ;
    }
}