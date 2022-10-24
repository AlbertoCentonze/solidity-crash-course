// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Vulnerable.sol";
import "../src/Attack.sol";

contract VulnerableTest is Test {
	address alice = makeAddr("alice");
	EtherStore s;

	function setUp() public {
		s = new EtherStore();
		hoax(alice);
		s.deposit{value: 10 ether}();
	}

	function testAttack() public {
		Attack attack = new Attack((address(s)));
		assertEq(address(attack).balance, 0);
		vm.prank(alice);
		attack.attack{value: 1 ether}();
		assertEq(address(attack).balance, 11 ether);
	}
}