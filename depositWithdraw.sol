// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.1;

contract depositWithdraw {
    mapping (address => uint) balance;
    
    function getThisBalance() public view returns(uint _balance) {
        _balance = balance[msg.sender];
    }
    
    function deposit() public payable {
        balance[msg.sender] += msg.value;
    }
    
    receive() external payable {
    }
    
    fallback() external payable {
        deposit();
    }
    
    function withdraw(uint withdrawAmount) public payable {
        uint amount = withdrawAmount;
        require (balance[msg.sender] >= withdrawAmount);
        (bool success,) = msg.sender.call{value: amount}("");
        require(success, "Failed to send Ether");
        balance[msg.sender] -= amount;
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
}
