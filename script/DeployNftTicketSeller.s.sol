// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/NftTicketManager.sol";
import "../src/NftTickets.sol";

contract DeployReentrant is Script {
    // address myAddress = 0xa4049faab47BbD7fdbA8783C7b64CC6b9c7d5920;

    function run(address myAddress) public {
        vm.startBroadcast(myAddress);
				NftTickets nft = new NftTickets(myAddress);
				NftTicketManager tm = new NftTicketManager(1 ether, address(nft), myAddress);
				nft.setOwner(address(tm));
				vm.stopBroadcast();
    }
}
