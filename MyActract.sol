// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

abstract contract Counter{
    uint256 public count;
    //function count() view external virtual returns(uint256);
    function incr() external virtual;
}

contract MyCounter is Counter{
    //uint256 public count;

    constructor()
        Counter()
        {}

    function incr() external override{
        count++;
    }

}

contract MyAbstract{
    MyCounter public mc;
    function SetMyCounterAddress(address _addr) public{
        mc = MyCounter(_addr);
    }

    function IncrAndReturn() public {
        mc.incr();
    }

    function GetCount() public view returns(uint256){
        return mc.count();
    }
}
