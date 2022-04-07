// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;

contract Migration {
  address public owner;
  uint public last_completed_migration;

  constructor() public {
    owner = msg.sender;
  }

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  } 
  
  function upgrade(address newAddress) public restricted {
    Migration upgraded = Migration(newAddress);
    upgraded.setCompleted(last_completed_migration);
  }


}
