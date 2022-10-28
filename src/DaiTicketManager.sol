// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "solmate/auth/Owned.sol";
import "solmate/tokens/ERC20.sol";

contract DaiTicketManager is Owned {
    uint256 public price;
    address public token;
    mapping(address => bool) public tickets;

    constructor(
        uint256 _price,
        address _token,
        address _owner
    ) Owned(_owner) {
        price = _price;
        token = _token;
    }

    function setPrice(uint256 _price) public onlyOwner {
        price = _price;
    }

    function buyTicket() public {
        // require(msg.value == price, "The price is incorrect");
        tickets[msg.sender] = true;
				ERC20(token).transferFrom(msg.sender, address(this), price);
    }

    function hasTicket(address person) public view returns (bool) {
        return tickets[person];
    }
}
