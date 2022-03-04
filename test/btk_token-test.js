const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("BTK_TOKEN", function () {

    let contractFactory;
    let contract;
    let owner;
    let acc1;
    let acc2;
    let addrLast;
    let accounts;

    let initialSupply;


    beforeEach( async function(){

        initialSupply = ethers.utils.parseEther("5000");

        contractFactory  = await ethers.getContractFactory("BTK_TOKEN");
        accounts = await ethers.getSigners();

        [owner, acc1, acc2, ...accLast] = accounts;

        contract  = await contractFactory.deploy(initialSupply);

        await contract.deployed();

      
    });

    describe("releaseNewToken", function(){

        it ("Another account shouldn't release token ", async function(){

            await expect( contract.connect(acc1).releaseNewToken(10) )
            .to.be.revertedWith("Caller is not the owner");

        })

        it ("The owner must be able to release a token", async function(){

            const initTotalSupply = await contract.getTotalToken();            

            await contract.releaseNewToken( ethers.utils.parseEther("1") ) ; 
            const lastTotalSupply =  await contract.getTotalToken();
            
            expect(lastTotalSupply).to.be.equal( initTotalSupply.add( ethers.utils.parseEther("1")));
            
        })


        it ("Must be fail to release Token greater than maxSupply", async function(){ 

            const initTotalSupply = await contract.getTotalToken();  

            await expect( contract.releaseNewToken( ethers.utils.parseEther("9996000") ) )
            .to.be.revertedWith("It is forbidden to release tokens more than maxSupply") ;

        })

        //end describe -releaseNewToken()
    });

    describe("transfer", function(){

        // it ("should be fail when not enough fund", async function(){

        //     let amount = ethers.utils.parseEther("1000");

        //     await expect(  contract.connect(acc1).transfer(amount, acc2.address ))
        //     .to.be.revertedWith("There is not so much token on sender!");

        // })

        it ("should be pass when enough fund", async function(){
            
            let amount_1=ethers.utils.parseEther("1000");
            let amount_2=ethers.utils.parseEther("300");

            const initBalance = await contract.balanceOf(owner.address);

            await contract.transfer( acc1.address, amount_1);
            await contract.connect(acc1).transfer( acc2.address, amount_2);

            expect( await contract.balanceOf(owner.address) ).to.be.equal(initBalance.sub(amount_1));
            expect( await contract.balanceOf(acc1.address) ).to.be.equal(amount_1.sub(amount_2));
            expect( await contract.balanceOf(acc2.address) ).to.be.equal(amount_2);           

        })

        //end describe -transfer()
    })



  
});
