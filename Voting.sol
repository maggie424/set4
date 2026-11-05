// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Voting {

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public hasVoted;

    uint public candidatesCount;

    constructor() {
        candidatesCount = 3;

        candidates[1] = Candidate(1, "Candidate A", 0);
        candidates[2] = Candidate(2, "Candidate B", 0);
        candidates[3] = Candidate(3, "Candidate C", 0);
    }

    function vote(uint _candidateId) public {
        require(!hasVoted[msg.sender], "Already voted");

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
