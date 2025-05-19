// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract PushToDynamicArray {
    uint256[] pushToMe = [23, 4, 19, 3, 44, 88];

    function main(uint256 newValue) external {
        assembly {
            // your code here
            // push the newValue to the dynamic array `pushToMe`
            // Hint: https://www.rareskills.io/post/solidity-dynamic
            let baseSlot := pushToMe.slot
            let length := sload(baseSlot) // get current array length
            let dataSlot := keccak256(0x00, 0x20) // will be overwritten below

            // store baseSlot at 0x00 for hashing
            mstore(0x00, baseSlot)
            let elementSlot := keccak256(0x00, 0x20) // slot of pushToMe[0]

            // write the new value at slot + length
            sstore(add(elementSlot, length), newValue)

            // update length in baseSlot
            sstore(baseSlot, add(length, 1))
        }
    }

    function getter() external view returns (uint256[] memory) {
        return pushToMe;
    }
}
