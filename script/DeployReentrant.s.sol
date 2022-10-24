// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Vulnerable.sol";

contract DeployReentrant is Script {
    address myAddress = 0xa4049faab47BbD7fdbA8783C7b64CC6b9c7d5920;

    function run() public {
        vm.startBroadcast(myAddress);
        EtherStore store = new EtherStore();
				store.deposit{value: 2 ether}();
    }
}
