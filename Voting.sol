// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Voting {

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    address public owner;

    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public hasVoted;

    uint public candidatesCount;

    constructor() {
        owner = msg.sender;
        addCandidate("Candidate A");
        addCandidate("Candidate B");
        addCandidate("Candidate C");
    }

    function addCandidate(string memory _name) public {
        require(msg.sender == owner, "Only owner can add candidates");

        candidatesCount++;

        candidates[candidatesCount] = Candidate(
            candidatesCount,
            _name,
            0
        );
    }

    function vote(uint _candidateId) public {
        require(!hasVoted[msg.sender], "You have already voted");
        require(_candidateId > 0 && _candidateId <= candidatesCount,
        "Invalid candidate");

        candidates[_candidateId].voteCount++;

        hasVoted[msg.sender] = true;
    }

    function getCandidate(uint _id)
        public view returns (uint, string memory, uint) {

        Candidate memory c = candidates[_id];

        return (c.id, c.name, c.voteCount);
    }
}
