// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "solmate/tokens/ERC721.sol";
import "solmate/auth/Owned.sol";
import "forge-std/Test.sol";

contract NftTickets is ERC721, Owned {
    uint256 currentId = 0;

    constructor(address owner) ERC721("Balelec", "ELEC") Owned(owner) {}

    function tokenURI(uint256 id) public pure override returns (string memory) {
        require(id <= 1000);
        return "https://memento.epfl.ch/image/1490/728x407.jpg";
    }

    function mint(address receiver) public onlyOwner {
				console.log("the sender of the tx", msg.sender);
        _mint(receiver, currentId++);
    }
}
