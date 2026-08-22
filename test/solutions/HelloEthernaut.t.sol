// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {HelloEthernaut} from "../../src/solutions/HelloEthernaut.sol";
import {InstanceFactory} from "ethernaut/contracts/src/levels/InstanceFactory.sol";
import {Instance} from "ethernaut/contracts/src/levels/Instance.sol";

contract HelloEthernautTest is Test {
    address public immutable player = makeAddr("player");
    InstanceFactory public factory;
    Instance public level;
    HelloEthernaut public exploit;

    function setUp() public {
        factory = new InstanceFactory();
        level = Instance(factory.createInstance(player));
        exploit = new HelloEthernaut(address(level));
    }

    function test_exploit_HelloEthernaut() public {
        assert(!level.getCleared());
        exploit.exploit();
        assert(factory.validateInstance(payable(address(level)), player));
    }
}
