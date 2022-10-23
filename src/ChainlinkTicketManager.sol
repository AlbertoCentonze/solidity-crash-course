// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "solmate/auth/Owned.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

contract ChainlinkTicketManager is Owned {
    using PriceConverter for uint256;
    uint256 public price;
    mapping(address => bool) public tickets;
    AggregatorV3Interface private s_priceFeed;

    constructor(
        uint256 _price,
        address owner,
        address priceFeed
    ) Owned(owner) {
        price = _price;
        s_priceFeed = AggregatorV3Interface(priceFeed);
    }

    function setPrice(uint256 _price) public onlyOwner {
        price = _price;
    }

    function buyTicket() public payable {
        require(
            msg.value.getConversionRate(s_priceFeed) == price,
            "The price is incorrect"
        );
        tickets[msg.sender] = true;
    }

    function hasTicket(address person) public view returns (bool) {
        return tickets[person];
    }

    function getPriceFeed() public view returns (AggregatorV3Interface) {
        return s_priceFeed;
    }
}
