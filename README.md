# Arcana Standard Contracts

This project contains ERC standard contracts with Arcana supported functions.


## Contracts

### AERC721: 

This ARC721 is a standard for representing ownership of non-fungible tokens, that is, where each token is unique. Which is compatible with ERC721 interface. 

AERC721 is similar to standard ERC721 with one execption with hook method _beforeTokenTransfer_ which has call to bridge contract. Bridge allows arcana network to listen for mint/transfer operation happened on-chain(i.e. mumbai/ropsten).  


## Usage

### Deploy to mumbai network

The contract in directly is ownable NFT collection i.e. Only deployer can mint the NFT. 

**ENV Variables** : 
- CONTRACT_OWNER : Contract deployer account having funds on Polygon MUMBAI network
- MUMBAI_URL : Polygon mumbai chain rpc url
- NFT_COLLECTION_NAME : NFT collection name for marketplaces/explorer
- NFT_COLLECTION_SYMBOL: NFT collection symbol for marketplaces/explorer

Run below command in project root directory

```bash
npx run scripts/deploy.js --network mumbai

```

### What if I want _customised/flavoured_ NFT Contract

Developer can customised the NFT contract as per their need just need to make sure include a bridge call in the contract that enable Arcana network to listen for NFT transfers.

```ts

//outside contract defination
interface IBridge {
    function transferData(
        address _to,
        address _NFTContractAddress,
        uint256 _tokenId
    ) external;
}

//~~~~~~ snipped ~~~~~

function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override {
        super._beforeTokenTransfer(from, to, tokenId);
        //for mumbai:  0x2a6137D49A5597aC3b26B7464Edf20A553291584
        //for ropsten : 0x491f0c066F6e126A34F57346613db5628B41ba18
        address bridgeContractAddress = "<bridge-address>";
        IBridge(bridgeContractAddress).transferData(to, address(this), tokenId);
}


```


