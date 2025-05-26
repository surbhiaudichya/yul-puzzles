// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteDynamicArrayToStorage {
    uint256[] public writeHere;

    function main(uint256[] calldata x) external {
        assembly {
            // your code here
            // write the dynamic calldata array `x` to storage variable `writeHere`
            //[Function Selector (4 bytes)] [Offset to x (32 bytes)] [Length of x (32 bytes)] [x[0] (32 bytes)] [x[1] (32 bytes)] ...
            let length := calldataload(0x24)
            // The storage slot allocated for the length of the array is the same slot for the array storage variable (base slot)
            let baseSlot := writeHere.slot
            sstore(baseSlot, length)
            mstore(0x00, baseSlot)
            let firstElementSlot := keccak256(0x00, 0x20)
            for { let i := 0 } lt(i, length) { i := add(i, 1) } {
                let elementSlot := add(firstElementSlot, i)
                let elementValue := calldataload(add(0x44, mul(i, 0x20)))
                sstore(elementSlot, elementValue)
            }
        }
    }
}
