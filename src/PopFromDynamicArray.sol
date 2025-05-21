// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract PopFromDynamicArray {
    uint256[] popFromMe = [23, 4, 19, 3, 44, 88];

    function main() external {
        assembly {
            // your code here
            // pop the last element from the dynamic array `popFromMe`
            // dont forget to clean the popped element's slot.
            // Hint: https://www.rareskills.io/post/solidity-dynamic
            let baseSlot := popFromMe.slot
            let length := sload(baseSlot) // get current array length

            // store baseSlot at 0x00 for hashing
            mstore(0x00, baseSlot)
            let elementSlot := keccak256(0x00, 0x20)

            // pop the value at slot + length-1
            sstore(add(elementSlot, sub(length, 1)), 0)

            // update length in baseSlot
            sstore(baseSlot, sub(length, 1))
        }
    }

    function getter() external view returns (uint256[] memory) {
        return popFromMe;
    }

    function lastElementSlotValue(bytes32 s) external view returns (uint256 r) {
        assembly {
            r := sload(s)
        }
    }
}
