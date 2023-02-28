// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Mywallet{
    address payable owner;
    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner(address _addr) {
        require(_addr == owner,"only owner");
        _;
    }

    receive() payable external{}

    function withdraw(uint256 amount)  external onlyOwner(msg.sender){
        payable(this).transfer(amount);    
    }

    function balance() public view returns(uint256){
        return this.balance();
    }
}
