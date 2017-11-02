pragma solidity ^0.4.11;

import "./BuffCoins.sol";

contract BuffCoinsPreSale {
    BuffCoins public token;
    address public beneficiary;
    uint public amountRaised;
    uint public bonus;

    uint constant public price = 33300000;
    uint constant public minSaleAmount = 100000000;

    function BuffCoinsPreSale(
        BuffCoins _token,
        address _beneficiary,
        uint _bonus
    ) {
        token = BuffCoins(_token);
        beneficiary = _beneficiary;
        bonus = _bonus;
    }

    function () payable {
        uint amount = msg.value;
        uint tokenAmount = amount / price;
        if (tokenAmount < minSaleAmount) throw;
        amountRaised += amount;
        token.transfer(msg.sender, tokenAmount * (100 + bonus) / 100);
    }

    function WithdrawETH(uint _amount) {
        require(msg.sender == beneficiary);
        msg.sender.transfer(_amount);
    }

    function WithdrawTokens(uint _amount) {
        require(msg.sender == beneficiary);
        token.transfer(beneficiary, _amount);
    }

    function TransferTokens(address _to, uint _amount) {
        require(msg.sender == beneficiary);
        token.transfer(_to, _amount);
    }

    function ChangeBonus(uint _bonus) {
        require(msg.sender == beneficiary);
        bonus = _bonus;
    }
}