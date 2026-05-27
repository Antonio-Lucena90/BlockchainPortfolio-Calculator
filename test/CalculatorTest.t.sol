// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

import "forge-std/Test.sol";
import "../src/Calculator.sol";

contract CalculatorTest is Test {
    Calculator calculator; //define el objeto Calculadora, para despues poder usarlo en las fx de testing.
    uint256 public firstResult = 100;
    address public admin = vm.addr(1);
    address public randomUser = vm.addr(2);

    function setUp() public {
        //antes de cada test se ejecuta lo que haya dentro de SetUp
        calculator = new Calculator(firstResult, admin);
    }

    //Unit Testing--> test único con parametros específicos.

    function testCheckFirstResult() public view {
        uint256 firstResult_ = calculator.result();
        assert(firstResult_ == firstResult); //comprueba que lo que tenemos entre parentesis sea verdad.
    }

    function testAddition() public {
        uint256 a_ = 10;
        uint256 b_ = 20;
        uint256 result_ = calculator.addition(a_, b_);
        assert(result_ == a_ + b_);
    }

    function testsubstraction() public {
        uint256 a_ = 20;
        uint256 b_ = 5;
        uint256 result_ = calculator.substraction(a_, b_);
        assert(result_ == a_ - b_);
    }

    function testMultiplier() public {
        uint256 a_ = 3;
        uint256 b_ = 8;
        uint256 result_ = calculator.multiplier(a_, b_);
        assert(result_ == a_ * b_);
    }

    function testCanNotMultiplier2LargeNumbers() public {
        uint256 a_ = 3;
        uint256 b_ = 115792089237316195423570985008687907853269984665640564039457584007913129639934;
        vm.expectRevert();
        calculator.multiplier(a_, b_);
    }

    function testAdminAdmisionRevert() public {
        vm.startPrank(randomUser);
        uint256 a_ = 3;
        uint256 b_ = 1;
        vm.expectRevert();
        calculator.division(a_, b_);
        vm.stopPrank();
    }

    function testDivision() public {
        vm.startPrank(admin);
        uint256 a_ = 3;
        uint256 b_ = 1;

        calculator.division(a_, b_);
        vm.stopPrank();
    }

    function testDivision2() public {
        vm.startPrank(admin);
        uint256 a_ = 3;
        uint256 b_ = 1;
        uint256 result_ = calculator.division(a_, b_);
        assert(result_ == a_ / b_);
        vm.stopPrank();
    }

    function testDivisionRevert() public {
        uint256 a_ = 3;
        uint256 b_ = 1;
        vm.expectRevert();
        calculator.division(a_, b_);
    }

    function testDivisionRevert0() public {
        vm.startPrank(admin);
        uint256 a_ = 3;
        uint256 b_ = 0;
        vm.expectRevert();
        calculator.division(a_, b_);
        vm.stopPrank();
    }
    //unitTesting ---> given inputs.
    //Fuzzing Testing--> foundry se encarga de hacer llamadas con parametros aleatorios.

    function testFuzzingDivision(uint256 a_, uint256 b_) public {
        vm.assume(b_ != 0);
        vm.startPrank(admin);

        calculator.division(a_, b_);

        vm.stopPrank();
    }
}
