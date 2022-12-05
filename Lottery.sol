// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Lottery {
    address public owner;
    address payable[] public players;

    constructor() {
        owner = msg.sender;
    }



    function checkOverlappingAddress() public view returns (bool) {
            for (uint i = 0; i < players.length; i++) {
                if(msg.sender == players[i]) return true;
            }
            return false;
    }

    function addPlayer() public payable {
        require(checkOverlappingAddress() == false, "Player is already registered to the lottery contest");
        require(msg.value > .01 ether, "Not sufficent ether to get into lottery contest");
        players.push(payable(msg.sender));
    }



    function getRandomNumber() public view  returns (uint) {
            return uint(keccak256(abi.encodePacked(owner, block.timestamp)));
    }

    function getWinner() public payable returns (address) {
        require(owner == msg.sender, "Only admin can check for winner");
        uint winnerIndex = getRandomNumber() % players.length;

        address payable winnerAddress = players[winnerIndex];
        winnerAddress.transfer(address(this).balance);

        return winnerAddress;
    }
}
