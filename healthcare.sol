// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Healthcare {
    struct Record {
        string dataHash;
        address owner;
        mapping(address => bool) permissions;
    }

    mapping(uint => Record) public records;

    event RecordAdded(uint recordId, address owner);
    event AccessGranted(uint recordId, address user);
    event AccessRevoked(uint recordId, address user);
}
