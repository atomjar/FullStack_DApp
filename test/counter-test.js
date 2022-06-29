const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('Counter', function () {
  it('Should return the new count value once changed', async function () {
    const Counter = await ethers.getContractFactory('Counter')
    const counter = await Counter.deploy()
    await counter.deployed()

    expect(await counter.getCount()).to.equal(0)

    const incrementCountTx = await counter.incrementCount()
    // wait until the transaction is mined
    await incrementCountTx.wait()
    expect(await counter.getCount()).to.equal(1)

    const decrementCountTx = await counter.decrementCount()
    // wait until the transaction is mined
    await decrementCountTx.wait()
    expect(await counter.getCount()).to.equal(0)
  })
})