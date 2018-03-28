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

To edit the deployment script for your contract you will need to enter the migration folder and open the file 2_deploy_contracts.js. You will not need to edit 1_initial_migration.js so leave it as is. Once you have opened 2_deploy_contracts.js you will be presented with the code:

```
var Contract1 = artifacts.require("Contract1");
var Contract2 = artifacts.require("Contract2");
var Contract3 = artifacts.require("Contract3");

module.exports = function(deployer) {
  deployer.deploy(Contract1);
  deployer.deploy(Contract2);
  deployer.deploy(Contract3);
};
```

This code is designed to deploy the contracts that are listed in the order in which they are listed. At this point if you did not edit the name of the contracts in the contract files previously discussed there is no need to edit this script. However, if the names of the contracts were edited then you will need to edit all instances of your changes to this script. For instance, if you edited Contract1 to be named MyFirstToken then you would need to edit the line declaring the variable Contract1 from

```
var Contract1 = artifacts.require("Contract1");
```
to
```
var MyFirstToken = artifacts.require("MyFirstToken");
```
and the deployer line

```
deployer.deploy(Contract1);
```
to
```
deployer.deploy(MyFirstToken);
```

Remember that on the line declaring the variable, the name of the variable needs to be the same as the name of the artifact in order for it to deploy properly. Also keep in mind that again the name of the token inside each contract has no effect on the deployment of the contract itself. Only insert the name of the contracts you wish to deploy not the tokens (Unless they have the same name).

Note: This script can also be used to deploy more than 3 contracts or less than 3 contracts. In the event you want to deploy less than 3 contracts simply delete the lines declaring the variables and the lines issuing the deployment statement of the contracts you do not wish to deploy. In the event you wish to deploy more than 3 contracts simply add the variable statements and the deployment statements of the extra contracts you wish to deploy.

### Adjusting truffle.js to be able to communicate with your Ethereum Wallet

The file truffle.js can be found immediately when you enter truffle-multicontract-deployment. Open the file and you will be presented with the code:

```
var HDWalletProvider = require("truffle-hdwallet-provider");

var infura_apikey = "XXXXXX";
var mnemonic = "INSERT 12 WORD HD WALLET PHRASE IN HERE";

module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    },
    ropsten: {
      provider: new HDWalletProvider(mnemonic, "https://ropsten.infura.io/"+infura_apikey),
      network_id: 3,
      gas: 4000000,
    }
  }
};
```
The only edit that needs to be made to this code is on the third line:
```
var mnemonic = "INSERT 12 WORD HD WALLET PHRASE IN HERE";
```
When setting up your ethereum wallet you should have been presented with a 12 word phrase of random words. You will need to paste this phrase into the quotations so it will read as follows:

```
var mnemonic = "word1 word2 word3 word4 word5 word6 word7 word8 word9 word10 word11 word12 ";
```
This will grant this program access to your Ethereum wallet and will both deploy and call the contract using this address. Because this passphrase can be used to access your ethereum wallet it is suggested that you do not use this program anywhere but a local machine to prevent others from gaining access to your wallet. For added protection possibly set up a new wallet purely for testing so that you will not have any Ethereum on the Main Net to lose in the event someone were to gain access.

Note: This is the only line that will need to be edited in this script for it to function, however the gas limit can be adjusted to lower the cost. Keep in mind that if the gas limit is too low then you run the risk of the contract not deploying due to the limit being too low.

Note: By default this will access address0 (meaning the first address listed) in your Ethereum wallet. Therefore you will need to make sure that this address is has funds in it to pay for the gas of these contracts. Even if you have other addresses in your wallet with funds this will not pull funds from them in the event address0 has inadequate Ether.

### Compiling the Contracts Using truffle
At this point all necessary edits have been made and you can begin the compilation and deployment of the contracts. To compile the contracts you will will need to open your terminal and go to your truffle-multicontract-deployment folder. Once there type in the command:

```
truffle compile
```
And provided there are no errors with in a few moments the contracts you have created will be compiled with this messaged displayed in your terminal:

