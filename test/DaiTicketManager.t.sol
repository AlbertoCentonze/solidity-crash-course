// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "solmate/tokens/ERC20.sol";
import "../src/DaiTicketManager.sol";

contract CustomPriceTicketManagerTest is Test {
    DaiTicketManager public tm;
    address DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
		address RICH_GUY = 0x9E64B47bBdb9c1F7B599f11987b84C416C0c4110;
    address alice = makeAddr("alice");
    address bob = makeAddr("bob");

    function setUp() public {
        vm.label(RICH_GUY, "rich_guy");
				vm.label(DAI, "dollars");
        vm.createSelectFork("https://rpc.ankr.com/eth", 15813505);
        vm.prank(RICH_GUY);
				ERC20(DAI).transfer(alice, 1 ether);
        tm = new DaiTicketManager(1 ether, DAI, alice);
    }

    function testBuyWithDai() public {
				vm.startPrank(alice);
				ERC20(DAI).approve(address(tm), 1 ether);
        tm.buyTicket();
    }
}
