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
