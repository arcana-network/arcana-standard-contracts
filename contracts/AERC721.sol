pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IBridge {
    function transferData(
        address _to,
        address _NFTContractAddress,
        uint256 _tokenId
    ) external;
}

contract AERC721 is ERC721URIStorage, Ownable {
    address public bridgeContractAddress;

    constructor(string memory _name, string memory _symbol)
        ERC721(_name, _symbol)
    {
        _transferOwnership(msg.sender);
        bridgeContractAddress = 0xC504CA288E7AeE222715d9F80A46435457DA7A9D;
    }

    function mint(
        address to,
        uint256 tokenId,
        string memory tokenURI
    ) public onlyOwner returns (uint256) {
        _mint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        return tokenId;
    }

    function transfer(address to, uint256 tokenId) external {
        transferFrom(msg.sender, to, tokenId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override {
        super._beforeTokenTransfer(from, to, tokenId);
        IBridge(bridgeContractAddress).transferData(to, address(this), tokenId);
    }
    
}
