# NFT + ERC20 Portfolio on Sepolia

This repository provides **three different NFT demos** on the **Sepolia testnet**:

1. [**FreeMint NFT**](#1-freemint-nft)  
2. [**Mintable NFT (with-erc20-payment)**](#2-mintable-nft-with-erc20-payment)  
3. [**Staking NFT**](#3-staking-nft)

Each demo uses **Sepolia** for minimal gas costs. You can get test ETH from the official [**Google Sepolia Faucet**](https://cloud.google.com/application/web3/faucet/ethereum/sepolia).

---

## Deployed Addresses (Sepolia Testnet)

- **FreeMintNFT:** [0x6EF38EAD9592D9E9Ac54bf574Fe615e30cDFCca9](https://sepolia.etherscan.io/address/0x6EF38EAD9592D9E9Ac54bf574Fe615e30cDFCca9#writeContract)  
- **MyToken (ERC20):** [0x50346b8E06Bb2c329209a4af6aC18859fa1De2E6](https://sepolia.etherscan.io/address/0x50346b8E06Bb2c329209a4af6aC18859fa1De2E6#writeContract)  
- **MintableNFT:** [0xaB735c98c79204557dbaAb3f17938BaBE42586A4](https://sepolia.etherscan.io/address/0xaB735c98c79204557dbaAb3f17938BaBE42586A4#writeContract)  
- **NFTMinterWithERC20:** [0xA22307eae392961305b7509Be39E414260acEcC4](https://sepolia.etherscan.io/address/0xa22307eae392961305b7509be39e414260acecc4#writeContract)  
- **RewardToken:** [0xb28B4d8524fa0Bf2Ec35Ee67C0ab9f72d06E88F2](https://sepolia.etherscan.io/address/0xb28B4d8524fa0Bf2Ec35Ee67C0ab9f72d06E88F2#writeContract)  
- **StakableNFT:** [0x99ef2cE8233ea69dd950e20E02224FC3008bfc8E](https://sepolia.etherscan.io/address/0x99ef2cE8233ea69dd950e20E02224FC3008bfc8E#writeContract)  
- **NFTStaker:** [0xEaFb0e54d9028766Dd2e6D694963486802149F13](https://sepolia.etherscan.io/address/0xEaFb0e54d9028766Dd2e6D694963486802149F13#writeContract)  

---

## Getting Started

1. **Get Sepolia ETH**  
   - Use the [**Google Sepolia Faucet**](https://cloud.google.com/application/web3/faucet/ethereum/sepolia).  
   - Paste your wallet address, receive free test ETH for gas.

2. **Interact via Etherscan**  
   - Click the link(s) above to go to each contract’s page on **Sepolia Etherscan**.  
   - Under the **“Contract”** tab → **“Write Contract”** → **Connect to Web3** to call functions (e.g. mint, stake, etc.) directly from your wallet.

3. **View on OpenSea**  
   - Head to [testnets.opensea.io](https://testnets.opensea.io/).  
   - Paste your **NFT contract address** in the search bar.  
   - If you just minted a token, click “Refresh Metadata” on the item page to see updated images and traits.

---

## 1. FreeMint NFT

### Overview

- An **ERC721** contract where **anyone** can call `mint()` at **no cost** (only pay gas).  
- Supply is capped at 10 tokens.  
- Metadata is hosted off‐chain (e.g., IPFS).

### How to Use (Etherscan)

1. **Visit the FreeMintNFT address** on Sepolia Etherscan.  
2. Go to **Write Contract** → `mint()`.  
3. Confirm the transaction (just gas cost, no fee).  
4. After success, check your wallet or view on **OpenSea** testnet.

---

## 2. Mintable NFT (With ERC20 Payment)

### Overview

- An **ERC721** that **requires 10 ERC20 tokens** to mint an NFT.  
- Utilizes:
  - **`MyToken`** (ERC20) with 18 decimals.  
  - **`NFTMinterWithERC20`** contract that charges 10 tokens and then calls `_safeMint(...)` on the **`MintableNFT`**.

### How to Use

1. **Deploy** or use the provided addresses for:
   - `MyToken`
   - `MintableNFT`
   - `NFTMinterWithERC20`
2. **Transfer ownership** of `MintableNFT` to `NFTMinterWithERC20`, allowing it to call `safeMint(...)` (since `onlyOwner`).  
3. **Fund** users with `MyToken`.  
4. **Approve** 10 tokens from the user’s account:
   ```solidity
   MyToken.approve(NFTMinterWithERC20Address, 10e18);
   ```
5. Call **`mintNFT()`** in `NFTMinterWithERC20`.  
6. **10 tokens** move from user → contract; user receives a new NFT.

---

## 3. Staking NFT

### Overview

- Stake an NFT by transferring it to the staking contract.  
- Earn **10 Reward Tokens** every 24 hours.  
- Unstake any time; only the original staker can withdraw.

### How to Use

1. **Deploy** or reference:
   - `RewardToken`
   - `StakableNFT`
   - `NFTStaker`
2. **Set** `RewardToken` minter to `NFTStaker`:
   ```solidity
   RewardToken.updateMinter(nftStakerAddress);
   ```
3. **Mint** some `StakableNFT` tokens to users.  
4. **User** approves the Staking contract for their NFT:
   ```solidity
   StakableNFT.approve(nftStakerAddress, tokenId);
   ```
   or  
   ```solidity
   StakableNFT.setApprovalForAll(nftStakerAddress, true);
   ```
5. Call **`stakeNFT(tokenId)`** on the `NFTStaker`.  
6. Wait **24 hours** (or whatever `REWARD_INTERVAL` is set to), call **`claimReward(tokenId)`**.  
7. **Unstake** the NFT any time with **`unstakeNFT(tokenId)`**.

If testing, you can shorten `REWARD_INTERVAL` to, say, **60 seconds** for quick demos.

---

## License

All contracts are released under the **MIT License**.
