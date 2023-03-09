// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

interface Icounter{
    function count() view external returns(uint256);
    function incr() external;
}

contract Counter{
    uint256 public count;

    function incr() external{
        count++;
    }
}

contract MyInterface{
    function MyGetCount(address _addr) external view returns(uint256){
        return Icounter(_addr).count();
    }

    function MyIncr(address _addr) external{
        Icounter(_addr).incr();
    }
}

/*演示接口合约的使用*/
