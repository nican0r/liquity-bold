// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {FoundryAsserts} from "@chimera/FoundryAsserts.sol";

import "forge-std/console2.sol";

import {Test} from "forge-std/Test.sol";
import {TargetFunctions} from "./TargetFunctions.sol";

// Types
import "src/Types/TroveChange.sol";
import "src/Types/BatchId.sol";

// Interfaces
import "src/Interfaces/IBorrowerOperations.sol";
import "src/Interfaces/ITroveManager.sol";

// forge test --match-contract CryticToFoundry -vv
contract CryticToFoundry is Test, TargetFunctions, FoundryAsserts {
    function setUp() public {
        setup();

        targetContract(address(this));
    }

    // forge test --match-test test_crytic -vvv
    function test_crytic() public {
        // TODO: add failing property tests here for debugging
    }

    /* ========== ACTIVEPOOL TESTS ========== */
    
    function test_activePool_accountForReceivedColl() public {
        activePool_accountForReceivedColl(1e18);
    }

    function test_activePool_mintAggInterest() public {
        activePool_mintAggInterest();
    }

    function test_activePool_mintAggInterestAndAccountForTroveChange() public {
        TroveChange memory troveChange = TroveChange({
            appliedRedistBoldDebtGain: 0,
            appliedRedistCollGain: 0,
            collIncrease: 1e18,
            collDecrease: 0,
            debtIncrease: 1000e18,
            debtDecrease: 0,
            newWeightedRecordedDebt: 1000e18,
            oldWeightedRecordedDebt: 0,
            upfrontFee: 0,
            batchAccruedManagementFee: 0,
            newWeightedRecordedBatchManagementFee: 0,
            oldWeightedRecordedBatchManagementFee: 0
        });
        activePool_mintAggInterestAndAccountForTroveChange(troveChange, address(0));
    }

    function test_activePool_mintBatchManagementFeeAndAccountForChange() public {
        // First register a batch manager
        borrowerOperations_registerBatchManager(5e16, 10e16, 5e16, 1e16, 7 days);
        
        TroveChange memory troveChange = TroveChange({
            appliedRedistBoldDebtGain: 0,
            appliedRedistCollGain: 0,
            collIncrease: 1e18,
            collDecrease: 0,
            debtIncrease: 1000e18,
            debtDecrease: 0,
            newWeightedRecordedDebt: 1000e18,
            oldWeightedRecordedDebt: 0,
            upfrontFee: 0,
            batchAccruedManagementFee: 0,
            newWeightedRecordedBatchManagementFee: 0,
            oldWeightedRecordedBatchManagementFee: 0
        });
        activePool_mintBatchManagementFeeAndAccountForChange(troveChange, _getActor());
    }

    function test_activePool_receiveColl() public {
        activePool_receiveColl(1e18);
    }

    function test_activePool_sendColl() public {
        activePool_sendColl(_getActor(), 1e18);
    }

    function test_activePool_sendCollToDefaultPool() public {
        activePool_sendCollToDefaultPool(1e18);
    }

    function test_activePool_setShutdownFlag() public {
        activePool_setShutdownFlag();
    }

    /* ========== BOLDTOKEN TESTS ========== */
    
    function test_boldToken_approve() public {
        boldToken_approve(_getActors()[0], 1000e18);
    }

    function test_boldToken_burn() public {
        // First mint some tokens
        boldToken_mint(_getActor(), 1000e18);
        
        // Then burn them
        boldToken_burn(_getActor(), 500e18);
    }

    function test_boldToken_decreaseAllowance() public {
        // First approve
        boldToken_approve(_getActors()[0], 1000e18);
        
        // Then decrease
        boldToken_decreaseAllowance(_getActors()[0], 500e18);
    }

    function test_boldToken_increaseAllowance() public {
        boldToken_increaseAllowance(_getActors()[0], 1000e18);
    }

    function test_boldToken_mint() public {
        boldToken_mint(_getActor(), 1000e18);
    }

    function test_boldToken_permit() public {
        // Skip permit test as it requires valid signature
        vm.skip(true);
    }

    function test_boldToken_returnFromPool() public {
        // First send to pool
        boldToken_sendToPool(_getActor(), address(stabilityPool), 1000e18);
        
        // Then return from pool
        boldToken_returnFromPool(address(stabilityPool), _getActor(), 500e18);
    }

    function test_boldToken_sendToPool() public {
        boldToken_sendToPool(_getActor(), address(stabilityPool), 1000e18);
    }

    function test_boldToken_setBranchAddresses() public {
        boldToken_setBranchAddresses(
            address(troveManager),
            address(stabilityPool),
            address(borrowerOperations),
            address(activePool)
        );
    }

    function test_boldToken_setCollateralRegistry() public {
        boldToken_setCollateralRegistry(address(collateralRegistry));
    }

    function test_boldToken_transfer() public {
        boldToken_transfer(_getActors()[0], 100e18);
    }

    function test_boldToken_transferFrom() public {
        // First approve
        boldToken_approve(_getActor(), 1000e18);
        
        // Then transferFrom
        boldToken_transferFrom(_getActor(), _getActors()[0], 500e18);
    }

    /* ========== BORROWEROPERATIONS TESTS ========== */
    
    function test_borrowerOperations_addColl() public {
        // First open a trove
        borrowerOperations_openTrove(
            _getActor(),
            0,
            10e18,
            2000e18,
            0,
            0,
            5e16,
            1000e18,
            address(0),
            address(0),
            address(0)
        );
        
        // Then add collateral
        borrowerOperations_addColl(0, 5e18);
    }

    function test_borrowerOperations_adjustTrove() public {
        // First open a trove
        borrowerOperations_openTrove(
            _getActor(),
            0,
            10e18,
            2000e18,
            0,
            0,
            5e16,
            1000e18,
            address(0),
            address(0),
            address(0)
        );
        
        // Then adjust it
        borrowerOperations_adjustTrove(0, 1e18, true, 100e18, true, 100e18);
    }

    function test_borrowerOperations_adjustTroveInterestRate() public {
        // First open a trove
        borrowerOperations_openTrove(
            _getActor(),
            0,
            10e18,
            2000e18,
            0,
            0,
            5e16,
            1000e18,
            address(0),
            address(0),
            address(0)
        );
        
        // Then adjust interest rate
        borrowerOperations_adjustTroveInterestRate(0, 6e16, 0, 0, 100e18);
    }

    function test_borrowerOperations_adjustZombieTrove() public {
        // First open a trove
        borrowerOperations_openTrove(
            _getActor(),
            0,
            10e18,
            2000e18,
            0,
            0,
            5e16,
            1000e18,
            address(0),
            address(0),
            address(0)
        );
        
        // Adjust zombie trove
        borrowerOperations_adjustZombieTrove(0, 1e18, true, 100e18, true, 0, 0, 100e18);
    }

    function test_borrowerOperations_applyPendingDebt() public {
        // First open a trove
        borrowerOperations_openTrove(
            _getActor(),
            0,
            10e18,
            2000e18,
            0,
            0,
            5e16,
            1000e18,
            address(0),
            address(0),
            address(0)
        );
        
        // Apply pending debt
        borrowerOperations_applyPendingDebt(0, 0, 0);
    }

    function test_borrowerOperations_claimCollateral() public {
        borrowerOperations_claimCollateral();
    }

    function test_borrowerOperations_closeTrove() public {
        // First open a trove
        borrowerOperations_openTrove(
            _getActor(),
            0,
            10e18,
            2000e18,
            0,
            0,
            5e16,
            1000e18,
            address(0),
            address(0),
            address(0)
        );
        
        // Close the trove
        borrowerOperations_closeTrove(0);
    }

    function test_borrowerOperations_kickFromBatch() public {
        // First register a batch manager
        borrowerOperations_registerBatchManager(5e16, 10e16, 5e16, 1e16, 7 days);
        
        address batchManager = _getActor();
        
        // Open trove and join batch
        IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory params = 
            IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams({
                owner: _getActor(),
                ownerIndex: 0,
                collAmount: 10e18,
                boldAmount: 2000e18,
                upperHint: 0,
                lowerHint: 0,
                interestBatchManager: batchManager,
                maxUpfrontFee: 1000e18,
                addManager: address(0),
                removeManager: address(0),
                receiver: address(0)
            });
        borrowerOperations_openTroveAndJoinInterestBatchManager(params);
        
        // Kick from batch
        borrowerOperations_kickFromBatch(0, 0, 0);
    }

    function test_borrowerOperations_lowerBatchManagementFee() public {
        // First register a batch manager
        borrowerOperations_registerBatchManager(5e16, 10e16, 5e16, 5e16, 7 days);
        
        // Lower the fee
        borrowerOperations_lowerBatchManagementFee(2e16);
    }

    function test_borrowerOperations_onLiquidateTrove() public {
        // First open a trove
        borrowerOperations_openTrove(
            _getActor(),
            0,
            10e18,
            2000e18,
            0,
            0,
            5e16,
            1000e18,
            address(0),
            address(0),
            address(0)
        );
        
        // Liquidate it (admin function)
        borrowerOperations_onLiquidateTrove(0);
    }

    function test_borrowerOperations_openTrove() public {
        borrowerOperations_openTrove(
            _getActor(),
            0,
            10e18,
            2000e18,
            0,
            0,
            5e16,
            1000e18,
            address(0),
            address(0),
            address(0)
        );
    }

    function test_borrowerOperations_openTroveAndJoinInterestBatchManager() public {
        // First register a batch manager
        borrowerOperations_registerBatchManager(5e16, 10e16, 5e16, 1e16, 7 days);
        
        address batchManager = _getActor();
        
        IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory params = 
            IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams({
                owner: _getActor(),
                ownerIndex: 0,
                collAmount: 10e18,
                boldAmount: 2000e18,
                upperHint: 0,
                lowerHint: 0,
                interestBatchManager: batchManager,
                maxUpfrontFee: 1000e18,
                addManager: address(0),
                removeManager: address(0),
                receiver: address(0)
            });
        borrowerOperations_openTroveAndJoinInterestBatchManager(params);
    }

    function test_borrowerOperations_registerBatchManager() public {
        borrowerOperations_registerBatchManager(5e16, 10e16, 5e16, 1e16, 7 days);
    }

    function test_borrowerOperations_removeFromBatch() public {
        // First register a batch manager
        borrowerOperations_registerBatchManager(5e16, 10e16, 5e16, 1e16, 7 days);
        
        address batchManager = _getActor();
        
        // Open trove and join batch
        IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory params = 
            IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams({
                owner: _getActor(),
                ownerIndex: 0,
                collAmount: 10e18,
                boldAmount: 2000e18,
                upperHint: 0,
                lowerHint: 0,
                interestBatchManager: batchManager,
                maxUpfrontFee: 1000e18,
                addManager: address(0),
                removeManager: address(0),
                receiver: address(0)
            });
        borrowerOperations_openTroveAndJoinInterestBatchManager(params);
        
        // Remove from batch
        borrowerOperations_removeFromBatch(0, 5e16, 0, 0, 100e18);
    }

    function test_borrowerOperations_removeInterestIndividualDelegate() public {
        // First open a trove
        borrowerOperations_openTrove(
            _getActor(),
            0,
            10e18,
            2000e18,
            0,
            0,
            5e16,
            1000e18,
            address(0),
            address(0),
            address(0)
        );
        
        // Set delegate
        borrowerOperations_setInterestIndividualDelegate(
            0,
            _getActors()[0],
            5e16,
            10e16,
            5e16,
            0,
            0,
            100e18,
            7 days
        );
        
        // Remove delegate
        borrowerOperations_removeInterestIndividualDelegate(0);
    }

    function test_borrowerOperations_repayBold() public {
        // First open a trove
        borrowerOperations_openTrove(
            _getActor(),
            0,
            10e18,
            2000e18,
            0,
            0,
            5e16,
            1000e18,
            address(0),
            address(0),
            address(0)
        );
        
        // Withdraw bold
        borrowerOperations_withdrawBold(0, 100e18, 100e18);
        
        // Repay it
        borrowerOperations_repayBold(0, 50e18);
    }

    function test_borrowerOperations_setAddManager() public {
        // First open a trove
        borrowerOperations_openTrove(
            _getActor(),
            0,
            10e18,
            2000e18,
            0,
            0,
            5e16,
            1000e18,
            address(0),
            address(0),
            address(0)
        );
        
        // Set add manager
        borrowerOperations_setAddManager(0, _getActors()[0]);
    }

    function test_borrowerOperations_setBatchManagerAnnualInterestRate() public {
        // First register a batch manager
        borrowerOperations_registerBatchManager(5e16, 10e16, 5e16, 1e16, 7 days);
        
        // Set new interest rate
        borrowerOperations_setBatchManagerAnnualInterestRate(6e16, 0, 0, 100e18);
    }

    function test_borrowerOperations_setInterestBatchManager() public {
        // First open a trove
        borrowerOperations_openTrove(
            _getActor(),
            0,
            10e18,
            2000e18,
            0,
            0,
            5e16,
            1000e18,
            address(0),
            address(0),
            address(0)
        );
        
        // Register a batch manager
        switchActor(1);
        borrowerOperations_registerBatchManager(5e16, 10e16, 5e16, 1e16, 7 days);
        address batchManager = _getActor();
        
        // Switch back and set batch manager
        switchActor(0);
        borrowerOperations_setInterestBatchManager(0, batchManager, 0, 0, 100e18);
    }

    function test_borrowerOperations_setInterestIndividualDelegate() public {
        // First open a trove
        borrowerOperations_openTrove(
            _getActor(),
            0,
            10e18,
            2000e18,
            0,
            0,
            5e16,
            1000e18,
            address(0),
            address(0),
            address(0)
        );
        
        // Set delegate
        borrowerOperations_setInterestIndividualDelegate(
            0,
            _getActors()[0],
            5e16,
            10e16,
            5e16,
            0,
            0,
            100e18,
            7 days
        );
    }

    function test_borrowerOperations_setRemoveManager() public {
        // First open a trove
        borrowerOperations_openTrove(
            _getActor(),
            0,
            10e18,
            2000e18,
            0,
            0,
            5e16,
            1000e18,
            address(0),
            address(0),
            address(0)
        );
        
        // Set remove manager
        borrowerOperations_setRemoveManager(0, _getActors()[0]);
    }

    function test_borrowerOperations_setRemoveManagerWithReceiver() public {
        // First open a trove
        borrowerOperations_openTrove(
            _getActor(),
            0,
            10e18,
            2000e18,
            0,
            0,
            5e16,
            1000e18,
            address(0),
            address(0),
            address(0)
        );
        
        // Set remove manager with receiver
        borrowerOperations_setRemoveManagerWithReceiver(0, _getActors()[0], _getActors()[1]);
    }

    function test_borrowerOperations_shutdown() public {
        borrowerOperations_shutdown();
    }

    function test_borrowerOperations_shutdownFromOracleFailure() public {
        borrowerOperations_shutdownFromOracleFailure();
    }

    function test_borrowerOperations_switchBatchManager() public {
        // Register first batch manager
        borrowerOperations_registerBatchManager(5e16, 10e16, 5e16, 1e16, 7 days);
        address batchManager1 = _getActor();
        
        // Open trove and join first batch
        IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory params = 
            IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams({
                owner: _getActor(),
                ownerIndex: 0,
                collAmount: 10e18,
                boldAmount: 2000e18,
                upperHint: 0,
                lowerHint: 0,
                interestBatchManager: batchManager1,
                maxUpfrontFee: 1000e18,
                addManager: address(0),
                removeManager: address(0),
                receiver: address(0)
            });
        borrowerOperations_openTroveAndJoinInterestBatchManager(params);
        
        // Register second batch manager
        switchActor(1);
        borrowerOperations_registerBatchManager(5e16, 10e16, 6e16, 1e16, 7 days);
        address batchManager2 = _getActor();
        
        // Switch batch manager
        switchActor(0);
        borrowerOperations_switchBatchManager(0, 0, 0, batchManager2, 0, 0, 100e18);
    }

    function test_borrowerOperations_withdrawBold() public {
        // First open a trove
        borrowerOperations_openTrove(
            _getActor(),
            0,
            10e18,
            2000e18,
            0,
            0,
            5e16,
            1000e18,
            address(0),
            address(0),
            address(0)
        );
        
        // Withdraw bold
        borrowerOperations_withdrawBold(0, 100e18, 100e18);
    }

    function test_borrowerOperations_withdrawColl() public {
        // First open a trove
        borrowerOperations_openTrove(
            _getActor(),
            0,
            10e18,
            2000e18,
            0,
            0,
            5e16,
            1000e18,
            address(0),
            address(0),
            address(0)
        );
        
        // Withdraw collateral
        borrowerOperations_withdrawColl(0, 1e18);
    }

    /* ========== COLLSURPLUSPOOL TESTS ========== */
    
    function test_collSurplusPool_accountSurplus() public {
        collSurplusPool_accountSurplus(_getActor(), 1e18);
    }

    function test_collSurplusPool_claimColl() public {
        // First account surplus
        collSurplusPool_accountSurplus(_getActor(), 1e18);
        
        // Then claim
        collSurplusPool_claimColl(_getActor());
    }

    /* ========== COLLATERALREGISTRY TESTS ========== */
    
    function test_collateralRegistry_redeemCollateral() public {
        // First open a trove
        borrowerOperations_openTrove(
            _getActor(),
            0,
            10e18,
            2000e18,
            0,
            0,
            5e16,
            1000e18,
            address(0),
            address(0),
            address(0)
        );
        
        // Redeem collateral
        collateralRegistry_redeemCollateral(100e18, 10, 5e16);
    }

    /* ========== DEFAULTPOOL TESTS ========== */
    
    function test_defaultPool_decreaseBoldDebt() public {
        // First increase debt
        defaultPool_increaseBoldDebt(1000e18);
        
        // Then decrease it
        defaultPool_decreaseBoldDebt(500e18);
    }

    function test_defaultPool_increaseBoldDebt() public {
        defaultPool_increaseBoldDebt(1000e18);
    }

    function test_defaultPool_receiveColl() public {
        defaultPool_receiveColl(1e18);
    }

    function test_defaultPool_sendCollToActivePool() public {
        // First receive collateral
        defaultPool_receiveColl(1e18);
        
        // Then send it
        defaultPool_sendCollToActivePool(0.5e18);
    }

    /* ========== SORTEDTROVES TESTS ========== */
    
    function test_sortedTroves_insert() public {
        sortedTroves_insert(1, 5e16, 0, 0);
    }

    function test_sortedTroves_insertIntoBatch() public {
        // First register a batch manager
        borrowerOperations_registerBatchManager(5e16, 10e16, 5e16, 1e16, 7 days);
        
        // Create batch ID
        BatchId batchId = BatchId.wrap(_getActor());
        
        // Insert into batch
        sortedTroves_insertIntoBatch(1, batchId, 5e16, 0, 0);
    }

    function test_sortedTroves_reInsert() public {
        // First insert
        sortedTroves_insert(1, 5e16, 0, 0);
        
        // Then reinsert with new rate
        sortedTroves_reInsert(1, 6e16, 0, 0);
    }

    function test_sortedTroves_reInsertBatch() public {
        // First register a batch manager
        borrowerOperations_registerBatchManager(5e16, 10e16, 5e16, 1e16, 7 days);
        
        // Create batch ID
        BatchId batchId = BatchId.wrap(_getActor());
        
        // Reinsert batch with new rate
        sortedTroves_reInsertBatch(batchId, 6e16, 0, 0);
    }

    function test_sortedTroves_remove() public {
        // First insert
        sortedTroves_insert(1, 5e16, 0, 0);
        
        // Then remove
        sortedTroves_remove(1);
    }

    function test_sortedTroves_removeFromBatch() public {
        // First register a batch manager and insert into batch
        borrowerOperations_registerBatchManager(5e16, 10e16, 5e16, 1e16, 7 days);
        BatchId batchId = BatchId.wrap(_getActor());
        sortedTroves_insertIntoBatch(1, batchId, 5e16, 0, 0);
        
        // Then remove from batch
        sortedTroves_removeFromBatch(1);
    }

    /* ========== STABILITYPOOL TESTS ========== */
    
    function test_stabilityPool_claimAllCollGains() public {
        // First provide to SP
        stabilityPool_provideToSP(1000e18, false);
        
        // Claim gains
        stabilityPool_claimAllCollGains();
    }

    function test_stabilityPool_offset() public {
        // First provide to SP
        stabilityPool_provideToSP(1000e18, false);
        
        // Offset
        stabilityPool_offset(100e18, 1e18);
    }

    function test_stabilityPool_provideToSP() public {
        stabilityPool_provideToSP(1000e18, false);
    }

    function test_stabilityPool_triggerBoldRewards() public {
        stabilityPool_triggerBoldRewards(100e18);
    }

    function test_stabilityPool_withdrawFromSP() public {
        // First provide to SP
        stabilityPool_provideToSP(1000e18, false);
        
        // Then withdraw
        stabilityPool_withdrawFromSP(500e18, false);
    }

    /* ========== TROVEMANAGER TESTS ========== */
    
    function test_troveManager_batchLiquidateTroves() public {
        // First open a trove
        borrowerOperations_openTrove(
            _getActor(),
            0,
            10e18,
            2000e18,
            0,
            0,
            5e16,
            1000e18,
            address(0),
            address(0),
            address(0)
        );
        
        // Create array with trove ID
        uint256[] memory troveIds = new uint256[](1);
        troveIds[0] = 0;
        
        // Batch liquidate
        troveManager_batchLiquidateTroves(troveIds);
    }

    function test_troveManager_getUnbackedPortionPriceAndRedeemability() public {
        troveManager_getUnbackedPortionPriceAndRedeemability();
    }

    function test_troveManager_onAdjustTrove() public {
        TroveChange memory troveChange = TroveChange({
            appliedRedistBoldDebtGain: 0,
            appliedRedistCollGain: 0,
            collIncrease: 1e18,
            collDecrease: 0,
            debtIncrease: 1000e18,
            debtDecrease: 0,
            newWeightedRecordedDebt: 1000e18,
            oldWeightedRecordedDebt: 0,
            upfrontFee: 0,
            batchAccruedManagementFee: 0,
            newWeightedRecordedBatchManagementFee: 0,
            oldWeightedRecordedBatchManagementFee: 0
        });
        troveManager_onAdjustTrove(0, 10e18, 2000e18, troveChange);
    }

    function test_troveManager_onAdjustTroveInsideBatch() public {
        TroveChange memory troveChange = TroveChange({
            appliedRedistBoldDebtGain: 0,
            appliedRedistCollGain: 0,
            collIncrease: 1e18,
            collDecrease: 0,
            debtIncrease: 1000e18,
            debtDecrease: 0,
            newWeightedRecordedDebt: 1000e18,
            oldWeightedRecordedDebt: 0,
            upfrontFee: 0,
            batchAccruedManagementFee: 0,
            newWeightedRecordedBatchManagementFee: 0,
            oldWeightedRecordedBatchManagementFee: 0
        });
        troveManager_onAdjustTroveInsideBatch(0, 10e18, 2000e18, troveChange, _getActor(), 10e18, 2000e18);
    }

    function test_troveManager_onAdjustTroveInterestRate() public {
        TroveChange memory troveChange = TroveChange({
            appliedRedistBoldDebtGain: 0,
            appliedRedistCollGain: 0,
            collIncrease: 0,
            collDecrease: 0,
            debtIncrease: 0,
            debtDecrease: 0,
            newWeightedRecordedDebt: 1000e18,
            oldWeightedRecordedDebt: 1000e18,
            upfrontFee: 0,
            batchAccruedManagementFee: 0,
            newWeightedRecordedBatchManagementFee: 0,
            oldWeightedRecordedBatchManagementFee: 0
        });
        troveManager_onAdjustTroveInterestRate(0, 10e18, 2000e18, 6e16, troveChange);
    }

    function test_troveManager_onApplyTroveInterest() public {
        TroveChange memory troveChange = TroveChange({
            appliedRedistBoldDebtGain: 0,
            appliedRedistCollGain: 0,
            collIncrease: 0,
            collDecrease: 0,
            debtIncrease: 100e18,
            debtDecrease: 0,
            newWeightedRecordedDebt: 1100e18,
            oldWeightedRecordedDebt: 1000e18,
            upfrontFee: 0,
            batchAccruedManagementFee: 0,
            newWeightedRecordedBatchManagementFee: 0,
            oldWeightedRecordedBatchManagementFee: 0
        });
        troveManager_onApplyTroveInterest(0, 10e18, 2100e18, address(0), 0, 0, troveChange);
    }

    function test_troveManager_onCloseTrove() public {
        TroveChange memory troveChange = TroveChange({
            appliedRedistBoldDebtGain: 0,
            appliedRedistCollGain: 0,
            collIncrease: 0,
            collDecrease: 10e18,
            debtIncrease: 0,
            debtDecrease: 2000e18,
            newWeightedRecordedDebt: 0,
            oldWeightedRecordedDebt: 2000e18,
            upfrontFee: 0,
            batchAccruedManagementFee: 0,
            newWeightedRecordedBatchManagementFee: 0,
            oldWeightedRecordedBatchManagementFee: 0
        });
        troveManager_onCloseTrove(0, troveChange, address(0), 0, 0);
    }

    function test_troveManager_onLowerBatchManagerAnnualFee() public {
        troveManager_onLowerBatchManagerAnnualFee(_getActor(), 10e18, 2000e18, 1e16);
    }

    function test_troveManager_onOpenTrove() public {
        TroveChange memory troveChange = TroveChange({
            appliedRedistBoldDebtGain: 0,
            appliedRedistCollGain: 0,
            collIncrease: 10e18,
            collDecrease: 0,
            debtIncrease: 2000e18,
            debtDecrease: 0,
            newWeightedRecordedDebt: 2000e18,
            oldWeightedRecordedDebt: 0,
            upfrontFee: 0,
            batchAccruedManagementFee: 0,
            newWeightedRecordedBatchManagementFee: 0,
            oldWeightedRecordedBatchManagementFee: 0
        });
        troveManager_onOpenTrove(_getActor(), 0, troveChange, 5e16);
    }

    function test_troveManager_onOpenTroveAndJoinBatch() public {
        TroveChange memory troveChange = TroveChange({
            appliedRedistBoldDebtGain: 0,
            appliedRedistCollGain: 0,
            collIncrease: 10e18,
            collDecrease: 0,
            debtIncrease: 2000e18,
            debtDecrease: 0,
            newWeightedRecordedDebt: 2000e18,
            oldWeightedRecordedDebt: 0,
            upfrontFee: 0,
            batchAccruedManagementFee: 0,
            newWeightedRecordedBatchManagementFee: 0,
            oldWeightedRecordedBatchManagementFee: 0
        });
        troveManager_onOpenTroveAndJoinBatch(_getActor(), 0, troveChange, _getActor(), 10e18, 2000e18);
    }

    function test_troveManager_onRegisterBatchManager() public {
        troveManager_onRegisterBatchManager(_getActor(), 5e16, 1e16);
    }

    function test_troveManager_onRemoveFromBatch() public {
        TroveChange memory troveChange = TroveChange({
            appliedRedistBoldDebtGain: 0,
            appliedRedistCollGain: 0,
            collIncrease: 0,
            collDecrease: 0,
            debtIncrease: 0,
            debtDecrease: 0,
            newWeightedRecordedDebt: 2000e18,
            oldWeightedRecordedDebt: 2000e18,
            upfrontFee: 0,
            batchAccruedManagementFee: 0,
            newWeightedRecordedBatchManagementFee: 0,
            oldWeightedRecordedBatchManagementFee: 0
        });
        troveManager_onRemoveFromBatch(0, 10e18, 2000e18, troveChange, _getActor(), 0, 0, 5e16);
    }

    function test_troveManager_onSetBatchManagerAnnualInterestRate() public {
        troveManager_onSetBatchManagerAnnualInterestRate(_getActor(), 10e18, 2000e18, 6e16, 10e18);
    }

    function test_troveManager_onSetInterestBatchManager() public {
        ITroveManager.OnSetInterestBatchManagerParams memory params = ITroveManager.OnSetInterestBatchManagerParams({
            troveId: 0,
            troveColl: 10e18,
            troveDebt: 2000e18,
            troveChange: TroveChange({
                appliedRedistBoldDebtGain: 0,
                appliedRedistCollGain: 0,
                collIncrease: 0,
                collDecrease: 0,
                debtIncrease: 0,
                debtDecrease: 0,
                newWeightedRecordedDebt: 2000e18,
                oldWeightedRecordedDebt: 2000e18,
                upfrontFee: 0,
                batchAccruedManagementFee: 0,
                newWeightedRecordedBatchManagementFee: 0,
                oldWeightedRecordedBatchManagementFee: 0
            }),
            newBatchAddress: _getActor(),
            newBatchColl: 10e18,
            newBatchDebt: 2000e18
        });
        troveManager_onSetInterestBatchManager(params);
    }

    function test_troveManager_redeemCollateral() public {
        troveManager_redeemCollateral(_getActor(), 100e18, 2000e18, 5e16, 10);
    }

    function test_troveManager_setTroveStatusToActive() public {
        troveManager_setTroveStatusToActive(0);
    }

    function test_troveManager_shutdown() public {
        troveManager_shutdown();
    }

    function test_troveManager_urgentRedemption() public {
        // First open a trove
        borrowerOperations_openTrove(
            _getActor(),
            0,
            10e18,
            2000e18,
            0,
            0,
            5e16,
            1000e18,
            address(0),
            address(0),
            address(0)
        );
        
        // Shutdown
        borrowerOperations_shutdown();
        
        // Create array with trove ID
        uint256[] memory troveIds = new uint256[](1);
        troveIds[0] = 0;
        
        // Urgent redemption
        troveManager_urgentRedemption(100e18, troveIds, 1e18);
    }

    /* ========== TROVENFT TESTS ========== */
    
    function test_troveNFT_approve() public {
        // First mint an NFT
        troveNFT_mint(_getActor(), 0);
        
        // Approve
        troveNFT_approve(_getActors()[0], 0);
    }

    function test_troveNFT_burn() public {
        // First mint an NFT
        troveNFT_mint(_getActor(), 0);
        
        // Burn it
        troveNFT_burn(0);
    }

    function test_troveNFT_mint() public {
        troveNFT_mint(_getActor(), 0);
    }

    function test_troveNFT_safeTransferFrom() public {
        // First mint an NFT
        troveNFT_mint(_getActor(), 0);
        
        // Transfer it
        troveNFT_safeTransferFrom(_getActor(), _getActors()[0], 0);
    }

    function test_troveNFT_setApprovalForAll() public {
        troveNFT_setApprovalForAll(_getActors()[0], true);
    }

    function test_troveNFT_transferFrom() public {
        // First mint an NFT
        troveNFT_mint(_getActor(), 0);
        
        // Transfer it
        troveNFT_transferFrom(_getActor(), _getActors()[0], 0);
    }


}