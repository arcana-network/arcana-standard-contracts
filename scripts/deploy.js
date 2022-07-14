
const hre = require("hardhat");

async function main() {
 
  const Name = process.env.NFT_COLLECTION_NAME || "DEMO",
  Symbol = process.env.NFT_COLLECTION_SYMBOL || "DEMO",
  bridge = "0x2a6137D49A5597aC3b26B7464Edf20A553291584" 

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
