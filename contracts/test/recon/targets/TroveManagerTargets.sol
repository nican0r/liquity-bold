// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

import "src/TroveManager.sol";

abstract contract TroveManagerTargets is
    BaseTargetFunctions,
    Properties
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    // Clamped handler for batchLiquidateTroves with empty array
    function troveManager_batchLiquidateTroves_clamped_empty() public asActor {
        troveManager.batchLiquidateTroves(new uint256[](0));
    }

    // Clamped handler for urgentRedemption with max BOLD
    function troveManager_urgentRedemption_clamped_max() public asActor {
        troveManager.urgentRedemption(boldToken.balanceOf(_getActor()), new uint256[](0), 1e18);
    }

    // Clamped handler for urgentRedemption with 1000 BOLD
    function troveManager_urgentRedemption_clamped_1000() public asActor {
        troveManager.urgentRedemption(1000e18, new uint256[](0), 5e18);
    }


    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function troveManager_batchLiquidateTroves(uint256[] memory _troveArray) public asActor {
        troveManager.batchLiquidateTroves(_troveArray);
    }

    function troveManager_getUnbackedPortionPriceAndRedeemability() public asActor {
        troveManager.getUnbackedPortionPriceAndRedeemability();
    }

    function troveManager_urgentRedemption(uint256 _boldAmount, uint256[] memory _troveIds, uint256 _minCollateral) public asActor {
        troveManager.urgentRedemption(_boldAmount, _troveIds, _minCollateral);
    }
}