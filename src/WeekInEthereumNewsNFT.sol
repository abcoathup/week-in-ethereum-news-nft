// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721Consecutive} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Consecutive.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract WeekInEthereumNewsNFT is ERC721, ERC721Consecutive, ERC721URIStorage, Ownable {
    /// ERRORS

    /// EVENTS

    uint256 public totalSupply;

    string public baseURI = "ipfs://QmPoR29FC9ef4d73mQBb5GJjKfKW4WV1AVsdkAidjzpeLU/";

    address constant andrew = 0x77737a65C296012C67F8c7f656d1Df81827c9541;
    address constant evan = 0x059aE37646900CaA1680473d1280246AfCCC3114;

    constructor() ERC721("Week in Ethereum News", "WIEN") {
        _mintConsecutive(evan, 245);
        _mintConsecutive(andrew, 12); // Andrew first issue May 16, 2021
        _mintConsecutive(evan, 1); // Evan vacation cover August 8, 2021
        _mintConsecutive(andrew, 43);
        _mintConsecutive(evan, 1); // Evan vacation cover June 11, 2022
        _mintConsecutive(andrew, 30);
        _mintConsecutive(evan, 1);
        _mintConsecutive(andrew, 5); // Evan vacation cover January 14, 2023
        totalSupply = 338;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }


    function setBaseURI(string calldata newBaseURI) external onlyOwner {
        baseURI = newBaseURI;
    }

    function mint(address to) public onlyOwner {
        _mint(to, totalSupply);

        unchecked {
            totalSupply++;
        }
    }

    function _ownerOf(uint256 tokenId) internal view virtual override(ERC721, ERC721Consecutive) returns (address) {
        return super._ownerOf(tokenId);
    }

    function _mint(address to, uint256 tokenId) internal virtual override(ERC721, ERC721Consecutive) {
        super._mint(to, tokenId);
    }

    function _beforeTokenTransfer(address from, address to, uint256 firstTokenId, uint256 batchSize)
        internal
        virtual
        override
    {
        super._beforeTokenTransfer(from, to, firstTokenId, batchSize);
    }

    function _afterTokenTransfer(address from, address to, uint256 firstTokenId, uint256 batchSize)
        internal
        virtual
        override(ERC721, ERC721Consecutive)
    {
        super._afterTokenTransfer(from, to, firstTokenId, batchSize);
    }

        function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}
