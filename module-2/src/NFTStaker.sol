// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

// Minimal interface for the stakable NFT.
interface IStakableNFT {
    function transferFrom(address from, address to, uint256 tokenId) external;
}

// Minimal interface for the reward token.
interface IRewardToken {
    function mint(address to, uint256 amount) external;
}

contract NFTStaker is IERC721Receiver {
    IStakableNFT public nft;
    IRewardToken public rewardToken;
    
    // Reward: 10 tokens per interval (with 18 decimals).
    uint256 public constant REWARD_AMOUNT = 10 * (10 ** 18);
    // Reward interval: 24 hours (change to a shorter time for testing if needed).
    uint256 public constant REWARD_INTERVAL = 24 hours;
    
    // Structure to record staking details.
    struct StakeInfo {
        address staker;
        uint256 lastClaimTime;
    }
    // Mapping from NFT tokenId to its staking info.
    mapping(uint256 => StakeInfo) public stakes;
    
    constructor(address nftAddress, address rewardTokenAddress) {
        nft = IStakableNFT(nftAddress);
        rewardToken = IRewardToken(rewardTokenAddress);
    }
    
    // Stake an NFT by transferring it to the staking contract.
    function stakeNFT(uint256 tokenId) external {
        // Transfer NFT from the user to this contract.
        nft.transferFrom(msg.sender, address(this), tokenId);
        // Record staking information.
        stakes[tokenId] = StakeInfo({
            staker: msg.sender,
            lastClaimTime: block.timestamp
        });
    }
    
    // Claim ERC20 rewards for a staked NFT if the reward interval has passed.
    function claimReward(uint256 tokenId) external {
        StakeInfo storage info = stakes[tokenId];
        require(info.staker == msg.sender, "Not the staker");
        require(block.timestamp >= info.lastClaimTime + REWARD_INTERVAL, "Reward not available yet");
        
        // Update the last claim time to prevent bypassing the timer.
        info.lastClaimTime = block.timestamp;
        
        // Mint reward tokens to the staker.
        rewardToken.mint(msg.sender, REWARD_AMOUNT);
    }
    
    // Unstake the NFT, claim reward if any, and remove its staking record.
    function unstakeNFT(uint256 tokenId) external {
        StakeInfo storage info = stakes[tokenId];
        require(info.staker == msg.sender, "Not the staker");

        // Claim rewards before unstaking.
        if (block.timestamp >= info.lastClaimTime + REWARD_INTERVAL) {
            this.claimReward(tokenId);
        }
        
        // Clear the staking record.
        delete stakes[tokenId];
        
        // Transfer the NFT back to its owner.
        nft.transferFrom(address(this), msg.sender, tokenId);
    }

    // Override onERC721Received to handle receiving NFTs.
    function onERC721Received(
        address operator, 
        address from, 
        uint256 tokenId, 
        bytes calldata data
    ) external override returns (bytes4) {
        // Ensure only the correct NFT contract is sending the tokens.
        require(msg.sender == address(nft), "Invalid NFT contract");

        // The NFT is successfully received, log or process it as needed. ( .selector)
        return this.onERC721Received.selector;
    }
}
