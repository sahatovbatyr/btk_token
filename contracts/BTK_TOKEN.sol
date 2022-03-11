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
    mapping(address => mapping(address => uint)) public allowance;

    //the number of decimals the token uses -
    uint8 private decimals = 18;
    
    uint256 maxSupply;
    uint256 initToken;

    constructor() {
        // The totalSupply is assigned to transaction sender, which is the account
        // that is deploying the contract.
        initToken = 5000 * (10**18);
        totalToken = initToken;
        balances[msg.sender] = initToken;
        owner = msg.sender;
        maxSupply = 1000000 * (10**18);
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    // Modifier to check that the caller is the owner of
    // the contract.
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    function getDecimals() public view returns (uint8) {
        return decimals;
    }

    function getTotalToken() public view returns (uint256) {
        return totalToken;
    }

    //Release new tokens
    function releaseNewToken(uint256 _newTokenAmount)
        public
        onlyOwner
        returns (bool)
    {
        totalToken += _newTokenAmount;
        balances[owner] += _newTokenAmount;        
        require(
            maxSupply >= totalToken,
            "It is forbidden to release tokens more than maxSupply"
        );
        emit Transfer(address(0), msg.sender, _newTokenAmount);
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

    function getMaxToken() public view returns (uint256) {
        return maxSupply;
    }

    function totalSupply() public view returns (uint256) {
        return totalToken;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public onlyOwner returns (bool success) {
        require(
            balances[_from] >= _value,
            "There is not so much token on sender!"
        );
        require(_value > 0, "Value must be great 0");

        balances[_from] = balances[_from] - _value;
        balances[_to] = balances[_to] + _value;
        emit Transfer(_from, _to, _value);
        success = true;
    }

    function transfer(address _to, uint256 _amount)
        public
        returns (bool success)
    {
        require(
            balances[msg.sender] >= _amount,
            "There is not so much token on sender!"
        );
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
        success = true;
    }

    function approve(address _spender, uint256 _amount)
        public
        returns (bool success)
    {
        allowance[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }

   
}
