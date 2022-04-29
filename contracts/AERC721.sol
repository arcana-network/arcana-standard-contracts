// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IBridge {
    function transferData(address _to , address _NFTContractAddress, uint _tokenId) external;
}

contract ARC721 is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string _baseTokenURI;
    address bridgeAddress;

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _baseUri,
        address _bridgeAddress
    ) ERC721(_name, _symbol) {
        _transferOwnership(msg.sender);
        setBaseTokenURI(_baseUri);
        bridgeAddress = _bridgeAddress;
    }

    function mint(address _to)
        public
        onlyOwner
        returns (uint256)
    {
        _tokenIds.increment();
        
        uint256 tokenId = _tokenIds.current();
        _mint(_to, tokenId);

        return tokenId;
    }

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override {
        super._afterTokenTransfer(from, to, tokenId);
        IBridge(bridgeAddress).transferData(to, address(this), tokenId);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseTokenURI(string memory uri) public onlyOwner {
        _baseTokenURI = uri;
    }

    function setBridgeAddress(address _bridgeAddress) public onlyOwner {
        bridgeAddress = _bridgeAddress;
    }
}
