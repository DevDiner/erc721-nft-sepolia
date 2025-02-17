// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Minimal interface for ERC20 token transfer.
interface IERC20Token {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

// Minimal interface for NFT minting.
interface IERC721Mintable {
    function safeMint(address to) external;
}

contract NFTMinterWithERC20 {
    IERC20Token public erc20Token;
    IERC721Mintable public nft;
    
    // Price: 10 tokens, with 18 decimals.
    uint256 public constant PRICE = 10 * (10 ** 18);
    
    constructor(address erc20Address, address nftAddress) {
        erc20Token = IERC20Token(erc20Address);
        nft = IERC721Mintable(nftAddress);
    }
    
    // Users must approve this contract to spend 10 tokens before calling mintNFT.
    function mintNFT() external {
        // Transfer 10 ERC20 tokens from the user to this contract.
        bool sent = erc20Token.transferFrom(msg.sender, address(this), PRICE);
        require(sent, "ERC20 token transfer failed");
        
        // Mint an NFT to the sender.
        nft.safeMint(msg.sender);
    }
}
