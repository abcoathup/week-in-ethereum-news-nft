// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/WeekInEthereumNewsNFT.sol";
import {ERC721Holder} from "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";

// Run anvil, then deply and mint
// anvil
// forge script script/QAWeekInEthereumNewsNFT.s.sol:QAWeekInEthereumNewsNFTScript --broadcast -vvvv
contract QAWeekInEthereumNewsNFTScript is Script, ERC721Holder {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        WeekInEthereumNewsNFT token = new WeekInEthereumNewsNFT();
        //token.mint(address(this));

        console.log(token.tokenURI(0));

        vm.stopBroadcast();
    }
}
