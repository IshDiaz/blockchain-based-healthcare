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

    function addRecord(uint recordId, string memory dataHash) public {
        Record storage record = records[recordId];
        record.dataHash = dataHash;
        record.owner = msg.sender;
        emit RecordAdded(recordId, msg.sender);
    }

    function grantAccess(uint recordId, address user) public {
        require(records[recordId].owner == msg.sender, "Not authorized");
        records[recordId].permissions[user] = true;
        emit AccessGranted(recordId, user);
    }
}
