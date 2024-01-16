// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity  ^0.8.0;

contract Bank {
    address public admin;
    mapping(address => uint256) public balances;
    address[] public topThree;

    constructor () {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    function deposit() external payable {
        require(msg.value > 0, "Deposit value must greater than 0");
        balances[msg.sender] += msg.value;
    }

    function withdraw() external onlyAdmin {
        uint totalbalance = address(this).balance;

        require(totalbalance > 0, 'No balance available for whithdraw');

        (bool success, ) = msg.sender.call{value: totalbalance}("");

        require(success, "Withdraw failed");
        

    }

}