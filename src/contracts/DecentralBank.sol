// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;

import "./RWD.sol";
import "./Tether.sol";

contract DecentralBank {
  string public name = "Decentral Bank";
  address public owner;
  RWD public rwd;
  Tether public tether;
  
  constructor(RWD _rwd, Tether _tether) public {
    owner = msg.sender;
    rwd = _rwd;
    tether = _tether;
  }
}
