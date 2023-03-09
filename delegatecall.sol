// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// NOTE: Deploy this contract first
contract B {
    // NOTE: storage layout must be the same as contract A
    uint public num;
    address public sender;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
    }
}

contract A {
    uint public num;
    address public sender;

    function setVarsDelegatecall(address _contract, uint _num) public payable {
        // A's storage is set, B is not modified.
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );

        require( success && data.length == 0);
    }

    function setVarsCall(address _contract, uint _num) public payable {
        //B's storage is set, A is not modified.
        (bool success, bytes memory data) = _contract.call(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );

        require( success && data.length == 0);
    }
}
/* A使用委托调用，改变的是自己的状态，B不受影响
    使用普通调用，改变了B的状态，自身不受影响
*/
