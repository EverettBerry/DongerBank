var StockExchange = artifacts.require("./StockExchange.sol");
var DongerBank = artifacts.require("./DongerBank.sol");
module.exports = function(deployer) {
  deployer.deploy(StockExchange);
  deployer.deploy(DongerBank);
};
