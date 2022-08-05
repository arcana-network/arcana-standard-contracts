const hre = require("hardhat");

async function main() {
    
    const nftContractAddress = "<NFT contract address>",
    tokenId = Number("<token Id>"), 
    to = "<NFT receipent address>",
    tokenUri= "<NFT metadata uri>";
    
    const AERC721_factory = await hre.ethers.getContractFactory("AERC721");
    const AERC721 = await AERC721_factory.attach(nftContractAddress)

    let tx = await AERC721.mint(to, tokenId, tokenUri);
    await tx.wait();

    console.log(`Minted token ${tokenId} \nto ${to}`);
    
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
