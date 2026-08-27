// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.36;

import {Test} from "forge-std/Test.sol";
import {Telephone} from "ethernaut/contracts/src/levels/Telephone.sol";
import {TelephoneFactory} from "ethernaut/contracts/src/levels/TelephoneFactory.sol";
import {TelephoneExploit} from "../../src/solutions/TelephoneExploit.sol";

contract TelephoneTest is Test {
    address public immutable player = makeAddr("player");
    TelephoneFactory public factory;
    Telephone public level;
    TelephoneExploit public exploit;

    function setUp() public {
        factory = new TelephoneFactory();
        level = Telephone(factory.createInstance(player));
        exploit = new TelephoneExploit();
    }

    function test_exploit_Telephone() public {
        assertNotEq(level.owner(), player);
        vm.startPrank(player);
        exploit.exploit(level);
        vm.stopPrank();
        assert(factory.validateInstance(payable(address(level)), player));
    }
}
