const hre = require("hardhat");

async function main() {

  const Name = process.env.NFT_COLLECTION_NAME || "DEMO",
    Symbol = process.env.NFT_COLLECTION_SYMBOL || "DEMO";

  let bridge;

  switch (hre.network.config.chainId) {
    case 3:
      bridge = "0x491f0c066F6e126A34F57346613db5628B41ba18"; 
      break;
    case 80001:
      bridge = "0x2a6137D49A5597aC3b26B7464Edf20A553291584";
      break;

    default:
      throw new Error("Unsupported network! please pass mumbai or ropsten");
  }

  // We get the contract to deploy
  const AERC721_factory = await hre.ethers.getContractFactory("AERC721");
  const AERC721 = await AERC721_factory.deploy(Name, Symbol, bridge);

  await AERC721.deployed();

  console.log("NFT Contract deployed to:", AERC721.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
