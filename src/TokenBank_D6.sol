// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenBank is Ownable {
    IERC20 private token;
    mapping(address => uint256) public balances;
    // 使用openzeppelin库的安全转账方法
    using SafeERC20 for IERC20;

    event TokenDeposited(address indexed user, uint256 amount);
    event AdminTokenWithdrawn(uint256 amount);

    constructor (address tokenAddr) Ownable(msg.sender){
        token = IERC20(tokenAddr);
    }

    function deposit(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        // safeTransferFromOpenZeppelin 的 SafeERC20 库中的一个函数，
        // 它是对 ERC20 合约中的 transferFrom 函数的增强版本。
        token.safeTransferFrom(msg.sender, address(this), amount);
        balances[msg.sender] += amount;
        emit TokenDeposited(msg.sender, amount);
    }

    function withdraw() external onlyOwner {
        // 该token合约的余额
        uint256 balanceOf = token.balanceOf(address(this));
        require(balanceOf > 0, "No balance left");
        token.transfer(owner(), balanceOf);

        emit AdminTokenWithdrawn(balanceOf);
    }

    function getUserBalance(address userAddr) external view returns(uint256) {
        return balances[userAddr];
    }
}




