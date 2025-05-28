// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteTwoDynamicArraysToStorage {
    uint256[] public writeHere1;
    uint256[] public writeHere2;

    function main(uint256[] calldata x, uint256[] calldata y) external {
        assembly {
            // your code here
            // write the dynamic calldata array `x` to storage variable `writeHere1` and
            // dynamic calldata array `y` to storage variable `writeHere2`
            // read https://rareskills.io/post/abi-encoding#encoding-a-fixed-sized-array-with-static-type
            // https://rareskills.io/post/solidity-dynamic#array
            // [0x00-0x04]: Function selector| [0x04-0x24]: Offset to array x (relative to 0x04)| [0x24-0x44]: Offset to array y (relative to 0x04)| [0x44-0x64]: Length of array x | [0x64-...]: Elements of array x (32 bytes each) | [...]: Length of array y | [...]: Elements of array y
            // ========== Process Array X ==========
            let offsetX := add(calldataload(0x04), 0x04)
            let lengthX := calldataload(offsetX)

            // Store length in storage slot
            sstore(writeHere1.slot, lengthX)

            // Calculate storage location for array elements
            mstore(0x00, writeHere1.slot)
            let storageSlotX := keccak256(0x00, 0x20)

            // Copy elements from calldata to storage
            let calldataPosX := add(offsetX, 0x20)
            for { let i := 0 } lt(i, lengthX) { i := add(i, 1) } {
                sstore(storageSlotX, calldataload(calldataPosX))
                calldataPosX := add(calldataPosX, 0x20)
                storageSlotX := add(storageSlotX, 1)
            }

            // ========== Process Array Y ==========
            let offsetY := add(calldataload(0x24), 0x04)
            let lengthY := calldataload(offsetY)

            // Store length in storage slot
            sstore(writeHere2.slot, lengthY)

            // Calculate storage location for array elements
            mstore(0x00, writeHere2.slot)
            let storageSlotY := keccak256(0x00, 0x20)

            // Copy elements from calldata to storage
            let calldataPosY := add(offsetY, 0x20)
            for { let i := 0 } lt(i, lengthY) { i := add(i, 1) } {
                sstore(storageSlotY, calldataload(calldataPosY))
                calldataPosY := add(calldataPosY, 0x20)
                storageSlotY := add(storageSlotY, 1)
            }
        }
    }
}
