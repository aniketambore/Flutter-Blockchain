pragma solidity ^0.5.9 ;

contract Election{
    struct Voter{
        uint weight ;
        uint8 vote ;
        bool isVoted ;
    }

    address public chairperson ;
    mapping(address => Voter) voters ;
    uint[4] proposals ;

    // modifier onlyOwner(){
    //     require(msg.sender == chairperson);
    //     _;
    // }

    constructor() public{
        chairperson = msg.sender ;
        voters[chairperson].weight = 1 ;
        voters[chairperson].isVoted = false ;
    }

    function Register(address toVoter,address registerer) public {
        if(voters[toVoter].isVoted || registerer != chairperson) revert() ;
        voters[toVoter].isVoted = false ;
        voters[toVoter].weight = 1 ;
    }

    function Vote(uint8 toProposal, address voterAddr) public{
        Voter memory sender = voters[voterAddr] ;
        if(sender.isVoted || toProposal>proposals.length || sender.weight == 0) revert() ;
        sender.isVoted = true ;
        sender.vote = toProposal ;
        proposals[toProposal] += sender.weight ;
    }

    function Winner() public view returns(uint _winningProposal){
        uint winningVoteCount = 0 ;
        for(uint prop=0;prop<4;prop++){
            if(proposals[prop] > winningVoteCount){
                winningVoteCount = proposals[prop] ;
                _winningProposal = prop ;
            }
        }
    }
}