// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract MaxOfArray {
    function main(uint256[] memory arr) external pure returns (uint256) {
        assembly {
            // your code here
            // return the maximum value in the array
            // revert if array is empty
            if lt(calldatasize(), 0x24) { revert(0, 0) }
            let length := calldataload(0x24)
            if iszero(length) { revert(0, 0) }

            let x := 0x44 // first element
            let max := calldataload(x)

            for { let i := 1 } lt(i, length) { i := add(i, 1) } {
                x := add(x, 0x20)
                let val := calldataload(x)
                if gt(val, max) { max := val }
            }
            mstore(0x00, max)
            return(0x00, 0x20)
        }
    }
}
