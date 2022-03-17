//deploy.js
const hre = require("hardhat");

async function main() {
    // ethers is avaialble in the global scope
    const [deployer] = await hre.ethers.getSigners();   

    const Token = await hre.ethers.getContractFactory("BTK_TOKEN");
    const token = await Token.deploy();
    await token.deployed();
    
    console.log("***********************HARDHAT localhost deploy**************************");
    console.log("Contract deployed on HARDHAT localhost network");
    console.log("Deployer adddres:", deployer.address);
    console.log("Contract adddres:", token.address);
    console.log("Deployer balance:", (await deployer.getBalance()).toString());
    console.log("*************************************************************************");

    
  }

  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
