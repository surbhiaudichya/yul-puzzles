// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromDynamicArray {
    uint256[] readMe;

    function setValue(uint256[] calldata x) external {
        readMe = x;
    }

    function main(uint256 index) external view returns (uint256) {
        assembly {
            // your code here
            // read the value at the `index` in the dynamic array `readMe`
            // and return it
            // Assume `index` is <= to the length of readMe
            // Hint: https://www.rareskills.io/post/solidity-dynamic
            let storageSlot := readMe.slot
            // The keccak hash of the storage slot of readMe (i.e 0) points to the slot holding the first element,
            // then we keep adding 1 to that value to get the storage locations of other indexes in the array
            let slot := add(keccak256(storageSlot, 0x20), index)
            // used the sload opcode to load the value from the slot.
            let value := sload(slot)
            mstore(0x00, value)
            return(0x00, 0x20)
        }
    }
}
