// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/NftTicketManager.sol";
import "../src/NftTickets.sol";

contract TicketManagerTest is Test {
    NftTicketManager public tm;
		address alice = makeAddr("alice");
		address bob = makeAddr("bob");
		NftTickets nft;

	function setUp() public {
		deal(alice, 100 ether);
		vm.startPrank(alice);
		nft = new NftTickets(alice);
		tm = new NftTicketManager(1 ether, address(nft), alice);
		nft.setOwner(address(tm));
		vm.stopPrank();
	}

	function testAliceCantMint() public {
		vm.startPrank(alice);
		vm.expectRevert(bytes("UNAUTHORIZED"));
		nft.mint(alice);
		vm.stopPrank();
	}

	function testMint() public {
		vm.prank(alice);
		tm.buyTicket{value: 1 ether}();
		assertEq(tm.hasTicket(alice), 1);
		assertEq(nft.ownerOf(0), alice);
	}
}