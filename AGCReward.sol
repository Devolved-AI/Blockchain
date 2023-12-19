// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract RewardContract is Ownable, ReentrancyGuard {
    IERC20 public immutable agcToken;

    uint256 public constant MAX_REWARD_AMOUNT = 500*10**18;
    uint public constant MAX_TAX=0;

    event UserRewarded(address indexed user, uint256 amount);
    constructor(address _agcTokenAddress) Ownable(msg.sender) {
        agcToken = IERC20(_agcTokenAddress);
    }
    function rewardUser(address user, uint256 amount) external nonReentrant {
        require(amount > 0 && amount <= MAX_REWARD_AMOUNT, "Amount must be greater than zero and less than or equal to 500");
        require(agcToken.balanceOf(address(this)) >= amount, "Insufficient funds");
        agcToken.transfer(user, amount);
        emit UserRewarded(user, amount);
    }
    function checkBalance() external view returns (uint256) {
        return agcToken.balanceOf(address(this));
    }
}