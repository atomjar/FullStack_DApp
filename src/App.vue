<script setup>
import { ref } from 'vue';
import { ethers } from 'ethers';
// import ABI for smart contract (after compilation)
import Counter from './artifacts/contracts/Counter.sol/Counter.json';

// smart contract address logged from Hard Hat CLI when it was deployed 
const counterAddress = '0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9'

let localCount = ref(0)

// request access to the user's MetaMask account
async function requestAccount() {
  await window.ethereum.request({ method: 'eth_requestAccounts' })
}

// call the smart contract, read the current Count value
async function get() {
  if (typeof window.ethereum !== 'undefined') {
    const provider = new ethers.providers.Web3Provider(window.ethereum)
    const contract = new ethers.Contract(counterAddress, Counter.abi, provider)
    try {
      const chainCount = await contract.getCount()
      localCount.value = chainCount.toNumber()
      console.log('chainCount: ', chainCount.toNumber())
      console.log('localCount: ', localCount.value)
    } catch (err) {
       console.log('Error: ', err)
    }
  }    
}

// call the smart contract, increment Count value
async function increment() {
  if (typeof window.ethereum !== 'undefined') {
    await requestAccount()
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner()
    const contract = new ethers.Contract(counterAddress, Counter.abi, signer)
    const transaction = await contract.incrementCount()
    await transaction.wait()
    get()
  }
}

// call the smart contract, decrement Count value
async function decrement() {
  if (typeof window.ethereum !== 'undefined') {
    await requestAccount()
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner()
    const contract = new ethers.Contract(counterAddress, Counter.abi, signer)
    const transaction = await contract.decrementCount()
    await transaction.wait()
    get()
  }
}
</script>

<template>
  <p>Count is: {{ localCount }}</p>
  <button @click="get">Get</button>
  <button @click="increment">Increment</button>
  <button @click="decrement">Decrement</button>
</template>

<style>
@import './assets/base.css';

#app {
  max-width: 1280px;
  margin: 0 auto;
  padding: 2rem;

  font-weight: normal;
}

body {
  display: flex;
  place-items: center;
}

button {
  margin: 2.5px;
}
</style>
