const Election = artifacts.require("Election");

module.exports = function (deployer) {
  deployer.deploy(Election);
};
