// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

library math{
    //library has not state vars!
    function add(uint256 _a,uint256 _b) public pure returns(uint256){
        return _a + _b;
    }
}

contract MyMath{
    function test(uint256 a,uint256 b) public pure returns(uint256){
        return math.add(a,b);
    }
}
