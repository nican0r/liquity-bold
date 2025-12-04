// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

import "src/CollSurplusPool.sol";

abstract contract CollSurplusPoolTargets is
    BaseTargetFunctions,
    Properties
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    // Clamped handler for claimColl with current actor
    function collSurplusPool_claimColl_clamped_self() public asActor {
        address _account = _getActor();
        collSurplusPool.claimColl(_account);
    }

    // Clamped handler for claimColl with first actor
    function collSurplusPool_claimColl_clamped_actor0() public asActor {
        address _account = _getActors()[0];
        collSurplusPool.claimColl(_account);
    }


    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function collSurplusPool_claimColl(address _account) public asActor {
        collSurplusPool.claimColl(_account);
    }
}