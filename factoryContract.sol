// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Car{
    string public name;
    constructor(string memory _name){
        name = _name;
    }
}

contract CarFactory{
    Car[] cars;
    function create(string calldata _name) public{
        Car car = new Car(_name);
        cars.push(car);
    }

    function getCar(uint256 index) public view returns(string memory name_){
        name_ = cars[index].name();
    }

    function create2(string calldata _name,bytes32 _salt) public{
        Car car = (new Car){salt:_salt}(_name);
        cars.push(car);
    }

}
