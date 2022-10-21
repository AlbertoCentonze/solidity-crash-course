// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "solmate/auth/Owned.sol";

contract CustomPriceTicketManager is Owned {
    uint256 public price;
    mapping(address => bool) public tickets;

    constructor(uint256 _price, address owner) Owned(owner) {
        price = _price;
    }

		function setPrice(uint256 _price) public onlyOwner {
			price = _price;
		}

    function buyTicket() public payable {
        require(msg.value == price, "The price is incorrect");
        tickets[msg.sender] = true;
    }

    function hasTicket(address person) public view returns (bool) {
        return tickets[person];
    }
}