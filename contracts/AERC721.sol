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
    address public immutable bridgeContractAddress;

    /** 
    * @param _name : Name of NFT collection
    * @param _symbol: Symbol of NFT collection
    * @param _bridgeAddress: Supported chain (i.e. mumbai and ropsten) Arcana bridge address. use below value for;
        mumbai : 0x2a6137D49A5597aC3b26B7464Edf20A553291584
        ropsten : 0x491f0c066F6e126A34F57346613db5628B41ba18
     */

    constructor(
        string memory _name,
        string memory _symbol,
        address _bridgeAddress
    ) ERC721(_name, _symbol) {
        _transferOwnership(msg.sender);
        bridgeContractAddress = _bridgeAddress;
    }

    /**
    * @dev : mint
    * @param to : NFT token receiver address
    * @param tokenId : tokenId to be assigned to NFT
    * @param tokenURI : Metadata URI associated with NFT
     */
    function mint(
        address to,
        uint256 tokenId,
        string memory tokenURI
    ) public onlyOwner returns (uint256) {
        _mint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        return tokenId;
    }
    
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override {
        super._beforeTokenTransfer(from, to, tokenId);
        //NFT mint message transfer to Arcana network via bridge
        IBridge(bridgeContractAddress).transferData(to, address(this), tokenId);
    }
}
