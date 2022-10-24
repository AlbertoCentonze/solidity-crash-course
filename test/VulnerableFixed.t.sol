// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/VulnerableFixed.sol";
import "../src/Attack.sol";

contract VulnerableTest is Test {
	address alice = makeAddr("alice");
	EtherSafeStore s;

	function setUp() public {
		s = new EtherSafeStore();
		deal(alice, 1 << 128);
		s.deposit{value: 10 ether}();
	}

	function testAttackFails() public {
		Attack attack = new Attack((address(s)));
		vm.prank(alice);
		vm.expectRevert();
		attack.attack{value: 1 ether}();
		assertEq(address(attack).balance, 0);
	}
}