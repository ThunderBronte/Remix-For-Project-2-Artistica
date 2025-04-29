// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC721, ERC721Burnable, Ownable {
    uint256 private _nextTokenId;

    constructor(address initialOwner)
        ERC721("LoafCatNFT", "LCN")
        Ownable(initialOwner)
    {}
 
    function _baseURI() internal pure override returns (string memory) {
        // Folder link, not only one code 
        return "https://ipfs.io/ipfs/bafybeib7qqnh4ahsywyspwskq5n5son727zbhavvfdf7iitdkidzjj3e7a";
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
    }

    function tokenURI(uint256 tokenId) public view 
    override virtual returns (string memory) {
        _requireOwned(tokenId);

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string.concat(baseURI, integerToString(tokenId),".json") : "";
    }

    // helper function
    function integerToString(uint _value) public pure returns (string memory) {
        // Edge case for '0'
        if (_value == 0) {
            return "0";
        }

        uint temp = _value;
        uint digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }

        bytes memory buffer = new bytes(digits);
        while (_value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + _value % 10));
            _value /= 10;
        }

        return string(buffer);
    }

}
