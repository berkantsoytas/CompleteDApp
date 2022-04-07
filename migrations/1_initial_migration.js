const Migration = artifacts.require("Migration");

module.exports = async function (deployer) {
  await deployer.deploy(Migration);
};
