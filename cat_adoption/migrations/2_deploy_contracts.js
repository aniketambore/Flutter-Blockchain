const CatAdoption = artifacts.require("CatAdoption");

module.exports = function (deployer) {
  deployer.deploy(CatAdoption);
};
