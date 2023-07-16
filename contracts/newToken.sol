// SPDX-License-Identifier: MIT

// Requirements
// A new token is created on the local HardHat network
// Only contract owner should be able to mint tokens
// Any user can transfer tokens
// Any user can burn tokens

pragma solidity ^0.8.0;

interface erc20 {
    
    function mint(address to, uint256 amount) external;
    function transfer(address to, uint256 amount) external;
    function burn(uint256 amount) external;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);

}


contract newToken is erc20{
    string public tokenName;
    string public tokenSymbol;
    uint256 public totalTokensMinted;
    address public owner;

    mapping(address => uint256) public balanceOf;

    constructor(string memory _name, string memory _symbol, uint256 _totalSupply) {
        tokenName = _name;
        tokenSymbol = _symbol;
        totalTokensMinted = _totalSupply;
        balanceOf[msg.sender] = _totalSupply;
        owner = msg.sender;
    }

    function mint(address to, uint256 amount) public {
        require(msg.sender == owner, "Only the contract owner can mint the tokens");
        balanceOf[to] += amount;
        totalTokensMinted += amount;
    }

    function transfer(address to, uint256 amount) public {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);
    }

    function burn(uint256 amount) public {

        require(amount > 0, "Amount must be greater than zero");
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        emit Burn(msg.sender, amount);
    }
}