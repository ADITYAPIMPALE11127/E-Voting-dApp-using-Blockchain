// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Election {
    struct Candidate {
        uint id;
        string name;
    }

    mapping(address => bool) public voters;
    Candidate[] public candidates; // Use an array for candidates
    mapping(uint => uint) public candidateVoteCounts; // Separate counters for each candidate

    event VotedEvent(uint indexed _candidateId);

    constructor() {
        addCandidate("BJP");
        addCandidate("Congress");
    }

    function addCandidate(string memory _name) private {
        candidates.push(Candidate(candidates.length, _name));
    }

    function vote(uint _candidateId) public {
        require(!voters[msg.sender], "You have already voted in this election.");
        require(_candidateId < candidates.length, "Invalid candidate ID");

        voters[msg.sender] = true;
        candidateVoteCounts[_candidateId]++; // Update the separate vote count for the candidate
        emit VotedEvent(_candidateId);
    }

    function getVoteCountForCandidate(uint _candidateId) public view returns (uint) {
        require(_candidateId < candidates.length, "Invalid candidate ID");
        return candidateVoteCounts[_candidateId];
    }
}
