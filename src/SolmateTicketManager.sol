// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract CustomPriceTicketManager {
		address public owner;
    uint256 public price;
    mapping(address => bool) public tickets;

    constructor(uint256 _price, address _owner) {
        price = _price;
				owner = _owner;
    }

		modifier onlyOwner() {
			require(msg.sender == owner, "You're not the owner");
			_;
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