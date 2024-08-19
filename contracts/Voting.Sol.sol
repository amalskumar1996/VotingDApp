// SPDX-License-Identifier: MIT
// This line specifies the license under which the code is released. 
// "MIT" is a popular open-source license.
pragma solidity ^0.8.0;
// This line specifies the version of Solidity that the contract is compatible with. 
// Here, it's set to version 0.8.0 or higher.

contract Voting {
    // Define a structure to represent a candidate in the election.
    struct Candidate {
        string name;  // The name of the candidate.
        uint voteCount;  // The number of votes the candidate has received.
    }

    // Mapping to store candidates by their ID. 
    // `uint` is the candidate ID, and `Candidate` is the structure holding the candidate's information.
    mapping(uint => Candidate) public candidates;

    // Mapping to keep track of voters who have already voted.
    // `address` is the voter's address, and `bool` indicates whether the voter has voted.
    mapping(address => bool) public voters;

    // Variable to keep track of the number of candidates in the election.
    uint public candidatesCount;

    // The constructor function is executed once when the contract is deployed.
    // It initializes the contract with two candidates.
    constructor() {
        addCandidate("Alice");
        addCandidate("Bob");
    }

    // Function to add a new candidate to the election.
    // This function is private and can only be called within the contract.
    function addCandidate(string memory name) private {
        candidates[candidatesCount] = Candidate(name, 0);
        candidatesCount++;
    }

    // Function to allow a user to vote for a candidate.
    // `candidateId` specifies which candidate the user is voting for.
    function vote(uint candidateId) public {
        // Ensure the user has not already voted.
        require(!voters[msg.sender], "You have already voted.");

        // Ensure the candidate ID is valid.
        require(candidateId >= 0 && candidateId < candidatesCount, "Invalid candidate ID.");

        // Mark the user as having voted.
        voters[msg.sender] = true;

        // Increment the vote count for the selected candidate.
        candidates[candidateId].voteCount++;
    }

    // Function to retrieve information about a candidate.
    // `candidateId` specifies which candidate's information to retrieve.
    function getCandidate(uint candidateId) public view returns (string memory, uint) {
        // Ensure the candidate ID is valid.
        require(candidateId >= 0 && candidateId < candidatesCount, "Invalid candidate ID.");
        
        // Return the candidate's name and vote count.
        return (candidates[candidateId].name, candidates[candidateId].voteCount);
    }
}
