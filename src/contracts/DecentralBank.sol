// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;

import "./RWD.sol";
import "./Tether.sol";

contract DecentralBank {
  string public name = "Decentral Bank";
  address public owner;
  RWD public rwd;
  Tether public tether;

  address[] public stakers;

  mapping(address => uint256) public stakingBalance;
  mapping(address => bool) public hasStaked;
  mapping(address => bool) public isStaking;

  constructor(RWD _rwd, Tether _tether) public {
    rwd = _rwd;
    tether = _tether;
    owner = msg.sender;
  }

  function depositTokens(uint256 amount) public {
    // require staking amount to be greater than zero
    require(amount > 0, "Amount must be greater than 0");

    // Transfer tether tokens to this contract address for staking
    tether.transferFrom(msg.sender, address(this), amount);
    // Update staking balance
    stakingBalance[msg.sender] += amount;

    if(hasStaked[msg.sender] == false) {
      stakers.push(msg.sender);
    }
    
    // Update staking balance
    isStaking[msg.sender] = true;
    hasStaked[msg.sender] = true;
  }

  function unStakeTokens() public {
    uint balance = stakingBalance[msg.sender];
    require(balance > 0, "You must have staked tokens to unstake");
    // transfer the tokens to the specified contract address from our bank
    tether.transfer(msg.sender, balance);
    // reset the staking balance
    stakingBalance[msg.sender] = 0;
    // Update staking balance
    isStaking[msg.sender] = false;
  }
  
  // issue rewards
  function issueTokens() public {
    // Only owner can call this function
    require(msg.sender == owner, 'caller must be the owner');
    // issue tokens to all stakers
    for (uint i=0; i<stakers.length; i++) {
      address recipient = stakers[i]; 
      uint balance = stakingBalance[recipient] / 9;
      if(balance > 0) {
        rwd.transfer(recipient, balance);
      }
    }
  }
}
