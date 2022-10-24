// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "solmate/auth/Owned.sol";
import "solmate/tokens/ERC20.sol";

import "./NftTickets.sol";

contract NftTicketManager is Owned {
    uint256 public price;
    address public token;
		address public nft;
    mapping(address => bool) public tickets;

    constructor(
        uint256 _price,
        address _token,
				address _nft,
        address owner
    ) Owned(owner) {
        price = _price;
        token = _token;
        nft = _nft;
    }

    function setPrice(uint256 _price) public onlyOwner {
        price = _price;
    }

    function buyTicket() public {
        tickets[msg.sender] = true;
				ERC20(token).transferFrom(msg.sender, address(this), price);
				NftTickets(nft).mint();
    }

    function hasTicket(address person) public view returns (bool) {
        return tickets[person];
    }
}
