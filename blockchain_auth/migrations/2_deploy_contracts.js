const Auth = artifacts.require("Auth");

module.exports = function (deployer) {
  deployer.deploy(Auth);
};
