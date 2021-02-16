const Minter = artifacts.require("Minter");

module.exports = function (deployer) {
  deployer.deploy(Minter);
};
