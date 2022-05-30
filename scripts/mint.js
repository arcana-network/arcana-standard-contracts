const hre = require("hardhat");

async function main() {
    
    const nftContractAddress = "0xcAf83A2c7755D79Ba5bC83346E4AE013d2D3254d",
    tokenId = 2, to = "0xd018E133CeF28AE3F4F27b16F1AB43BBdd53BDcb",
    tokenUri= "sample.url/2";
    
    const ARC721_factory = await hre.ethers.getContractFactory("ARC721");
    const ARC721 = await ARC721_factory.attach(nftContractAddress)

    let tx = await ARC721.mint(to, tokenId);
    await tx.wait();

    console.log(`Minted token ${tokenId} \nto ${to}`);
    
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
