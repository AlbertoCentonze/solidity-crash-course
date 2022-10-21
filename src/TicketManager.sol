// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract TicketManager {
    uint256 price;
    mapping(address => bool) public tickets;

    constructor(uint256 _price) {
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
