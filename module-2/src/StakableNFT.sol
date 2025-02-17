// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract StakableNFT is ERC721Enumerable, Ownable {
    uint256 public tokenCounter;
    string private baseTokenURI;

    constructor(string memory baseURI) ERC721("StakableNFT", "SNFT") {
        baseTokenURI = baseURI;
        tokenCounter = 0;
    }
    
    // Only the owner (or an authorized account) can mint new NFTs.
    function safeMint(address to) external onlyOwner {
        tokenCounter++;
        _safeMint(to, tokenCounter);
    }
    
    // Override _baseURI for metadata.
    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }
    
    // Owner can update base URI.
    function setBaseURI(string calldata baseURI) external onlyOwner {
        baseTokenURI = baseURI;
    }
}
