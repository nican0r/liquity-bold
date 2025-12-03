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

    function stabilityPool_offset(uint256 _debtToOffset, uint256 _collToAdd) public asActor {
        stabilityPool.offset(_debtToOffset, _collToAdd);
    }

    function stabilityPool_provideToSP(uint256 _topUp, bool _doClaim) public asActor {
        stabilityPool.provideToSP(_topUp, _doClaim);
    }

    function stabilityPool_triggerBoldRewards(uint256 _boldYield) public asActor {
        stabilityPool.triggerBoldRewards(_boldYield);
    }

    function stabilityPool_withdrawFromSP(uint256 _amount, bool _doClaim) public asActor {
        stabilityPool.withdrawFromSP(_amount, _doClaim);
    }
}