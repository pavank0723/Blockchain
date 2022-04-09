//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.0 < 0.9.0;

contract ElectionSetu{
    
    struct Candidate{
        string name;
        uint numVote;
    }

    struct Election{
        string name;
    }

    struct Voter{
        string name;
        bool isAuthorised;
        uint whom; 
        bool isVoted;
    }
    
    address public owner;
    string public electionName;

    mapping(address => Voter) public voters;
    
    Candidate[] public candidates;
    Election[] public elections;
    uint public totalVotes;

    modifier ownerOnly(){
        require(msg.sender == owner);
        _;
    }

    function startElection(string memory _electionName) public{
        owner = msg.sender;
        elections.push(Election(_electionName));
    }

    function addCandidate(string memory _candidateName) ownerOnly public{
        candidates.push(Candidate(_candidateName, 0));
    }

    function authorizeVoter(address _voterAddress ) ownerOnly public{
        voters[_voterAddress].isAuthorised = true;
    }

    function getNumOfCandidate() public view returns(uint){
        return candidates.length;
    }
    function getNumOfElection() public view returns(uint){
        return elections.length;
    }

    function vote(uint candidateIndex) public{
        require(!voters[msg.sender].isVoted);
        require(voters[msg.sender].isAuthorised);
        voters[msg.sender].whom = candidateIndex;
        voters[msg.sender].isVoted = true;

        candidates[candidateIndex].numVote++;
        totalVotes++;
    }
    
    function getTotalVotes()public view returns(uint) {
        return totalVotes;
    }

    function candidateInfo(uint index) public view returns(Candidate memory){ 
        return candidates[index];
    }

    function electionInfo(uint index) public view returns(Election memory){ 
        return elections[index];
    }

    function getCandidates() public view returns(Candidate[] memory){
        return candidates;
    }
}