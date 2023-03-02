// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/WeekInEthereumNewsNFT.sol";

// Deploy WeekInEthereumNewsNFT
// source .env
// forge script script/WeekInEthereumNewsNFT.s.sol:WeekInEthereumNewsNFTScript --rpc-url $GOERLI_RPC_URL --etherscan-api-key $ETHERSCAN_KEY --broadcast --verify -vvvv
contract WeekInEthereumNewsNFTScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        WeekInEthereumNewsNFT token = new WeekInEthereumNewsNFT();

        vm.stopBroadcast();
    }
}
