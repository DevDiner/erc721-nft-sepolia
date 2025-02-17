// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FreeMintNFT is ERC721Enumerable, Ownable {
    uint256 public constant MAX_SUPPLY = 10;
    string private baseTokenURI;
    
    constructor(string memory baseURI) ERC721("FreeMintNFT", "FMNFT") {
        baseTokenURI = baseURI;
    }
    
    // Public mint function; no cost.
    function mint() external {
        require(totalSupply() < MAX_SUPPLY, "Max supply reached");
        uint256 tokenId = totalSupply() + 1;  // token IDs start at 1
        _safeMint(msg.sender, tokenId);
    }
    
    // Optionally override baseURI for OpenSea
    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }
    
    // Owner can update base URI if needed
    function setBaseURI(string calldata baseURI) external onlyOwner {
        baseTokenURI = baseURI;
    }
}
