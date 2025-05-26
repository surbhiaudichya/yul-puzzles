// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromDynamicArrayAndRevertOnFailure {
    uint256[] readMe;

    function setValue(uint256[] calldata x) external {
        readMe = x;
    }

    function main(int256 index) external view returns (uint256) {
        assembly {
            // your code here
            // read the value at the `index` in the dynamic array `readMe`
            // and return it
            // Revert with Solidity panic on failure, use error code 0x32 (out-of-bounds or negative index)
            // Hint: https://www.rareskills.io/post/solidity-dynamic
            // To-do Fix failed test
            // load array length
            let len := sload(readMe.slot)

            // if index < 0 or index >= len, revert with Panic(0x32)
            if or(lt(index, 0), iszero(lt(index, len))) {
                // Create proper Solidity panic with selector and error code
                mstore(0x00, 0x4e487b71) // Panic(uint256) selector
                mstore(0x04, 0x32) // Error code 0x32 (array out-of-bounds)
                revert(0x00, 0x24) // 36 bytes total (4 + 32)
            }

            // calculate base slot for dynamic array data
            mstore(0x00, readMe.slot)
            let base := keccak256(0x00, 0x20)

            // load element at index
            let val := sload(add(base, index))

            // return the value
            mstore(0x00, val)
            return(0x00, 0x20)
        }
    }
}
