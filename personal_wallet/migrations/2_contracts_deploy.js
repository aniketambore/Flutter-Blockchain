const PersonalCoin = artifacts.require("PersonalCoin");

module.exports = function (deployer) {
  deployer.deploy(PersonalCoin);
};
