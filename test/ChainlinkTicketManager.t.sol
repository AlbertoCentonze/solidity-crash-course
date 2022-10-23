// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/CustomPriceTicketManager.sol";

contract ChainlinkTicketManagerTest is Test {
    ChainlinkTicketManager public tm;
    address alice = makeAddr("alice");
    address bob = makeAddr("bob");
    address priceFeed = "0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e"; // goerli ETH/USD price feed address

    function setUp() public {
        tm = new ChainlinkTicketManager(1 ether, alice, priceFeed);
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
