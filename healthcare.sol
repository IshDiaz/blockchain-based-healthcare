// SPDX-License-Identifier: MIT
// Specifies the license type for the contract, ensuring compliance with open-source standards.
pragma solidity ^0.8.0; // Declares the Solidity version to be used, ensuring compatibility with features of version 0.8.x.

contract Healthcare {
    // Structure to store a healthcare record.
    struct Record {
        string dataHash; // The hashed value of the healthcare data.
        address owner; // The Ethereum address of the record owner (e.g., patient).
        mapping(address => bool) permissions; // A mapping to track which addresses have access to the record.
    }

    // A mapping to store records using a unique recordId as the key.
    mapping(uint => Record) public records;

    // Events to emit changes for logging and tracking on the blockchain.
    event RecordAdded(uint recordId, address owner); // Emitted when a new record is added.
    event AccessGranted(uint recordId, address user); // Emitted when access is granted to a user.
    event AccessRevoked(uint recordId, address user); // Emitted when access is revoked from a user.

    // Function to add a new healthcare record.
    // Parameters:
    // - recordId: A unique identifier for the record.
    // - dataHash: The hashed value of the data being stored.
    function addRecord(uint recordId, string memory dataHash) public {
        Record storage record = records[recordId]; // Access or create the record with the given recordId.
        record.dataHash = dataHash; // Store the hash of the data in the record.
        record.owner = msg.sender; // Set the sender's address as the owner of the record.
        emit RecordAdded(recordId, msg.sender); // Emit the RecordAdded event.
    }

    // Function to grant access to a specific user for a healthcare record.
    // Parameters:
    // - recordId: The identifier for the record.
    // - user: The address of the user being granted access.
    function grantAccess(uint recordId, address user) public {
        require(records[recordId].owner == msg.sender, "Not authorized"); // Ensure the caller is the record owner.
        records[recordId].permissions[user] = true; // Grant access to the specified user.
        emit AccessGranted(recordId, user); // Emit the AccessGranted event.
    }

    // Function to revoke access from a specific user for a healthcare record.
    // Parameters:
    // - recordId: The identifier for the record.
    // - user: The address of the user being revoked access.
    function revokeAccess(uint recordId, address user) public {
        require(records[recordId].owner == msg.sender, "Not authorized"); // Ensure the caller is the record owner.
        records[recordId].permissions[user] = false; // Revoke access from the specified user.
        emit AccessRevoked(recordId, user); // Emit the AccessRevoked event.
    }

    // Function to view the data hash of a healthcare record.
    // Parameters:
    // - recordId: The identifier for the record.
    // Returns:
    // - The hash of the data if the caller has permission to view it.
    function viewRecord(uint recordId) public view returns (string memory) {
        require(records[recordId].permissions[msg.sender], "Access denied"); // Ensure the caller has permission to view the record.
        return records[recordId].dataHash; // Return the hash of the data.
    }
}
