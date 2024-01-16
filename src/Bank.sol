// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {
    uint256 public balance;
    
    event Deposit(address indexed depositor, uint256 amount);
    event Withdraw(address indexed recipient, uint256 amount);

    function deposit() public payable{
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balance += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw() public payable {
        require(msg.value > 0.1 ether, "Insufficient balance");
        balance -= 0.1 ether;
        payable(msg.sender).transfer(0.1 ether);
        emit Withdraw(msg.sender, 0.1 ether);
    }
}
