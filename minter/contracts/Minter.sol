pragma solidity ^0.5.9 ;

contract Minter{
    address public minter ;
    mapping(address => uint) public balance ;

    event Sent(address from,address to,uint amount) ;

    constructor() public{
        minter = msg.sender ;
    }

    function mint(address receiver, uint amount) public{
        if(msg.sender != minter) revert() ;
        balance[receiver] += amount ;
    }

    function send(address sender, address receiver, uint amount) public{
        if(balance[sender] < amount) revert() ;
        balance[sender] -= amount ;
        balance[receiver] += amount ;
        emit Sent(sender,receiver,amount) ;
    }
}