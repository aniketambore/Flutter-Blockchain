pragma solidity ^0.5.9 ;

contract Auth{
    struct Credentials{
        string fullName ;
        string email ;
        string password;
    }

    mapping(string => Credentials) credential ;

    function createAccount(string memory name, string memory pass, string memory mail) public{
        credential[mail].fullName = name ;
        credential[mail].email = mail ;
        credential[mail].password = pass ;
    }

    function loginAccount(string memory mail,string memory pass) public view returns(string memory){
        if(keccak256(abi.encodePacked(credential[mail].password)) == keccak256(abi.encodePacked(pass))){
            return string(abi.encodePacked(credential[mail].fullName , credential[mail].email));
        } else{
            return "Wrong Password" ;
        }

    }


}