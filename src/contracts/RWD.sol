// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;

contract RWD {
  string public name = "Reward Token";
  string public symbol = "RWD";
  uint256 public totalSuply = 10000000000000000000000000;
  uint8 public decimals = 18;

  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);
  
  mapping(address => uint256) public balanceOf;
  mapping(address => mapping(address => uint256)) public allowance;

  constructor() public {
    balanceOf[msg.sender] = totalSuply;
  }
  
  function transfer(address to, uint256 value) public returns (bool) {
    require(balanceOf[msg.sender] >= value);
    balanceOf[msg.sender] -= value;
    balanceOf[to] += value;
    emit Transfer(msg.sender, to, value);
    return true;
  }

  function approve(address spender, uint256 value) public returns (bool) {
    allowance[msg.sender][spender] = value;
    emit Approval(msg.sender, spender, value);
    return true;
  }

  function transferFrom(address from, address to, uint256 amount) public returns(bool) {
    require(amount <= balanceOf[from]);
    require(amount <= allowance[from][msg.sender]);
    balanceOf[from] -= amount;
    balanceOf[to] += amount;
    allowance[msg.sender][from];
    emit Transfer(from, to, amount);
  }
}