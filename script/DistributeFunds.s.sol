// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

contract DistributeFunds is Script {
    address myAddress = 0xa4049faab47BbD7fdbA8783C7b64CC6b9c7d5920;
    address[] participants;

    // 0xcaed24bc0f544da74fcfeb9e7f3ce516237e001b917e12d5995a1327fdb3b8c1
    // forge script ./script/Counter.s.sol --rpc-url https://rpc.testnet.fantom.network/ --broadcast --interactives 1

    function setUp() public {
        participants.push(address(0));
        participants.push(address(1));
        participants.push(address(2));
        participants.push(address(3));
    }

    function run() public {
        vm.startBroadcast(myAddress);
        for (uint256 i = 0; i < participants.length; ++i) {
            (bool success, ) = participants[i].call{value: 1 wei}("");
						require(success, "Couldn't send funds to all addresses");
        }
				vm.stopBroadcast();
    }
}
