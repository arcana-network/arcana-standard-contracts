<p>
<a href="#start"><img height="30rem" src="https://raw.githubusercontent.com/arcana-network/branding/main/an_logo_light_temp.png"/></a>
</p>
<p>
<a title="MIT License" href="https://github.com/arcana-network/license/blob/main/LICENSE.md"><img src="https://img.shields.io/badge/license-MIT-blue"/></a>
<a title="Beta release" href="https://github.com/arcana-network/arcana-standard-contracts/releases"><img src="https://img.shields.io/github/v/release/arcana-network/arcana-standard-contracts?style=flat-square&color=28A745"/></a>
<a title="Twitter" href="https://twitter.com/ArcanaNetwork"><img alt="Twitter URL" src="https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Ftwitter.com%2FArcanaNetwork"/></a>
</p>

# Arcana Standard Contract

This repository contains sample code to demonstrate how a dApp can enable its users to create their own NFT collection. It requires the dApp to deploy an ERC standard contract similar to the one in this repository. Private NFTs can be created using one of the supported blockchains.

Note, there is a critical one line difference in this contract from the standard ERC-721 contract, hence we are referring to it as AERC or Arcana ERC721 contract.

### Supported Chains

* [Polygon MUMBAI Testnet](https://docs.unbound.finance/guides/guide-to-accessing-polygon-testnet-and-how-to-use-unbound-faucet-tokens)
* [Ethereum Ropsten Testnet](https://www.alchemy.com/overviews/ropsten-testnet#ropsten-1)

## AERC721 Contract

The AERC721 is a standard set of interfaces implemented by Arcana Protocol for issuing Non-Fungible Tokens or NFTs residing on the Arcana Network.

It is fully compatible with the standard [ERC721](https://docs.openzeppelin.com/contracts/3.x/erc721) interface with just one exception. There is an additional hook method `_beforeTokenTransfer_`.

This one line change in the contract is required to ensure that the Arcana blockchain is notified via the Arcana Bridge component for any NFT transaction or ownership change. This additional hook method is used to notify Arcana Network Bridge.

Bridge allows Arcana Network to listen for any NFT mint/transfer on-chain operations that happen on the supported chains. Currently, Mumbai and Ropsten are supported.

## ⚙️ Installation

Download the software dependencies using this command:

```bash
npm install
```

## 📚 Usage

After installation, you can deploy the smart contract to any supported chain and then customize it.

This sample contract is coded in such a way that only the person who has deployed the contract/collection can mint NFT. The dApp developers can choose to modify the minting process and allow anyone using this dApp to mint NFTs.

### Deployment

Note: Only the deployer of this AERC721 smart contract can mint the NFT.

**Setup Environment Variables:**

- CONTRACT_OWNER : The contract deployer's private key associated with their public account. Make sure the account holds sufficient funds on the [chain](#supported-chains] where this collection is to be created.

- NFT_COLLECTION_NAME : NFT collection name for marketplaces/explorer

- NFT_COLLECTION_SYMBOL: NFT collection symbol for marketplaces/explorer

Depending upon the chosen blockchain, specify MUMBAI_URL or ROPSTEN_URL:

- MUMBAI_URL: Polygon Mumbai chain RPC URL

- ROPSTEN_URL:  Ropsten chain RPC URL

**Create NFT**

If you want to mint using the `mumbai` chain, go to the project root directory and execute the following command:

```bash
npx hardhat run scripts/deploy.js --network mumbai

```

Similarly, if you want to mint using the `ropsten` chain, go to the project root directory and execute the following command:

```bash
npx hardhat run scripts/deploy.js --network ropsten

```

### Customize NFT Contract

You can customize the NFT contract as per your dApp requirements. Make sure that you include the `bridge call` in the contract. This call enables Arcana Network to listen for NFT transfers and record any ownership changes.

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
        //bridge-address for mumbai chain:  0x2a6137D49A5597aC3b26B7464Edf20A553291584
        //bridge-address for ropsten chain: 0x491f0c066F6e126A34F57346613db5628B41ba18
        address bridgeContractAddress = "<bridge-address>";
        IBridge(bridgeContractAddress).transferData(to, address(this), tokenId);
}

```

## 💡 Support

For any usage queries, contact the [Arcana Support Team](mailto:support@arcana.network).

## ℹ️ License

Arcana Standard Contract is distributed under the [MIT License](https://fossa.com/blog/open-source-licenses-101-mit-license/).

For details see [Arcana License](https://github.com/arcana-network/license/blob/main/LICENSE.md).
