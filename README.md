# Basic Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts.

## Deploy contract to remote and local server 

1. you shoul create .env file in root folder your project.  

2. create these varablies:  

    //WARNING this need to deploy the contract remote NETWORK (ROPSTEN, RINKEBY ...)
    // if you want to deploy the contract to hardhat localhost don't create this varaible
   - ALCHEMY_API_KEY ="example-your-alchemy-project-api-key"     

    
   - CONTRACT_DEPLOYER_WALLET_PRIVATE_KEY="private-key-metamask-account-key"  
3. import these varablies on hardhat.config.js file  

4. Deploy the contract

   - 4.a) to deploy contract to remote server type on console root folder :  
     D:\projects\btk_token_01> npx hardhat scripts/deploy.js --network ropsten  

   - 4.b) to deploy contract to localhost:  
     D:\projects\btk_token_01> npx hardhat scripts/deploy.js --network localhost    

  


Try running some of the following tasks:  

npm install ethers hardhat @nomiclabs/hardhat-waffle ethereum-waffle @nomiclabs/hardhat-ethers chai  

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```

