pragma solidity ^0.8.6;

// SPDX-License-Identifier: MIT

// Explanation: https://t.co/LLhJWCNtCh

contract PaymentSplitter {
    address payable[] public recipients;
    event TransferReceived(address _from, uint _amount);

    constructor(address payable[] memory _addrs) {
        for (uint i = 0; i < _addrs.length; i++) {
            recipients.push(_addrs[i]);
        }
    }

    receive() external payable {
        uint256 share = msg.value / recipients.length;

        for (uint i = 0; i < recipients.length; i++) {
            recipients[i].transfer(share);
        }
        emit TransferReceived(msg.sender, msg.value);
    }
}
