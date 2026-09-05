// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.36;

import {Test, console} from "forge-std/Test.sol";
import {GatekeeperOne} from "ethernaut/contracts/src/levels/GatekeeperOne.sol";
import {GatekeeperOneFactory} from "ethernaut/contracts/src/levels/GatekeeperOneFactory.sol";
import {GatekeeperOneExploit} from "../../src/solutions/GatekeeperOneExploit.sol";

contract GatekeeperOneTest is Test {
    address public immutable player = makeAddr("player");
    GatekeeperOneFactory public factory;
    GatekeeperOne public level;
    GatekeeperOneExploit public exploit;

    function setUp() public {
        factory = new GatekeeperOneFactory();
        level = GatekeeperOne(factory.createInstance(player));
        exploit = new GatekeeperOneExploit();
    }

    function test_exploit_GatekeeperOne() public {
        assertNotEq(level.entrant(), player);
        vm.startPrank(player, player);
        assert(exploit.exploit(level));
        vm.stopPrank();
        assert(factory.validateInstance(payable(address(level)), player));
    }
}
