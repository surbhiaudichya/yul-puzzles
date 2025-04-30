// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract RevertWithError {
    function main() external pure {
        assembly {
            // revert the function with an error of type `Error(string)`
            // use "RevertRevert" as error message
            // Hint: The error type is a predefined four bytes. See https://www.rareskills.io/post/try-catch-solidity

            // Revert with a reason in assembly
            //returned data: the function selector of the Error(string) function, the offset of the string, the length, and the content of the string encoded in hexadecimal.
            mstore(0x00, 0x08c379a000000000000000000000000000000000000000000000000000000000) // function selector
            mstore(0x04, 0x0000000000000000000000000000000000000000000000000000000000000020) // offset
            mstore(0x24, 0x000000000000000000000000000000000000000000000000000000000000000c) // legth of "RevertRevert"
            mstore(0x44, 0x5265766572745265766572740000000000000000000000000000000000000000) // string "RevertRevert" in bytes
            revert(0x00, 0x64)
        }
    }
}
