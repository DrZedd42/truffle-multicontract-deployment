# Deploying Multiple Contracts Using Truffle

## Setup Enviornment

Note: This repo has only been tested using Ubuntu and may not be compatible for non-Unix software such as Windows

### Install download and install both geth and truffle

* [truffle suite](https://github.com/trufflesuite/truffle)
* [geth for Ubuntu](https://github.com/ethereum/go-ethereum/wiki/Installation-Instructions-for-Ubuntu)
* [geth for OSX](https://github.com/ethereum/go-ethereum/wiki/Installation-Instructions-for-Mac)

Install both into same project folder

### Clone truffle-multicontract-deployment to your project folder

0. Access project folder in terminal
     ```
     shell> cd "PROJECT FOLDER"
     ```
1. Clone the repository from github
     ```
     git clone https://github.com/dlindsay93/truffle-multicontract-deployment.git
     ```
3. Install zeppelin-solidity in the truffle-multicontract-deployment folder
     ```
     shell> cd truffle-multicontract-deployment
     npm install zeppelin-solidity
     ```

Make sure that the project folder this is saved in is the same folder truffle and geth are located.

## Tutorial to Deploy Multiple Contracts at Once Using truffle

If you are familiar with deploying contracts with Truffle then this should be fairly straight forward for you with only a few minor changes to the procedure. It should be noted that this method can also be used to deploy single contracts as well with only a few changes to the code if that suites your needs.

### Getting an Ethereum HDWallet

In order to deploy and call a contract you will first need an Ethereum HD Wallet. This wallet can be provided from any source and can even be generated using your local machine, but for simplicity it is recommended that you install the MetaMask Ethereum Wallet to your local browser.

* [MetaMask for Chrome](https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn)
* [MetaMask for Firefox](https://addons.mozilla.org/en-US/firefox/addon/ether-metamask/)

This extension will give you an Ethereum wallet, will allow you to generate new addresses, and most importantly allow you to switch between the various Ethereum Networks very easily.

### Supplying ETH to your Ethereum wallet on the Ropsten Test Network

Now that you have your Ethereum wallet you will need to supply it with Ether in order to provide the gas needed to deploy and call the contracts. The simplest way to get Ether for the Ropsten Test Network is to find a Ether faucet to supply you with free Ether. There are a variety to choose from but the Ropsten Ether Faucet is the most widely used and easiest to find.

* [Ropsten Ether Faucet](http://faucet.ropsten.be:3001/)

To get the Ether simply input your wallet address into the designated area and hit the "Send me 1 test ether!" button. In around a minute your Ether should appear in your wallet.

Note: There are various forums online where people will send each other Test Ether in larger quantities if in the future you need a larger supply. For the purposes of this tutorial 1 Ether is more than enough.

### Setting Up the Smart Contracts

As it stands right now the 3 smart contracts in this repository are ready to be deployed, however this will show you how to change the names, symbols, decimal places, and initial supply of the contracts so you can make them unique to your purposes. This repository will deploy what are called ERC20 Tokens which is a widely used and well established token protocol on the Ethereum Newtork.

To begin go to your truffle-multicontract-deployment folder and then ender the contracts folder. You will see a file names Contract1.sol. Open that file and you should be presented with a code that looks like this:

```
pragma solidity ^0.4.17;

import 'zeppelin-solidity/contracts/token/ERC20/StandardToken.sol';

contract Contract1 is StandardToken {
  string public name = 'Contract1';
  string public symbol = 'CON1';
  uint8 public decimals = 2;
  uint public INITIAL_SUPPLY = 1000000;
  address public owner;

function Contract1() public {
    totalSupply_ = INITIAL_SUPPLY;
    balances[msg.sender] = INITIAL_SUPPLY;
    owner = msg.sender;
  }
}
```

When viewing Contract2 and Contract3 in this file you will notice that they are exactly the same code other than the name changes applied to fit the contract name. To edit the features of the token focus on these 4 lines of code:

```
string public name = 'Contract1';
string public symbol = 'CON1';
uint8 public decimals = 2;
uint public INITIAL_SUPPLY = 1000000;
```
In its current format when this token deploys, the token will have the name Contract1, the symbol will be CON1, the number of decimal places each token will have is up to 2, and the total supply of the tokens will be 10,000. You may notice that the line indicating the initial supply is listed as 100,000 and not 10,000. This is because the number of decimal places a token is given will effect the amount supplied when the contract is deployed, meaning the option for the total number of coins supplied needs to be adjusted for the number of decimal places you desire for your token.

Once you have changed these values to the appropriate names and values for your token you can then proceed to the other contracts and adjust them to meet whatever features you prefer.

You may have noticed that at this point the two lines of code:

```
contract Contract1 is StandardToken {
```
and
```
function Contract1() public {
```

are still under the same name Contract1 when you may have altered the names of the token inside of the code. It is important to distinguish between the name of the contract and the name of the token in this situation. This will have no effect on the deployment of this contract or the name and parameters you have set up for the token. Though the name of the contract is Contract1 the name of the tokens associated with that contract have no correlation with the contract name. However, it is recommended that you changed the name of the contract to indicate the name of the token it is deploying in order for you to keep track of which contract contains witch token.

Note: The file names such as Contract1.sol,Contract2.sol,and COntract3.sol will have no effect on the names of the contracts when they are compiled, however if it suites your needs feel free to change the names of these files, just remember to keep them in the .sol format.

### Setting Up Deployment Script for Contracts 
