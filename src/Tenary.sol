// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract Tenary {
    uint256 public result;

    function main(uint256 a, uint256 b, uint256 c) external {
        assembly {
            // your code here
            // store `10` in the storage variable `result` if a > b,
            // else if b > c, store `20`,
            // else, store `30`
            if lt(b, a) {
                sstore(0x00, 10)
                return(0x00, 0x00)
            }
            if lt(c, b) {
                sstore(0x00, 20)
                return(0x00, 0x00)
            }
            sstore(0x00, 30)
        }
    }
}
