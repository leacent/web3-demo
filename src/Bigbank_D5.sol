// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Bank_D4.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BigBank is Bank, Ownable {
    modifier onlyValidAmount() {
        require(msg.value > 0.001 ether, "Deposit amount must be greater than 0.001 ether");
        _;
    }

    function deposit() external payable onlyValidAmount {
        super.deposit();
    }

    function withdraw(uint256 amount) external onlyOwner {
        super.withdraw(amount);
    }
}