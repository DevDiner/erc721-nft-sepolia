// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("MyToken2", "MTK2") {
        // Mint the initial supply (remember: supply should be in wei, i.e. include 18 decimals).
        _mint(msg.sender, initialSupply);
    }
}
