const Bidder = artifacts.require("Bidder");

module.exports = function (deployer) {
  deployer.deploy(Bidder);
};
