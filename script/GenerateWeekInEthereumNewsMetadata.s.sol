// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {WeekInEthereumNewsOnchainSVGNFT} from "../src/WeekInEthereumNewsOnchainSVGNFT.sol";
import {ERC721Holder} from "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";

contract Wien is WeekInEthereumNewsOnchainSVGNFT {

    function metaData(uint256 tokenId) public view returns (string memory) {
        if (!_exists(tokenId)) {
            revert NonexistentToken();
        }

        string memory tokenName_ = _generateTokenName(tokenId);
        string memory description = _generateDescription(tokenId);

        string memory image = _generateBase64Image(tokenId);
        string memory attributes = _generateAttributes(tokenId);
        return string.concat(
            
                        '{"name":"',
                        tokenName_,
                        '", "description":"',
                        description,
                        '", "image": "data:image/svg+xml;base64,',
                        image,
                        '",',
                        attributes,
                        "}"
        );
    }

}



// Run anvil, then deply and mint
// anvil
// forge script script/GenerateWeekInEthereumNewsMetadata.s.sol:GenerateWeekInEthereumNewsMetadataScript --broadcast -vvvv
contract GenerateWeekInEthereumNewsMetadataScript is Script, ERC721Holder {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        Wien token = new Wien();

        for (uint256 tokenId = 0; tokenId < 338; tokenId++) {
            vm.writeFile(string.concat("./metadata/", vm.toString(tokenId)), token.metaData(tokenId));    
        }

        vm.stopBroadcast();
    }
}
