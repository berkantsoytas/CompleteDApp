const Tether = artifacts.require("Tether");
const RWD = artifacts.require("RWD");
const DecentralBank = artifacts.require("DecentralBank");

/**
 *
 * @param {Function} deployer
 * @param {number} network
 * @param {string} account
 */

module.exports = async function (deployer, network, accounts) {
  // Deploy Tether Contract
  await deployer.deploy(Tether);
  const tether = await Tether.deployed();

  // Deploy RWD Contract
  await deployer.deploy(RWD);
  const rwd = await RWD.deployed();

  // Deploy DecentralBank Contract
  await deployer.deploy(DecentralBank, rwd.address, tether.address);
  const decentralBank = await DecentralBank.deployed();

  // Transfer all RWD tokens to DecentralBank
  await rwd.transfer(DecentralBank.address, "1000000000000000000000000");

  // Distribute 100 Tether tokens to investor
  await tether.transfer(accounts[0], "1000000000000000000");
};
