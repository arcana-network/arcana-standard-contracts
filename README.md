<p align="center">
<a href="#start"><img height="30rem" src="https://raw.githubusercontent.com/arcana-network/branding/main/an_logo_light_temp.png"/></a>
</p>
<p align="center">
<a title="MIT License" href="https://github.com/arcana-network/license/blob/main/LICENSE.md"><img src="https://img.shields.io/badge/license-MIT-blue"/></a>
<a title="Beta release" href="https://github.com/arcana-network/demo-app/releases"><img src="https://img.shields.io/github/v/release/arcana-network/demo-app?style=flat-square&color=28A745"/></a>
<a title="Twitter" href="https://twitter.com/ArcanaNetwork"><img alt="Twitter URL" src="https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Ftwitter.com%2FArcanaNetwork"/></a>
</p>

# Arcana Standard Contracts

This project contains ERC standard contracts with Arcana supported functions.

*Need to add the purpose of this repository and why it is public. Who needs to use it and when.*

## AERC721 Contract

The AERC721 is a standard set of interfaces implemented by Arcana Protocol for issuing Non-Fungible Tokens or NFTs residing on the Arcana Network.

It is fully compatible with the standard [ERC721](https://docs.openzeppelin.com/contracts/3.x/erc721)) interface with just one execption. There is an additional hook method `_beforeTokenTransfer_`.

This additional hook method is added to setup communication with Arcana Network bridge contract. Bridge allows Arcana Network to listen for NFT mint/transfer on-chain operations that happen on the supported chains. Currently, Mumbai and Ropsten are supported.

## ⚙️ Installation

Install software dependencies:

```bash
npm install
```

## 📚 Usage

After installation, you can deploy it to the supported chains and then customize it.

### Supported Chains

* [Polygon MUMBAI Testnet](https://docs.unbound.finance/guides/guide-to-accessing-polygon-testnet-and-how-to-use-unbound-faucet-tokens)
* [Ethereum Ropsten Testnet](https://www.alchemy.com/overviews/ropsten-testnet#ropsten-1)

### Deployment

#### MUMBAI Testnet

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

#### Other Chains

TBD - How to deploy instructions

### Customize NFT Contract

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

## 💡 Support

For any support or integration related queries, contact [Arcana support team](mailto:support@arcana.network).

## 🤝 Contributing

We welcome all contributions to this public repository from the community.

Read our [contributing guide](https://github.com/arcana-network/license/blob/main/CONTRIBUTING.md) to learn more about the our development process, how to propose bug fixes and improvements, and the code of conduct that we expect the participants to adhere to.

## ℹ️ License

Arcana Network Drive is distributed under the [MIT License](https://fossa.com/blog/open-source-licenses-101-mit-license/).

For details see [Arcana License](https://github.com/arcana-network/license/blob/main/LICENSE.md).
