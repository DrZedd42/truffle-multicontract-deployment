pragma solidity ^0.4.17;

import 'zeppelin-solidity/contracts/token/ERC20/StandardToken.sol';

contract Contract-1 is StandardToken {
  string public name = 'Contract-1';
  string public symbol = 'CON1';
  uint8 public decimals = 2;
  uint public INITIAL_SUPPLY = 10000;
  address public owner;

function TutorialToken() public {
    totalSupply_ = INITIAL_SUPPLY;
    balances[msg.sender] = INITIAL_SUPPLY;
    owner = msg.sender;
  }
}
