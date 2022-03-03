//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";


contract BTK_TOKEN {
    string public name = "Batyr Token";
    string public symbol = "BTK";

    // The fixed amount of tokens stored in an unsigned integer type variable.
    uint256 private totalToken = 0;

    // An address type variable is used to store ethereum accounts.
    address public owner;

    // A mapping is a key/value map. Here we store each account balance.
    mapping(address => uint256) balances;

    //the number of decimals the token uses -
    uint8 private decimals = 18;

    event TransferEvent(address indexed _from, address indexed _to, uint256 _value);
    event ApprovalEvent(address indexed _owner, address indexed _spender, uint256 _value);

    uint256  maxSupply=1000000*10^18;
    
    constructor() {
        // The totalSupply is assigned to transaction sender, which is the account
        // that is deploying the contract.
        balances[msg.sender] = totalToken;
        owner = msg.sender;
    }
    
    // Modifier to check that the caller is the owner of
    // the contract.
    modifier onlyOwner(){
        require( msg.sender == owner, "Caller is not the owner");
        _;
    }

    function transfer(address to, uint256 amount) external {
        // Check if the transaction sender has enough tokens.
        // If `require`'s first argument evaluates to `false` then the
        // transaction will revert.
        require(balances[msg.sender] >= amount, "Not enough tokens");
        // Transfer the amount.
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }

    function getDecimals() public view returns (uint8) {
        return decimals;
    }

    //Release new tokens
    function releaseNewToken( uint256 _newTokenAmount)  public onlyOwner returns (bool ) {

        totalToken+=_newTokenAmount;
        require( maxSupply>= totalToken, "It is forbidden to release tokens more than maxSupply");
        return true;

    }



    /**
     * Read only function to retrieve the token balance of a given account.
     *
     * The `view` modifier indicates that it doesn't modify the contract's
     * state, which allows us to call it without executing a transaction.
     */
    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }

    function _totalSupply() public view returns (uint256){
        return totalToken;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {

    }

    function approve(address _spender, uint256 _value)  public returns (bool success) {

    }
    
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {

    }







}