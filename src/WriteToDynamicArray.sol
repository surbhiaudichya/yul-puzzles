// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToDynamicArray {
    uint256[] writeHere;

    function main(uint256[] memory x) external {
        assembly {
            // your code here
            // store the values in the DYNAMIC array `x` in the storage variable `writeHere`
            // Hint: https://www.rareskills.io/post/solidity-dynamic
            // slorage slot of writeHere array
            let storageSlot := writeHere.slot
            // gives the length of the dynamic memory array
            let length := mload(x)
            // loop through array
            for { let i := 0 } lt(i, length) { i := add(i, 1) } {
                let value := mload(add(add(x, 0x20), mul(0x20, i)))

                //The storage slot allocated for the length of the array is the same slot for the array storage variable (base slot).
                // Store length in storage.
                sstore(storageSlot, length)
                // Store the elements
                // The storage slot for the first element (index 0) is determined by the keccak256 hash of the base storage slot (the slot where the variable is declared)
                // then we keep adding 1 to that value to get the storage locations of other indexes in the array
                sstore(add(keccak256(storageSlot, 0x20), i), value)
            }
        }
    }

    function getter() external view returns (uint256[] memory) {
        return writeHere;
    }
}
