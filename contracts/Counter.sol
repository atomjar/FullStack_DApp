// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Counter {
    // data stored on blockchain
    uint public count;

    // get the current count
    function getCount() public view returns (uint) {
        return count;
    }

    // increment count by 1
    function incrementCount() public {
        count += 1;
    }

    // decrement count by 1
    function decrementCount() public {
        // will fail if count = 0
        count -= 1;
    }
}