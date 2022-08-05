# Arcana Standard Contracts

This project contains ERC standard contracts with Arcana supported functions.


## Contracts

### AERC721: 

The ARC721 is a standard set of interfaces for issuing non-fungible tokens for NFTs residing on Arcana Network. It is fully compatible with the standard [ERC721](https://docs.openzeppelin.com/contracts/3.x/erc721)) interface. 

AERC721 is similar to standard ERC721 with just one execption. There is an additional hook method `_beforeTokenTransfer_`. This method is added to initiate a call to Arcana Network bridge contract. Bridge allows Arcana Network to listen for NFT mint/transfer on-chain operations that happen on the supported chains. Currently, Mumbai and Ropsten are supported.


## Usage

Install dependencies

```bash
npm i
```

### Deploy to Mumbai Network

The contract in directly is ownable NFT collection i.e. Only deployer can mint the NFT. 

**Environment Variables:**
- CONTRACT_OWNER : Contract deployer account having funds on Polygon MUMBAI network
MUMBAI_URL: Polygon Mumbai chain RPC URL
- NFT_COLLECTION_NAME : NFT collection name for marketplaces/explorer
- NFT_COLLECTION_SYMBOL: NFT collection symbol for marketplaces/explorer

In the project root directory, execute the following command:

```bash
npx hardhat run scripts/deploy.js --network mumbai

```

### How to customize NFT Contract

You can customize the NFT contract as per your needs. Make sure that you do not miss to include the `bridge call` in the contract. This call enables Arcana Network to listen for NFT transfers and record any ownership changes.

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


