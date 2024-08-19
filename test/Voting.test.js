const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Voting Contract", function () {
    let Voting;
    let voting;
    let owner;

    beforeEach(async function () {
        // Get the ContractFactory and Signers
        Voting = await ethers.getContractFactory("Voting");
        [owner] = await ethers.getSigners();

        // Deploy the contract
        voting = await Voting.deploy();
        await voting.deployed(); // Wait for the contract to be deployed
    });

    it("Should initialize with two candidates", async function () {
        // Check the number of candidates
        expect(await voting.candidatesCount()).to.equal(2);
    });

    it("Should allow a user to vote and increase the vote count", async function () {
        // Cast a vote for candidate 0
        await voting.vote(0);
        const candidate = await voting.getCandidate(0);
        expect(candidate[1]).to.equal(1); // Vote count should be 1
    });

    it("Should prevent double voting", async function () {
        // Cast a vote for candidate 0
        await voting.vote(0);
        // Try to vote again from the same account
        await expect(voting.vote(0)).to.be.revertedWith("You have already voted.");
    });

    it("Should reject votes for invalid candidate IDs", async function () {
        // Try to vote for a non-existing candidate
        await expect(voting.vote(3)).to.be.revertedWith("Invalid candidate ID.");
    });
});
