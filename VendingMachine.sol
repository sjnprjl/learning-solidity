// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract VendingMachine {
    address public owner;
    mapping (address => uint) public donutBalances;

    constructor() payable {
        owner = msg.sender;
        donutBalances[address(this)] = 100;
    }

    function getVendingMachineBalances() public view returns (uint) {
        return donutBalances[address(this)];
    }
    // amount in ether
    function purchase(uint amount) public payable {
        require(msg.value >= amount * 2 ether, "You need to have at least of 2 ether to purchase a donut");
        require(getVendingMachineBalances() >= amount, "Not enough balances to fulfill this purchase");
        donutBalances[address(this)] -= amount;
        donutBalances[msg.sender] += amount;
    } 

    function restock(uint amount) public {
        require(msg.sender == owner, "Only owner can restock donuts.");
        donutBalances[address(this)] += amount;
    }
}
