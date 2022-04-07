const RWD = artifacts.require("RWD");
const Tether = artifacts.require("Tether");
const DecentralBank = artifacts.require("DecentralBank");

const assert = require("assert");

require("chai").use(require("chai-as-promised")).should();

contract("decentralBank", (accounts) => {
  let tether, rwd, dcBank;

  function tokens(number) {
    return web3.utils.toWei(number, `ether`);
  }

  before(async () => {
    // load the contract before each test
    tether = await Tether.new();
    rwd = await RWD.new();
    dcBank = await DecentralBank.new(tether.address, rwd.address);

    // Transfer all tokens to DecentralBank (1 million)
    await rwd.transfer(dcBank.address, tokens("1000000"));

    // Transfer 100 mock Tethers to Customer
    await tether.transfer(accounts[1], tokens("100"), { from: accounts[0] });
  });

  describe("Decentral Bank Test", async () => {
    it("Tether Deployment & Matches name Successfully", async () => {
      const name = await tether.name();
      assert.equal(name, "Tether");
    });

    it("RWD Deployemnt & Matches name Successfully", async () => {
      const name = await rwd.name();
      assert.equal(name, "Reward Token");
    });

    it("Decentral Bank Deployment & Matches name Successfully", async () => {
      const name = await dcBank.name();
      assert.equal(name, "Decentral Bank");
    });

    it("contract has tokens", async () => {
      let balance = await rwd.balanceOf(dcBank.address);
      assert.equal(balance, tokens("1000000"));
    });
  });
});
