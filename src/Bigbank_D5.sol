// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";

contract BigBank is Ownable {
    mapping(address => uint256) private balances;
    uint256 private minimumDepositAmount = 0.001 ether;

    event Deposit(address indexed account, uint256 amount);
    event Withdrawal(address indexed account, uint256 amount);

     constructor() Ownable(msg.sender){
     }

    modifier minimumDeposit() {
        require(msg.value >= minimumDepositAmount, "Minimum deposit amount not met");
        _;
    }

    function deposit() external payable minimumDeposit {
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external onlyOwner {
        require(amount <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    function getBalance(address account) external view returns (uint256) {
        return balances[account];
    }

    function setMinimumDepositAmount(uint256 amount) external onlyOwner {
        minimumDepositAmount = amount;
    }
}