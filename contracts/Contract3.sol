pragma solidity ^0.4.17;

import 'zeppelin-solidity/contracts/token/ERC20/StandardToken.sol';

contract Contract3 is StandardToken {
  string public name = 'Contract3';
  string public symbol = 'CON3';
  uint8 public decimals = 2;
  uint public INITIAL_SUPPLY = 1000000;
  address public owner;

function Contract3() public {
    totalSupply_ = INITIAL_SUPPLY;
    balances[msg.sender] = INITIAL_SUPPLY;
    owner = msg.sender;
  }
}

