// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/NftTicketManager.sol";
import "../src/NftTickets.sol";

contract DeployReentrant is Script {
    address myAddress = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;

    function run() public {
        vm.startBroadcast(myAddress);
				NftTickets nft = new NftTickets(myAddress);
				NftTicketManager tm = new NftTicketManager(1 ether, address(nft), myAddress);
				nft.setOwner(address(tm));
				vm.stopBroadcast();
    }
}
