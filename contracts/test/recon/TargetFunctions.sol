// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

// Targets
// NOTE: Always import and apply them in alphabetical order, so much easier to debug!
import { ActivePoolTargets } from "./targets/ActivePoolTargets.sol";
import { AdminTargets } from "./targets/AdminTargets.sol";
import { BoldTokenTargets } from "./targets/BoldTokenTargets.sol";
import { BorrowerOperationsTargets } from "./targets/BorrowerOperationsTargets.sol";
import { CollSurplusPoolTargets } from "./targets/CollSurplusPoolTargets.sol";
import { CollateralRegistryTargets } from "./targets/CollateralRegistryTargets.sol";
import { DefaultPoolTargets } from "./targets/DefaultPoolTargets.sol";
import { DoomsdayTargets } from "./targets/DoomsdayTargets.sol";
import { ManagersTargets } from "./targets/ManagersTargets.sol";
import { SortedTrovesTargets } from "./targets/SortedTrovesTargets.sol";
import { StabilityPoolTargets } from "./targets/StabilityPoolTargets.sol";
import { TroveManagerTargets } from "./targets/TroveManagerTargets.sol";
import { TroveNFTTargets } from "./targets/TroveNFTTargets.sol";

abstract contract TargetFunctions is
    ActivePoolTargets,
    AdminTargets,
    BoldTokenTargets,
    BorrowerOperationsTargets,
    CollSurplusPoolTargets,
    CollateralRegistryTargets,
    DefaultPoolTargets,
    DoomsdayTargets,
    ManagersTargets,
    SortedTrovesTargets,
    StabilityPoolTargets,
    TroveManagerTargets,
    TroveNFTTargets
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    // Shortcut for batch liquidation - requires SP deposits and underwater troves
    function shortcut_batchLiquidateTroves(uint256 _ownerIndex1, uint256 _ownerIndex2, uint256 _upperHint, uint256 _lowerHint) public {
        // Actor 0: Create stability pool deposit to absorb liquidation
        switchActor(0);
        stabilityPool_provideToSP_clamped_10000(false);
        
        // Actor 1: Open first trove that will be liquidated
        switchActor(1);
        borrowerOperations_openTrove_clamped_2000(_ownerIndex1, _upperHint, _lowerHint);
        
        // Actor 2: Open second trove that will be liquidated  
        switchActor(2);
        borrowerOperations_openTrove_clamped_2000(_ownerIndex2, _upperHint, _lowerHint);
        
        // Attempt batch liquidation with empty array (will search for liquidatable troves)
        switchActor(0);
        troveManager_batchLiquidateTroves_clamped_empty();
    }

    // Shortcut for redemption - requires BOLD balance and open troves
    function shortcut_redeemCollateral(uint256 _ownerIndex1, uint256 _ownerIndex2, uint256 _upperHint, uint256 _lowerHint) public {
        // Actor 1: Open first trove to provide redemption targets
        switchActor(1);
        borrowerOperations_openTrove_clamped_2000(_ownerIndex1, _upperHint, _lowerHint);
        
        // Actor 2: Open second trove to provide more redemption targets
        switchActor(2);
        borrowerOperations_openTrove_clamped_5000(_ownerIndex2, _upperHint, _lowerHint);
        
        // Actor 0: Attempt redemption with available BOLD
        switchActor(0);
        collateralRegistry_redeemCollateral_clamped_1000();
    }

    // Shortcut for urgent redemption - requires BOLD and shutdown conditions
    function shortcut_urgentRedemption(uint256 _ownerIndex1, uint256 _ownerIndex2, uint256 _upperHint, uint256 _lowerHint) public {
        // Actor 1: Open trove for redemption target
        switchActor(1);
        borrowerOperations_openTrove_clamped_2000(_ownerIndex1, _upperHint, _lowerHint);
        
        // Actor 2: Open another trove
        switchActor(2);
        borrowerOperations_openTrove_clamped_5000(_ownerIndex2, _upperHint, _lowerHint);
        
        // Actor 0: Provide to SP (helps create conditions for urgent redemption)
        switchActor(0);
        stabilityPool_provideToSP_clamped_10000(false);
        
        // Attempt urgent redemption
        troveManager_urgentRedemption_clamped_1000();
    }

    // Shortcut for batch manager operations - register and add troves to batch
    function shortcut_setInterestBatchManager(uint256 _ownerIndex, uint256 _troveId, uint256 _upperHint, uint256 _lowerHint) public {
        // Actor 0: Register as batch manager
        switchActor(0);
        borrowerOperations_registerBatchManager_clamped_conservative();
        
        // Actor 1: Open a trove
        switchActor(1);
        borrowerOperations_openTrove_clamped_2000(_ownerIndex, _upperHint, _lowerHint);
        
        // Actor 1: Set batch manager for the trove
        borrowerOperations_setInterestBatchManager_clamped(_troveId, _upperHint, _lowerHint);
    }

    // Shortcut for switching batch managers - requires two batch managers and a trove
    function shortcut_switchBatchManager(uint256 _ownerIndex, uint256 _troveId, uint256 _removeUpperHint, uint256 _removeLowerHint, uint256 _addUpperHint, uint256 _addLowerHint) public {
        // Actor 0: Register first batch manager
        switchActor(0);
        borrowerOperations_registerBatchManager_clamped_conservative();
        
        // Actor 2: Register second batch manager
        switchActor(2);
        borrowerOperations_registerBatchManager_clamped_aggressive();
        
        // Actor 1: Open trove and set to first batch manager
        switchActor(1);
        borrowerOperations_openTrove_clamped_2000(_ownerIndex, _addUpperHint, _addLowerHint);
        borrowerOperations_setInterestBatchManager_clamped(_troveId, _addUpperHint, _addLowerHint);
        
        // Actor 1: Switch to second batch manager
        borrowerOperations_switchBatchManager_clamped(_troveId, _removeUpperHint, _removeLowerHint, _addUpperHint, _addLowerHint);
    }

    // Shortcut for individual delegate operations - set up and use individual interest rate delegation
    function shortcut_setInterestIndividualDelegate(uint256 _ownerIndex, uint256 _troveId, uint256 _upperHint, uint256 _lowerHint) public {
        // Actor 1: Open a trove first
        switchActor(1);
        borrowerOperations_openTrove_clamped_2000(_ownerIndex, _upperHint, _lowerHint);
        
        // Actor 1: Set individual delegate
        borrowerOperations_setInterestIndividualDelegate_clamped(_troveId, _upperHint, _lowerHint);
        
        // Actor 1: Adjust interest rate using delegate
        borrowerOperations_adjustTroveInterestRate_clamped_1pct(_troveId, _upperHint, _lowerHint);
    }

    // Shortcut for complex trove adjustments after batch management
    function shortcut_adjustTroveInBatch(uint256 _ownerIndex, uint256 _troveId, uint256 _upperHint, uint256 _lowerHint) public {
        // Actor 0: Register as batch manager
        switchActor(0);
        borrowerOperations_registerBatchManager_clamped_conservative();
        
        // Actor 1: Open trove and join batch
        switchActor(1);
        borrowerOperations_openTrove_clamped_2000(_ownerIndex, _upperHint, _lowerHint);
        borrowerOperations_setInterestBatchManager_clamped(_troveId, _upperHint, _lowerHint);
        
        // Actor 1: Adjust trove collateral and debt
        borrowerOperations_adjustTrove_clamped_collIncrease(_troveId);
    }

    // Shortcut for stability pool deposit with subsequent withdrawal - tests rewards accumulation
    function shortcut_withdrawFromSPWithGains(uint256 _ownerIndex, uint256 _upperHint, uint256 _lowerHint) public {
        // Actor 0: Provide to stability pool
        switchActor(0);
        stabilityPool_provideToSP_clamped_10000(false);
        
        // Actor 1: Open trove that might get liquidated
        switchActor(1);
        borrowerOperations_openTrove_clamped_2000(_ownerIndex, _upperHint, _lowerHint);
        
        // Try to liquidate to generate gains
        switchActor(2);
        troveManager_batchLiquidateTroves_clamped_empty();
        
        // Actor 0: Withdraw from SP with claims
        switchActor(0);
        stabilityPool_withdrawFromSP_clamped_max(true);
    }

    // Shortcut for collateral surplus claim after liquidation
    function shortcut_claimCollSurplus(uint256 _ownerIndex, uint256 _upperHint, uint256 _lowerHint) public {
        // Actor 0: Provide to stability pool for liquidation
        switchActor(0);
        stabilityPool_provideToSP_clamped_10000(false);
        
        // Actor 1: Open trove
        switchActor(1);
        borrowerOperations_openTrove_clamped_2000(_ownerIndex, _upperHint, _lowerHint);
        
        // Attempt liquidation
        switchActor(2);
        troveManager_batchLiquidateTroves_clamped_empty();
        
        // Actor 1: Claim any surplus
        switchActor(1);
        collSurplusPool_claimColl_clamped_self();
    }

    // Shortcut for removing trove from batch and adjusting interest rate
    function shortcut_removeFromBatch(uint256 _ownerIndex, uint256 _troveId, uint256 _upperHint, uint256 _lowerHint) public {
        // Actor 0: Register as batch manager
        switchActor(0);
        borrowerOperations_registerBatchManager_clamped_conservative();
        
        // Actor 1: Open trove and join batch
        switchActor(1);
        borrowerOperations_openTrove_clamped_2000(_ownerIndex, _upperHint, _lowerHint);
        borrowerOperations_setInterestBatchManager_clamped(_troveId, _upperHint, _lowerHint);
        
        // Actor 1: Remove from batch
        borrowerOperations_removeFromBatch_clamped(_troveId, _upperHint, _lowerHint);
    }

    // Shortcut for batch manager fee adjustments with active troves
    function shortcut_setBatchManagerInterestRate(uint256 _ownerIndex1, uint256 _ownerIndex2, uint256 _upperHint, uint256 _lowerHint) public {
        // Actor 0: Register as batch manager
        switchActor(0);
        borrowerOperations_registerBatchManager_clamped_conservative();
        
        // Actor 1: Open trove and join batch
        switchActor(1);
        borrowerOperations_openTrove_clamped_2000(_ownerIndex1, _upperHint, _lowerHint);
        borrowerOperations_setInterestBatchManager_clamped(0, _upperHint, _lowerHint);
        
        // Actor 2: Open another trove and join batch
        switchActor(2);
        borrowerOperations_openTrove_clamped_5000(_ownerIndex2, _upperHint, _lowerHint);
        borrowerOperations_setInterestBatchManager_clamped(1, _upperHint, _lowerHint);
        
        // Actor 0: Adjust batch interest rate
        switchActor(0);
        borrowerOperations_setBatchManagerAnnualInterestRate_clamped_med(_upperHint, _lowerHint);
    }

    // Shortcut for complex redemption with multiple troves
    function shortcut_redeemMultipleTroves(uint256 _ownerIndex1, uint256 _ownerIndex2, uint256 _upperHint, uint256 _lowerHint) public {
        // Open multiple troves with different actors
        switchActor(1);
        borrowerOperations_openTrove_clamped_2000(_ownerIndex1, _upperHint, _lowerHint);
        
        switchActor(2);
        borrowerOperations_openTrove_clamped_5000(_ownerIndex2, _upperHint, _lowerHint);
        
        // Ensure Actor 0 has BOLD for redemption
        switchActor(1);
        boldToken_transfer_clamped_max(1000e18);
        
        // Perform redemption with high iterations
        switchActor(0);
        collateralRegistry_redeemCollateral_clamped_highIter();
    }

    // Shortcut for zombie trove adjustment - requires specific conditions
    function shortcut_adjustZombieTrove(uint256 _ownerIndex1, uint256 _ownerIndex2, uint256 _troveId, uint256 _upperHint, uint256 _lowerHint) public {
        // Actor 0: Provide to stability pool
        switchActor(0);
        stabilityPool_provideToSP_clamped_10000(false);
        
        // Actor 1: Open trove that may become zombie
        switchActor(1);
        borrowerOperations_openTrove_clamped_2000(_ownerIndex1, _upperHint, _lowerHint);
        
        // Actor 2: Open another trove
        switchActor(2);
        borrowerOperations_openTrove_clamped_5000(_ownerIndex2, _upperHint, _lowerHint);
        
        // Attempt liquidation to create zombie trove
        troveManager_batchLiquidateTroves_clamped_empty();
        
        // Actor 1: Try to adjust zombie trove
        switchActor(1);
        borrowerOperations_adjustZombieTrove_clamped(_troveId, _upperHint, _lowerHint);
    }

    // Shortcut for withdrawing and repaying BOLD in sequence
    function shortcut_withdrawAndRepayBold(uint256 _ownerIndex, uint256 _troveId, uint256 _upperHint, uint256 _lowerHint) public {
        // Actor 1: Open trove
        switchActor(1);
        borrowerOperations_openTrove_clamped_5000(_ownerIndex, _upperHint, _lowerHint);
        
        // Actor 1: Withdraw BOLD
        borrowerOperations_withdrawBold_clamped_2000(_troveId);
        
        // Actor 1: Repay some BOLD back
        borrowerOperations_repayBold_clamped_1000(_troveId);
    }

    // Shortcut for multiple collateral operations on same trove
    function shortcut_addAndWithdrawColl(uint256 _ownerIndex, uint256 _troveId, uint256 _upperHint, uint256 _lowerHint) public {
        // Actor 1: Open trove
        switchActor(1);
        borrowerOperations_openTrove_clamped_5000(_ownerIndex, _upperHint, _lowerHint);
        
        // Actor 1: Add collateral
        borrowerOperations_addColl_clamped_1eth(_troveId);
        
        // Actor 1: Withdraw some collateral
        borrowerOperations_withdrawColl_clamped_1eth(_troveId);
    }


    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
