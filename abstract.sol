//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

abstract contract Sort{
    function sort(uint[] memory a) public pure virtual returns(uint[] memory);
}

contract SelectSort is Sort{
    function sort(uint[] memory a) public pure override returns(uint[] memory){
        uint256 len = a.length;
        for(uint256 i = 0;i<len;i++){
            for(uint256 j = i+1;j<len;j++){
                if(a[i]>a[j]){
                    uint t = a[i];
                    a[i] = a[j];
                    a[j] = t;
                }
            }
        }
        return a;
    }

}

contract MySort{
    SelectSort public ss;

    function SetAddress(address _addr) public {
        ss = SelectSort(_addr);
    }

    function test() public view returns(uint[] memory){
        //uint[10] memory arr = [uint(7),3,6,8,1,9,2,5,4,10];
        uint[] memory arr = new uint[](10);
        arr[0] = 7;
        arr[1] = 3;
        arr[2] = 6;
        arr[3] = 8;
        arr[4] = 1;
        arr[5] = 9;
        arr[6] = 2;
        arr[7] = 5;
        arr[8] = 4;
        arr[9] = 10;

        arr = ss.sort(arr);
        return arr;
    }

}

/*排序算法演示抽象合约的继承和使用*/
