require("@nomiclabs/hardhat-waffle");
require("dotenv").config();

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */

let deployer = process.env.CONTRACT_OWNER || "",
    mumbai_url = process.env.MUMBAI_URL || "",
    ropsten_url =  process.env.ROPSTEN_URL || "";

module.exports = {
  solidity: "0.8.4",
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {},
    mumbai: {
      url: mumbai_url,
      chainId: 80001,
      accounts: [deployer]
    },
    ropsten: {
      url: ropsten_url,
      chainId: 3,
      accounts: [deployer]
    }    


  }

};
