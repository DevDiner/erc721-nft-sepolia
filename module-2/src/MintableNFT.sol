// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MintableNFT is ERC721Enumerable, Ownable {
    uint256 public tokenCounter;
    string private baseTokenURI;

    constructor(string memory baseURI) ERC721("MintableNFT", "MINT") {
        baseTokenURI = baseURI;
        tokenCounter = 0;
    }
    
    // Only the owner (i.e. the minting contract) can mint new NFTs.
    function safeMint(address to) external onlyOwner {
        tokenCounter++;
        _safeMint(to, tokenCounter);
    }
    
    // Override the _baseURI function for metadata hosting.
    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }
    
    // Allow the owner to update the base URI.
    function setBaseURI(string calldata baseURI) external onlyOwner {
        baseTokenURI = baseURI;
    }
}
