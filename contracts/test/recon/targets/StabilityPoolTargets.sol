// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

import "src/StabilityPool.sol";

abstract contract StabilityPoolTargets is
    BaseTargetFunctions,
    Properties
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///


    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function stabilityPool_claimAllCollGains() public asActor {
        stabilityPool.claimAllCollGains();
    }

    function stabilityPool_provideToSP(uint256 _topUp, bool _doClaim) public asActor {
        stabilityPool.provideToSP(_topUp, _doClaim);
    }

    function stabilityPool_withdrawFromSP(uint256 _amount, bool _doClaim) public asActor {
        stabilityPool.withdrawFromSP(_amount, _doClaim);
    }
}