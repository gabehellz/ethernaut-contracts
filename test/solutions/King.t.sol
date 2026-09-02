// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.36;

import {Test} from "forge-std/Test.sol";
import {King} from "ethernaut/contracts/src/levels/King.sol";
import {KingFactory} from "ethernaut/contracts/src/levels/KingFactory.sol";
import {KingExploit} from "../../src/solutions/KingExploit.sol";

contract KingTest is Test {
    address public immutable player = makeAddr("player");
    KingFactory public factory;
    King public level;
    KingExploit public exploit;

    function setUp() public {
        factory = new KingFactory();
        level = King(payable(factory.createInstance{value: 0.001 ether}(player)));
        exploit = new KingExploit();
    }

    function test_exploit_King() public {
        assertEq(level._king(), level.owner());
        exploit.exploit{value: level.prize()}(address(level));
        assert(factory.validateInstance(payable(address(level)), player));
    }
}
