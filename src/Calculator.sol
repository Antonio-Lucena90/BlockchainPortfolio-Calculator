// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

contract Calculator {
    //Variables
    uint256 public result;
    address public admin;

    //Events
    event Addition(uint256 a_, uint256 b_, uint256 result_);
    event Substraction(uint256 a_, uint256 b_, uint256 result_);
    event Multiplier(uint256 a_, uint256 b_, uint256 result_);
    event Division(uint256 a_, uint256 b_, uint256 result_);

    //Modifiers
    modifier onlyAdmin() {
        require(msg.sender == admin, "Not allowed");
        _;
    }

    constructor(uint256 firstResult_, address admin_) {
        result = firstResult_;
        admin = admin_;
    }

    // Functions

    // 1. addition

    function addition(uint256 a_, uint256 b_) external returns (uint256 result_) {
        result_ = a_ + b_;
        result = result_;
        emit Addition(a_, b_, result_);
    }

    // 2. Substraction

    function substraction(uint256 a_, uint256 b_) external returns (uint256 result_) {
        result_ = a_ - b_;
        result = result_;
        emit Substraction(a_, b_, result_);
    }

    // 3. Multiplier
    function multiplier(uint256 a_, uint256 b_) external returns (uint256 result_) {
        result_ = a_ * b_;
        result = result_;
        emit Multiplier(a_, b_, result_);
    }

    //4. Division

    function division(uint256 a_, uint256 b_) external onlyAdmin returns (uint256 result_) {
        require(b_ != 0, "Cannot divide by zero");
        result_ = a_ / b_;
        result = result_;
        emit Division(a_, b_, result_);
    }
}
