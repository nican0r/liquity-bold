// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

import "src/CollateralRegistry.sol";

abstract contract CollateralRegistryTargets is
    BaseTargetFunctions,
    Properties
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    // Clamped handler for redeemCollateral with max BOLD amount
    function collateralRegistry_redeemCollateral_clamped_max() public asActor {
        collateralRegistry.redeemCollateral(boldToken.balanceOf(_getActor()), 5, 5e16);
    }

    // Clamped handler for redeemCollateral with 1000 BOLD
    function collateralRegistry_redeemCollateral_clamped_1000() public asActor {
        collateralRegistry.redeemCollateral(1000e18, 10, 1e17);
    }

    // Clamped handler for redeemCollateral with high iterations
    function collateralRegistry_redeemCollateral_clamped_highIter() public asActor {
        collateralRegistry.redeemCollateral(boldToken.balanceOf(_getActor()), 50, 1e18);
    }


    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function collateralRegistry_redeemCollateral(uint256 _boldAmount, uint256 _maxIterationsPerCollateral, uint256 _maxFeePercentage) public asActor {
        collateralRegistry.redeemCollateral(_boldAmount, _maxIterationsPerCollateral, _maxFeePercentage);
    }
}