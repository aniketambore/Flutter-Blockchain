const Hello = artifacts.require("Hello");

module.exports = function (deployer) {
  deployer.deploy(Hello);
};
