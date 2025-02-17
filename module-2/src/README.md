# NFT + ERC20 Portfolio on Sepolia

This repository provides **three different NFT demos** on the **Sepolia testnet**:

1. [**FreeMint NFT**](#1-freemint-nft)  
2. [**Mintable NFT (with ERC20 payment)**](#2-mintable-nft-with-erc20-payment)  
3. [**Staking NFT**](#3-staking-nft)

Each demo uses **Sepolia** for minimal gas costs. You can get test ETH from the official [**Google Sepolia Faucet**](https://cloud.google.com/application/web3/faucet/ethereum/sepolia).

---

## Getting Started

1. **Get Sepolia ETH**  
   - [Google Sepolia Faucet](https://cloud.google.com/application/web3/faucet/ethereum/sepolia)  
   - Paste your wallet address, receive free test ETH for gas.  

2. **Interact via Etherscan**  
   - After deploying each contract, you can go to **Sepolia Etherscan** and verify.  
   - Use the **“Contract”** tab → **“Write Contract”** → **Connect to Web3** to call functions directly.  

3. **View on OpenSea**  
   - Head to [testnets.opensea.io](https://testnets.opensea.io/)  
   - Paste your NFT contract address in the search bar.  
   - If recently minted, click “Refresh Metadata” for the item.

---

## 1. FreeMint NFT

### Overview
- An **ERC721** contract where **anyone** can call `mint()` at **no cost** (beyond gas).  
- Supply is capped at 10 tokens.  
- Metadata is hosted off‐chain (e.g., IPFS).


### How to Use (Etherscan)
1. **Go to Contract Address** on Sepolia Etherscan.  
2. **Write Contract** → `mint()`.  
3. Pay only gas.  
4. Check your new NFT on OpenSea testnets.  

---

## 2. Mintable NFT (With ERC20 Payment)

### Overview
- An **ERC721** that **requires 10 ERC20 tokens** to mint an NFT.  
- We have:
  - **`MyToken`** (ERC20) with 18 decimals.  
  - **`NFTMinterWithERC20`** contract that collects 10 tokens and calls `_safeMint(...)` on an NFT contract.

### How to Use
1. **Deploy `MyToken`**, `MintableNFT`, `NFTMinterWithERC20`.  
2. **Transfer ownership** of `MintableNFT` to the `NFTMinterWithERC20` contract, so it can call `safeMint(...)`.  
3. **Give** the user some `MyToken`.  
4. **User calls** `MyToken.approve(NFTMinterWithERC20Address, 10000000000000000000)`.  
5. **Then** calls `mintNFT()` in the minter contract.  
6. **10 tokens** are transferred from user to minter. The user receives a new NFT.  

---

## 3. Staking NFT

### Overview
- Stake an NFT by sending it to the contract.  
- Earn **10 Reward Tokens** every 24 hours.  
- Unstake at any time, but only the original staker can withdraw.

### How to Use
1. **Deploy `RewardToken`**, `StakableNFT`, `NFTStaker`.  
2. **Set** the `RewardToken` minter to the `NFTStaker` address:  
   ```solidity
   RewardToken.updateMinter(nftStakerAddress);
   ```
3. **Mint** some `StakableNFT`s to users.  
4. **User** calls `StakableNFT.approve(nftStakerAddress, tokenId)` or `setApprovalForAll`.  
5. **User calls** `stakeNFT(tokenId)`.  
6. Wait 24 hours, **claimReward(tokenId)**.  
7. **unstakeNFT(tokenId)** any time.

For faster testing, set `REWARD_INTERVAL = 60` (seconds) or another short timeframe.

---

## License

All contracts use the **MIT License**.  
