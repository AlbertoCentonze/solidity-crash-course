// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/CustomPriceTicketManager.sol";

contract CustomPriceTicketManagerTest is Test {
    CustomPriceTicketManager public tm;
		address alice = makeAddr("alice");
		address bob = makeAddr("bob");

    function setUp() public {
       tm = new CustomPriceTicketManager(1 ether, alice);
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
			vm.expectRevert(bytes("You're not the owner"));
			tm.setPrice(1);
		}
}
