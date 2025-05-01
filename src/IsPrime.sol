// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract IsPrime {
    function main(uint256 x) external pure returns (bool) {
        assembly {
            // your code here
            // return true if x is a prime number, else false
            // 1. check if the number is a multiple of 2 or 3
            // 2. loop from 5 to x / 2 to see if it is divisible
            // 3. increment the loop by 2 to skip the even numbers

            // Edge cases: 0 and 1 are not prime
            if lt(x, 2) {
                mstore(0x00, 0x00)
                return(0x00, 0x20)
            }

            // 2 and 3 are prime
            if or(eq(x, 2), eq(x, 3)) {
                mstore(0x00, 0x01)
                return(0x00, 0x20)
            }

            // Exclude multiples of 2 or 3
            if or(iszero(mod(x, 2)), iszero(mod(x, 3))) {
                mstore(0x00, 0x00)
                return(0x00, 0x20)
            }

            let half := div(x, 2)

            for { let i := 5 } lt(i, half) { i := add(i, 2) } {
                if iszero(mod(x, i)) {
                    mstore(0x00, 0x00)
                    return(0x00, 0x20)
                }
            }

            mstore(0x00, 0x01) // Passed all checks — prime
            return(0x00, 0x20)
        }
    }
}
