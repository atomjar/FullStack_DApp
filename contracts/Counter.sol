// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Counter {
    uint public count;

    // Function to get the current count
    function getCount() public view returns (uint) {
        return count;
    }

    // Function to increment count by 1
    function incrementCount() public {
        count += 1;
    }

    // Function to decrement count by 1
    function decrementCount() public {
        // This function will fail if count = 0
        count -= 1;
    }
}