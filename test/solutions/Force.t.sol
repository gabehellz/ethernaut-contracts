// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.36;

import {Test} from "forge-std/Test.sol";
import {Force} from "ethernaut/contracts/src/levels/Force.sol";
import {ForceFactory} from "ethernaut/contracts/src/levels/ForceFactory.sol";
import {ForceExploit} from "../../src/solutions/ForceExploit.sol";

contract ForceTest is Test {
    address public immutable player = makeAddr("player");
    ForceFactory public factory;
    Force public level;
    ForceExploit public exploit;

    function setUp() public {
        factory = new ForceFactory();
        level = Force(factory.createInstance(player));
        exploit = new ForceExploit();
    }

    function test_exploit_Force() public {
        address levelAddress = address(level);
        assertEq(levelAddress.balance, 0);
        exploit.exploit{value: 1 ether}(levelAddress);
        assert(factory.validateInstance(payable(levelAddress), player));
    }
}
