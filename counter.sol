// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract Counter {
    uint public count;
     constructor () {
        count = 0;
     }

     function add(uint x) public {
        count += x;
     }

}