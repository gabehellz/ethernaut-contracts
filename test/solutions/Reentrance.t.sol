// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import {DSTest} from "ds-test/test.sol";
import {Reentrance} from "ethernaut/contracts/src/levels/Reentrance.sol";
import {ReentranceFactory} from "ethernaut/contracts/src/levels/ReentranceFactory.sol";
import {ReentranceExploit} from "../../src/solutions/ReentranceExploit.sol";

interface Vm {
    function startPrank(address msgSender) external;
    function stopPrank() external;
}

contract ReentranceTest is DSTest {
    address internal constant VM_ADDRESS = 0x7109709ECfa91a80626fF3989D68f67F5b1DD12D;
    Vm internal constant vm = Vm(VM_ADDRESS);

    address public immutable player = address(0xdead);
    ReentranceFactory public factory;
    Reentrance public level;
    ReentranceExploit public exploit;

    function setUp() public {
        factory = new ReentranceFactory();
        level = Reentrance(payable(factory.createInstance{value: 0.001 ether}(player)));
        exploit = new ReentranceExploit(level);
    }

    function test_exploit_Reentrance() public {
        assertEq(address(level).balance, 0.001 ether);
        uint256 amount = 0.0001 ether;
        level.donate{value: amount}(address(exploit));
        exploit.exploit(amount);
        assert(factory.validateInstance(payable(address(level)), player));
    }
}
