// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "solmate/auth/Owned.sol";
import "solmate/tokens/ERC20.sol";
import "./NftTickets.sol";
import "forge-std/Test.sol";

contract NftTicketManager is Owned {
    uint256 public price;
    address public token;
    address public nft;

    constructor(
        uint256 _price,
        address _nft,
        address _owner
    ) Owned(_owner) {
        price = _price;
        nft = _nft;
    }

    function setPrice(uint256 _price) public onlyOwner {
        price = _price;
    }

    function buyTicket() public payable {
        require(msg.value == price, "The price is incorrect");
        NftTickets(nft).mint(msg.sender);
    }

    function hasTicket(address person) public view returns (uint256) {
        return ERC721(nft).balanceOf(person);
    }
}
