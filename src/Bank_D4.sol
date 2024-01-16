// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {
    address public admin;
    address[3] public topThreeDepositors;
    mapping(address => uint256)public deposits;

    constructor () {
        // constructor只会执行一次，这里确定了admin，并给到后面onlyAdmin使用。
        admin = msg.sender;
    }

    function deposit() external payable {
        require(msg.value > 0, "Deposit value must be greater than 0");
        deposits[msg.sender] += msg.value;
    }

    modifier onlyAdmin() {
        require(admin == msg.sender, "Only admin can whthdraw");
        _;
    }

    function withdraw(uint256 amount) external onlyAdmin {
        require(amount  > 0, "Withdrawal amount must be greater than 0");
        require(address(this).balance >= amount, "Insufficient balance.");
        // 将admin地址标记为可接受ETH的地址
        payable (admin).transfer(amount * 1 ether);
    }

    function getAccountBalance() external view returns(uint256) {
        return address(this).balance;
    }
}
