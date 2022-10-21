// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/TicketManager.sol";

contract TicketManagerTest is Test {
    TicketManager public tm;

    function setUp() public {
        tm = new TicketManager(1 ether);
    }

    function testBuyDoesNotFail() public {
        tm.buyTicket{value: 1 ether}();
    }

    function testBuyFails(uint256 price) public {
        vm.assume(price > 1 ether && price <= 100 ether);
        vm.expectRevert(bytes("The price is incorrect"));
        tm.buyTicket{value: price}();
    }

    function testTicketIsAssigned() public {
				address alice = makeAddr("alice");
        assertFalse(tm.hasTicket(alice));
				hoax(alice);
				tm.buyTicket{value: 1 ether}();
        assertTrue(tm.hasTicket(alice));
    }

}
