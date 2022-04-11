const decentralBank = artifacts.require("DecentralBank");

module.exports = async function issueRewards(callback) {
  let dcBank = await decentralBank.deployed();
  await dcBank.issueTokens();
  console.log("Tokens have been issued successfuly");
  callback();
};
