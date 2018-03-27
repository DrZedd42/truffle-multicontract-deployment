var Contract1 = artifacts.require("Contract1");
var Contract2 = artifacts.require("Contract2");
var Contract3 = artifacts.require("Contract3");

module.exports = function(deployer) {
  deployer.deploy(Contract1);
  deployer.deploy(Contract2);
  deployer.deploy(Contract3);
};

