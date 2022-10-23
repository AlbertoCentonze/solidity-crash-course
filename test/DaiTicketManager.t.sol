// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/DaiTicketManager.sol";
import "solmate/tokens/ERC20.sol";

contract CustomPriceTicketManagerTest is Test {
    DaiTicketManager public tm;
		address DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
		address alice = makeAddr("alice");
		address bob = makeAddr("bob");

    function setUp() public {
			 vm.createSelectFork("https://rpc.ankr.com/eth");
       tm = new DaiTicketManager(1, alice, DAI);
    }

		function testBuyWithDai() public {
			address RICH_GUY = 0x7a4878CB7b18F9818176041675D548345fCdb9f4;
			vm.label(RICH_GUY, "rich_guy");
			vm.startPrank(RICH_GUY);
			ERC20(DAI).approve(address(tm), 1);
			console.log(ERC20(DAI).balanceOf(RICH_GUY));
			tm.buyTicket();
		}
}
