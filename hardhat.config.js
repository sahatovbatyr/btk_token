require("@nomiclabs/hardhat-waffle");
//require("hardhat-prettier");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html

// task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
//   const accounts = await hre.ethers.getSigners();

//   for (const account of accounts) {
//     console.log(account.address);
//   }
// });

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */

 require('dotenv').config();

 const { ALCHEMY_API_KEY, CONTRACT_DEPLOYER_WALLET_PRIVATE_KEY} = process.env;

//private key your wallet
 

module.exports = {
  paths: {
    artifacts: './src/artifacts',
  },
  solidity: "0.8.4",

  //for remote deploy
  networks: {
    ropsten: {      
      url: `https://eth-ropsten.alchemyapi.io/v2/${ALCHEMY_API_KEY}`,
      accounts: [`${CONTRACT_DEPLOYER_WALLET_PRIVATE_KEY}`]
    },

    hardhat: {
      chainId: 31337
    }
    
  }
};
