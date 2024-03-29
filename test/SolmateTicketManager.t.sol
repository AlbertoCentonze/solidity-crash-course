// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/SolmateTicketManager.sol";

contract SolmateTicketManagerTest is Test {
    SolmateTicketManager public tm;
		address alice = makeAddr("alice");
		address bob = makeAddr("bob");

    function setUp() public {
       tm = new SolmateTicketManager(1 ether, alice);
    }

		function testChangePrice(uint256 newPrice) public {
			vm.assume(newPrice >= 0.5 ether || newPrice <= 10 ether);
			assertEq(tm.price(), 1 ether);
			vm.prank(alice);
			tm.setPrice(newPrice);
			assertEq(tm.price(), newPrice);
		}

		function testOnlyOwnerUnauthorized() public {
			vm.prank(bob);
			vm.expectRevert(bytes("UNAUTHORIZED"));
			tm.setPrice(1);
		}
}
