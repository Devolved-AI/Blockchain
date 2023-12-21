// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AGCToken is ERC20,Ownable {
    constructor(address initialOwner) ERC20("Argocoin", "AGC") Ownable(initialOwner) {
    _mint(msg.sender, 200000000 * 10**18); 
}

    function lock(address account, uint256 amount) external {
        _transfer(msg.sender, address(this), amount);
        emit Locked(account, amount);
    }

    function unlock(address account, uint256 amount) external {
        require(balanceOf(address(this)) >= amount, "Not enough locked tokens");
        _transfer(address(this), account, amount);
        emit Unlocked(account, amount);
    }

    event Locked(address indexed account, uint256 amount);
    event Unlocked(address indexed account, uint256 amount);
}