```
Compiling ./contracts/Contract1.sol...
Compiling ./contracts/Contract2.sol...
Compiling ./contracts/Contract3.sol...
Compiling ./contracts/Migrations.sol...
Compiling zeppelin-solidity/contracts/math/SafeMath.sol...
Compiling zeppelin-solidity/contracts/token/ERC20/BasicToken.sol...
Compiling zeppelin-solidity/contracts/token/ERC20/ERC20.sol...
Compiling zeppelin-solidity/contracts/token/ERC20/ERC20Basic.sol...
Compiling zeppelin-solidity/contracts/token/ERC20/StandardToken.sol...
Writing artifacts to ./build/contracts
```
You may notice that this will create a new folder in truffle-multicontract-deployment named build. When opening the build folder there will be another folder named contracts inside of this. Contained in this folder are a variety of standard contracts that were compiled by truffle as well as the contracts that you have created yourself. Notice that the file name for these contracts is dependent on the name you gave the contract in your file and not dependent on the name of the file that contract is contained in the .sol file that you edited. Feel free to open these compiled contracts and view the code that will construct them when you deploy. No editing should be made to these contracts as it would jeopardize the stability of them, however if you want to see how they are constructed look through them.

### Launching geth to deploy a node onto the Ethereum Test Netowk

At this point you will need to open a new command terminal. Once the terminal is open simply put in the command:

```
geth --testnet --fast --rpc --rpcapi eth,net,web3,personal
```
Your geth node should begin running and you will see an entire slew of continuous statments which are declaring the hashes of the test network you are not apart of. This command is technically outside of the scope of this tutorial as you only need the testnet and rpc command in geth for it to function properly. However, this command will "cover all your bases" in terms of the functionality of the of this geth node.

### (Finally) Deploying the Contracts onto the Ropsten Test Network

Now that you have your contracts compiled and your geth node operational, you can finally deploy your contracts to the Ropsten Test Network. You will need to be in the terminal that is located inside of the truffle-multicontract-deployment. Simply type in this command and the deployment should begin.

```
truffle migrate --network ropsten
```
And viola, your contracts will begin to deploy. This process can take several minutes to complete depending on the number of contracts you have queued, but when the process is complete you should have a statement that reads something similar to:

```
Using network 'ropsten'.

Running migration: 1_initial_migration.js
  Deploying Migrations...
  ... 0x44b59c69d2010b7864475788fe48c2ca87cc552fac6242a36604abe9d566addf
  Migrations: 0xec05e5ccdaaf65fadaf503ebfd91a922557b9403
Saving successful migration to network...
  ... 0x9f27ca60e3247372353f25104426594395da31dd6953d2ce9ea4b851ad92898e
Saving artifacts...
Running migration: 2_deploy_contracts.js
  Deploying Contract1...
  ... 0xef4b318c7cfa3760713312cdda878136478046db78e48a5b550a2cd36e1c29ec
  Contract1: 0x7daedbd1d5ce0f3c8e2c5c6a15dadb05eb1d30c8
  Deploying Contract2...
  ... 0x6cffedb7410a914513c95430cac4dc51bb033aeb0a88d0274efdb9cfe6bb585f
  Contract2: 0x059d018f44dd5ef443e2a16d4e54079629a8d821
  Deploying Contract3...
  ... 0x606feb95cfa5972994fc71d1f18782e065044496860678badc3c8816d0801f94
  Contract3: 0xd5dff2e671443afa0a9a963f74b3c6b0179bb4d1
Saving successful migration to network...
  ... 0x319bdeec7b9beb4fb6630967fb36aa9dd806ec62974e929953b89e91beba1e4b
Saving artifacts...
```
If you received this message that indicates that all 3 contracts were successfully deployed to the Ropsten Test Network, and the tokens should have been issued to the wallet address you were using. Notice after each statement declaring that a contract was deployed there is a message that will look something like this for each contract"

```
Contract1: 0x7daedbd1d5ce0f3c8e2c5c6a15dadb05eb1d30c8
```
This is the ID associated with the contract and can be used to find the contract on places such as [Etherscan](https://ropsten.etherscan.io/) for the Ropsten Test Network.

This concludes the tutorial to deploy ERC20 Tokens to the Ropsten Test Network. I hope this guide was helpful for you to understand and successfully deploy these tokens.
