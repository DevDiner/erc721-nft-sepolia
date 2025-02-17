// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract RewardToken is ERC20 {
    // The address allowed to mint new tokens (typically the staking contract).
    address public minter;
    
    constructor() ERC20("RewardToken", "RWT") {
        minter = msg.sender;
    }
    
    // Only the designated minter can mint new tokens.
    function mint(address to, uint256 amount) external {
        require(msg.sender == minter, "Not authorized to mint");
        _mint(to, amount);
    }
    
    // Update the minter (for example, to set the staking contract as the authorized minter).
    function updateMinter(address newMinter) external {
        require(msg.sender == minter, "Only current minter can update");
        minter = newMinter;
    }
}
