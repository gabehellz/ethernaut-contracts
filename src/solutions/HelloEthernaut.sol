// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Instance} from "ethernaut/contracts/src/levels/Instance.sol";

contract HelloEthernaut {
    Instance public immutable level;

    constructor(address level_) {
        level = Instance(level_);
    }

    function exploit() public {
        string memory password = level.password();
        level.authenticate(password);
    }
}
