<script setup>
import { ref } from 'vue';
import { ethers } from 'ethers';
// Import ABI for smart contract (after compilation)
import Counter from './artifacts/contracts/Counter.sol/Counter.json';

// smart contract address logged from Hard Hat CLI when it was deployed: 
const counterAddress = '0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512'

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
       console.log("Error: ", err)
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
  <div>
    <p>Count is: {{ localCount }}</p>
    <button @click="get">Get</button>
    <button @click="increment">Increment</button>
    <button @click="decrement">Decrement</button>
  </div>
</template>

<style>
@import './assets/base.css';

#app {
  max-width: 1280px;
  margin: 0 auto;
  padding: 2rem;

  font-weight: normal;
}

header {
  line-height: 1.5;
}

.logo {
  display: block;
  margin: 0 auto 2rem;
}

a,
.green {
  text-decoration: none;
  color: hsla(160, 100%, 37%, 1);
  transition: 0.4s;
}

@media (hover: hover) {
  a:hover {
    background-color: hsla(160, 100%, 37%, 0.2);
  }
}

@media (min-width: 1024px) {
  body {
    display: flex;
    place-items: center;
  }

  #app {
    display: grid;
    grid-template-columns: 1fr 1fr;
    padding: 0 2rem;
  }

  header {
    display: flex;
    place-items: center;
    padding-right: calc(var(--section-gap) / 2);
  }

  header .wrapper {
    display: flex;
    place-items: flex-start;
    flex-wrap: wrap;
  }

  .logo {
    margin: 0 2rem 0 0;
  }
}
</style>
