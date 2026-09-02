// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.36;

import {Test} from "forge-std/Test.sol";
import {Elevator} from "ethernaut/contracts/src/levels/Elevator.sol";
import {ElevatorFactory} from "ethernaut/contracts/src/levels/ElevatorFactory.sol";
import {ElevatorExploit} from "../../src/solutions/ElevatorExploit.sol";

contract ElevatorTest is Test {
    address public immutable player = makeAddr("player");
    ElevatorFactory public factory;
    Elevator public level;
    ElevatorExploit public exploit;

    function setUp() public {
        factory = new ElevatorFactory();
        level = Elevator(factory.createInstance(player));
        exploit = new ElevatorExploit();
    }

    function test_exploit_Elevator() public {
        assert(!level.top());
        exploit.exploit(level);
        assert(factory.validateInstance(payable(address(level)), player));
    }
}
