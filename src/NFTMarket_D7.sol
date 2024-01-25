// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";

contract NFTMarket {
    using Math for uint256;
    
    IERC20 private LeacentToken;
    mapping(uint256 => uint) private nftPrices;
    mapping(uint256 => bool) private isNFTListed;

    constructor (address tokenAddress) {
        LeacentToken = IERC20(tokenAddress);
    }

    function listNFT(uint256 tokenId, uint256 price) external {
        require(price > 0, "Price must be greater than zero");
        require(!isNFTListed[tokenId], "NFT already listed");

        isNFTListed[tokenId] = true;
        // 上架的token并且指定价格。
        nftPrices[tokenId] = price;
    }

    function buyNFT(uint256 tokenId, uint256 amount) external {
        require(isNFTListed[tokenId], "NFT not listed");
        
        uint256 price = nftPrices[tokenId];
        require(amount >= price, "Insufficient funds");
        // 购买者的代币token转移到NFTMarket市场，price是转移的数量也是NFT上架的价格
        LeacentToken.transferFrom(msg.sender, address(this), price);
        // NFT从NFTMarket转移到合约调用者（即购买者）
        IERC721(msg.sender).safeTransferFrom(address(this), msg.sender, tokenId);

        // 重置条件
        isNFTListed[tokenId] = false;
        nftPrices[tokenId] = 0;
    }
}