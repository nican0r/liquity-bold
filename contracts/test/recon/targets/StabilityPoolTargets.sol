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

    // Clamped handler for provideToSP with max BOLD balance
    function stabilityPool_provideToSP_clamped_max(bool _doClaim) public asActor {
        stabilityPool.provideToSP(boldToken.balanceOf(_getActor()), _doClaim);
    }

    // Clamped handler for provideToSP with 1000 BOLD
    function stabilityPool_provideToSP_clamped_1000(bool _doClaim) public asActor {
        stabilityPool.provideToSP(1000e18, _doClaim);
    }

    // Clamped handler for provideToSP with 10000 BOLD
    function stabilityPool_provideToSP_clamped_10000(bool _doClaim) public asActor {
        stabilityPool.provideToSP(10000e18, _doClaim);
    }

    // Clamped handler for withdrawFromSP with max compounded deposit
    function stabilityPool_withdrawFromSP_clamped_max(bool _doClaim) public asActor {
        stabilityPool.withdrawFromSP(stabilityPool.getCompoundedBoldDeposit(_getActor()), _doClaim);
    }

    // Clamped handler for withdrawFromSP with 1000 BOLD
    function stabilityPool_withdrawFromSP_clamped_1000(bool _doClaim) public asActor {
        stabilityPool.withdrawFromSP(1000e18, _doClaim);
    }


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