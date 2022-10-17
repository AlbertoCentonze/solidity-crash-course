// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

contract CounterScript is Script {
    address test = address(1);
		address myAddress = 0xa4049faab47BbD7fdbA8783C7b64CC6b9c7d5920;
		address[] crashCourseParticipants;
		// 0xcaed24bc0f544da74fcfeb9e7f3ce516237e001b917e12d5995a1327fdb3b8c1
		// forge script ./script/Counter.s.sol --rpc-url https://rpc.testnet.fantom.network/ --broadcast --interactives 1

    function setUp() public {}

    function run() public {
        vm.startBroadcast(myAddress);
				for (uint160 i = 0; i < 6; ++i) {
					crashCourseParticipants.push(address(i + 1));
					crashCourseParticipants[i].call{value: 1 wei}("");
				}
    }

}
