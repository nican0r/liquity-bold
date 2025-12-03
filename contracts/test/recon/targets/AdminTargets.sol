// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

abstract contract AdminTargets is
    BaseTargetFunctions,
    Properties
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///


    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    // ActivePool admin functions
    function activePool_accountForReceivedColl(uint256 _amount) public asAdmin {
        activePool.accountForReceivedColl(_amount);
    }

    function activePool_mintAggInterest() public asAdmin {
        activePool.mintAggInterest();
    }

    function activePool_mintAggInterestAndAccountForTroveChange(TroveChange memory _troveChange, address _batchAddress) public asAdmin {
        activePool.mintAggInterestAndAccountForTroveChange(_troveChange, _batchAddress);
    }

    function activePool_mintBatchManagementFeeAndAccountForChange(TroveChange memory _troveChange, address _batchAddress) public asAdmin {
        activePool.mintBatchManagementFeeAndAccountForChange(_troveChange, _batchAddress);
    }

    function activePool_receiveColl(uint256 _amount) public asAdmin {
        activePool.receiveColl(_amount);
    }

    function activePool_sendColl(address _account, uint256 _amount) public asAdmin {
        activePool.sendColl(_account, _amount);
    }

    function activePool_sendCollToDefaultPool(uint256 _amount) public asAdmin {
        activePool.sendCollToDefaultPool(_amount);
    }

    function activePool_setShutdownFlag() public asAdmin {
        activePool.setShutdownFlag();
    }

    // BoldToken admin functions
    function boldToken_burn(address _account, uint256 _amount) public asAdmin {
        boldToken.burn(_account, _amount);
    }

    function boldToken_mint(address _account, uint256 _amount) public asAdmin {
        boldToken.mint(_account, _amount);
    }

    function boldToken_returnFromPool(address _poolAddress, address _receiver, uint256 _amount) public asAdmin {
        boldToken.returnFromPool(_poolAddress, _receiver, _amount);
    }

    function boldToken_sendToPool(address _sender, address _poolAddress, uint256 _amount) public asAdmin {
        boldToken.sendToPool(_sender, _poolAddress, _amount);
    }

    function boldToken_setBranchAddresses(address _troveManagerAddress, address _stabilityPoolAddress, address _borrowerOperationsAddress, address _activePoolAddress) public asAdmin {
        boldToken.setBranchAddresses(_troveManagerAddress, _stabilityPoolAddress, _borrowerOperationsAddress, _activePoolAddress);
    }

    function boldToken_setCollateralRegistry(address _collateralRegistryAddress) public asAdmin {
        boldToken.setCollateralRegistry(_collateralRegistryAddress);
    }

    // BorrowerOperations admin functions
    function borrowerOperations_onLiquidateTrove(uint256 _troveId) public asAdmin {
        borrowerOperations.onLiquidateTrove(_troveId);
    }

    function borrowerOperations_shutdown() public asAdmin {
        borrowerOperations.shutdown();
    }

    function borrowerOperations_shutdownFromOracleFailure() public asAdmin {
        borrowerOperations.shutdownFromOracleFailure();
    }

    // CollSurplusPool admin functions
    function collSurplusPool_accountSurplus(address _account, uint256 _amount) public asAdmin {
        collSurplusPool.accountSurplus(_account, _amount);
    }

    // DefaultPool admin functions
    function defaultPool_decreaseBoldDebt(uint256 _amount) public asAdmin {
        defaultPool.decreaseBoldDebt(_amount);
    }

    function defaultPool_increaseBoldDebt(uint256 _amount) public asAdmin {
        defaultPool.increaseBoldDebt(_amount);
    }

    function defaultPool_receiveColl(uint256 _amount) public asAdmin {
        defaultPool.receiveColl(_amount);
    }

    function defaultPool_sendCollToActivePool(uint256 _amount) public asAdmin {
        defaultPool.sendCollToActivePool(_amount);
    }

    // SortedTroves admin functions
    function sortedTroves_insert(uint256 _id, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) public asAdmin {
        sortedTroves.insert(_id, _annualInterestRate, _prevId, _nextId);
    }

    function sortedTroves_insertIntoBatch(uint256 _troveId, BatchId _batchId, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) public asAdmin {
        sortedTroves.insertIntoBatch(_troveId, _batchId, _annualInterestRate, _prevId, _nextId);
    }

    function sortedTroves_reInsert(uint256 _id, uint256 _newAnnualInterestRate, uint256 _prevId, uint256 _nextId) public asAdmin {
        sortedTroves.reInsert(_id, _newAnnualInterestRate, _prevId, _nextId);
    }

    function sortedTroves_reInsertBatch(BatchId _id, uint256 _newAnnualInterestRate, uint256 _prevId, uint256 _nextId) public asAdmin {
        sortedTroves.reInsertBatch(_id, _newAnnualInterestRate, _prevId, _nextId);
    }

    function sortedTroves_remove(uint256 _id) public asAdmin {
        sortedTroves.remove(_id);
    }

    function sortedTroves_removeFromBatch(uint256 _id) public asAdmin {
        sortedTroves.removeFromBatch(_id);
    }

    // StabilityPool admin functions
    function stabilityPool_offset(uint256 _debtToOffset, uint256 _collToAdd) public asAdmin {
        stabilityPool.offset(_debtToOffset, _collToAdd);
    }

    function stabilityPool_triggerBoldRewards(uint256 _boldYield) public asAdmin {
        stabilityPool.triggerBoldRewards(_boldYield);
    }

    // TroveManager admin functions
    function troveManager_onAdjustTrove(uint256 _troveId, uint256 _newColl, uint256 _newDebt, TroveChange memory _troveChange) public asAdmin {
        troveManager.onAdjustTrove(_troveId, _newColl, _newDebt, _troveChange);
    }

    function troveManager_onAdjustTroveInsideBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) public asAdmin {
        troveManager.onAdjustTroveInsideBatch(_troveId, _newTroveColl, _newTroveDebt, _troveChange, _batchAddress, _newBatchColl, _newBatchDebt);
    }

    function troveManager_onAdjustTroveInterestRate(uint256 _troveId, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, TroveChange memory _troveChange) public asAdmin {
        troveManager.onAdjustTroveInterestRate(_troveId, _newColl, _newDebt, _newAnnualInterestRate, _troveChange);
    }

    function troveManager_onApplyTroveInterest(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, TroveChange memory _troveChange) public asAdmin {
        troveManager.onApplyTroveInterest(_troveId, _newTroveColl, _newTroveDebt, _batchAddress, _newBatchColl, _newBatchDebt, _troveChange);
    }

    function troveManager_onCloseTrove(uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) public asAdmin {
        troveManager.onCloseTrove(_troveId, _troveChange, _batchAddress, _newBatchColl, _newBatchDebt);
    }

    function troveManager_onLowerBatchManagerAnnualFee(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualManagementFee) public asAdmin {
        troveManager.onLowerBatchManagerAnnualFee(_batchAddress, _newColl, _newDebt, _newAnnualManagementFee);
    }

    function troveManager_onOpenTrove(address _owner, uint256 _troveId, TroveChange memory _troveChange, uint256 _annualInterestRate) public asAdmin {
        troveManager.onOpenTrove(_owner, _troveId, _troveChange, _annualInterestRate);
    }

    function troveManager_onOpenTroveAndJoinBatch(address _owner, uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _batchColl, uint256 _batchDebt) public asAdmin {
        troveManager.onOpenTroveAndJoinBatch(_owner, _troveId, _troveChange, _batchAddress, _batchColl, _batchDebt);
    }

    function troveManager_onRegisterBatchManager(address _account, uint256 _annualInterestRate, uint256 _annualManagementFee) public asAdmin {
        troveManager.onRegisterBatchManager(_account, _annualInterestRate, _annualManagementFee);
    }

    function troveManager_onRemoveFromBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, uint256 _newAnnualInterestRate) public asAdmin {
        troveManager.onRemoveFromBatch(_troveId, _newTroveColl, _newTroveDebt, _troveChange, _batchAddress, _newBatchColl, _newBatchDebt, _newAnnualInterestRate);
    }

    function troveManager_onSetBatchManagerAnnualInterestRate(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, uint256 _upfrontFee) public asAdmin {
        troveManager.onSetBatchManagerAnnualInterestRate(_batchAddress, _newColl, _newDebt, _newAnnualInterestRate, _upfrontFee);
    }

    function troveManager_onSetInterestBatchManager(ITroveManager.OnSetInterestBatchManagerParams memory _params) public asAdmin {
        troveManager.onSetInterestBatchManager(_params);
    }

    function troveManager_redeemCollateral(address _redeemer, uint256 _boldamount, uint256 _price, uint256 _redemptionRate, uint256 _maxIterations) public asAdmin {
        troveManager.redeemCollateral(_redeemer, _boldamount, _price, _redemptionRate, _maxIterations);
    }

    function troveManager_setTroveStatusToActive(uint256 _troveId) public asAdmin {
        troveManager.setTroveStatusToActive(_troveId);
    }

    function troveManager_shutdown() public asAdmin {
        troveManager.shutdown();
    }

    // TroveNFT admin functions
    function troveNFT_burn(uint256 _troveId) public asAdmin {
        troveNFT.burn(_troveId);
    }

    function troveNFT_mint(address _owner, uint256 _troveId) public asAdmin {
        troveNFT.mint(_owner, _troveId);
    }
}