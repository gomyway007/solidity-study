//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Grandfather{

    function say() public virtual returns( string memory){
        return("I am grandfather");
    }

    function walk() public virtual returns( string memory){
        return ("I can walk");
    }
}

contract Father is Grandfather{

    function say() public virtual override returns( string memory){
        return ("I am father");
    }

    function run() public virtual returns( string memory){
        return ("I can run");
    }
}

/*
Father继承了Gf， 有三个方法，say重写了Grandfather的say方法，run是自己的方法，walk是从Gf继承而来。
*/
