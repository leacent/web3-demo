// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract LeacentNFT is ERC721 {
    // _tokenIdCounter记录NFT的id
    uint256 private _tokenIdCounter;
    constructor () ERC721('Leacent', 'leacent') {
    }

    function mint(address to) external returns(uint256) {
        _tokenIdCounter++;
        uint256 newId = _tokenIdCounter;
        _mint(to, newId);
        return newId;
    }
}



