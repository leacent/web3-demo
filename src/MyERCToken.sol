// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        // 设置代币总供应量，例如 1000000
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function getBalance (address addr) external view returns (uint256){
        return balanceOf(addr);
    }
}