//SPDX-License-Identifier: GPL-3.0
 
pragma solidity >=0.5.0 <0.9.0;

contract Lottery {
    // Payable if may need to send Ether to address. If don't need to send Ether, then no need to use payable.
    address payable[] public players;
    address public manager;

    // only called once (constructor) so it will be the owner
    constructor () {
        manager = msg.sender;
    }

    receive() external payable {
        require(msg.sender != manager);
        require(msg.value == 0.1 ether, "You can only sent 0.1 Ether");
        players.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint) {
        require(msg.sender == manager, "You are not allowed to view the balance.");
        return address(this).balance;
    }

    function random() public view returns(uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    }

    function pickWinner() public {
        require(msg.sender == manager);
        require(players.length >= 3);

        uint r = random();
        address payable winner;

        uint index = r % players.length;
        winner = players[index];

        uint managerFee = (getBalance() * 10 ) / 100; // manager fee is 10%
        uint winnerPrize = (getBalance() * 90 ) / 100;     // winner prize is 90%

        winner.transfer(winnerPrize);
        payable(manager).transfer(managerFee);

        winner.transfer(getBalance());
        players = new address payable[](0); // resetting the Lottery
    }
}