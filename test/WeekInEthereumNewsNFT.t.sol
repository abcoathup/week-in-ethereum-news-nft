// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/WeekInEthereumNewsNFT.sol";

contract WeekInEthereumNewsNFTTest is Test {
    WeekInEthereumNewsNFT public token;

    string public constant NAME = "Week in Ethereum News";
    string public constant SYMBOL = "WIEN";

    function setUp() public {
        token = new WeekInEthereumNewsNFT();
    }

    function testMetadata() public {
        assertEq(token.name(), NAME);
        assertEq(token.symbol(), SYMBOL);
    }

    function testMint(address to) public {
        vm.assume(to != address(0));
        vm.assume(to != address(this));
        vm.assume(to != address(token));
        uint256 tokenId = token.totalSupply();

        token.mint(to);

        assertEq(token.balanceOf(to), 1);
        assertEq(token.ownerOf(tokenId), to);
    }

    function testMintNotOwner(address notOwner, address to) public {
        vm.assume(to != address(0));
        vm.assume(notOwner != address(this));
        uint256 tokenId = token.totalSupply();

        vm.prank(notOwner);
        vm.expectRevert("Ownable: caller is not the owner");
        token.mint(to);

        assertEq(token.balanceOf(to), 0);
    }
}
