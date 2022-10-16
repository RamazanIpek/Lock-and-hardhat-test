// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./Token.sol";

contract Lock  {
    MyToken token;

    uint256 public lockerCount;
    uint256 public totalLocked;
    mapping(address=> uint256) public lockers;

    constructor (address tokenAddress){
        token = MyToken(tokenAddress);
    }

    function lockTokens(uint256 amount) balanceFailed(amount) balanceControll(amount) external {

        if(!(lockers[msg.sender] > 0)) lockerCount++;
        totalLocked += amount;
        lockers[msg.sender] += amount;

        bool ok = token.transferFrom(msg.sender, address(this), amount);

        require(ok, "Transfer Failed");
    }

    function withdrawTokens() external {
        require(lockers[msg.sender]>0, "Not enough token");

        uint256 amount = lockers[msg.sender];
        delete(lockers[msg.sender]);
        totalLocked -= amount;
        lockerCount --;


        bool ok = token.transfer(msg.sender, amount);
        require(ok, "Transfer Failed");

    }

    modifier balanceFailed(uint256 amount) {
        require(amount > 0, "Token balances must be bigger than zero.");
        _;
    }

    modifier balanceControll(uint256 amount) {
        require(token.balanceOf(msg.sender)>=amount, "Insufficent balance");
        _;
    }

}