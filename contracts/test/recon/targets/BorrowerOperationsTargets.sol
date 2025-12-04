// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

import "src/BorrowerOperations.sol";

abstract contract BorrowerOperationsTargets is
    BaseTargetFunctions,
    Properties
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    // Clamped handler for openTrove with meaningful values
    function borrowerOperations_openTrove_clamped_2000(uint256 _ownerIndex, uint256 _upperHint, uint256 _lowerHint) public asActor {
        borrowerOperations.openTrove(
            _getActor(),
            _ownerIndex,
            collToken.balanceOf(_getActor()),
            2000e18,
            _upperHint,
            _lowerHint,
            5e15,
            1e18,
            _getActors()[0],
            _getActors()[0],
            _getActor()
        );
    }

    // Clamped handler for openTrove with 5000 BOLD
    function borrowerOperations_openTrove_clamped_5000(uint256 _ownerIndex, uint256 _upperHint, uint256 _lowerHint) public asActor {
        borrowerOperations.openTrove(
            _getActor(),
            _ownerIndex,
            collToken.balanceOf(_getActor()),
            5000e18,
            _upperHint,
            _lowerHint,
            1e16,
            10e18,
            _getActors()[0],
            _getActors()[0],
            _getActor()
        );
    }

    // Clamped handler for addColl with max collateral
    function borrowerOperations_addColl_clamped_max(uint256 _troveId) public asActor {
        borrowerOperations.addColl(_troveId, collToken.balanceOf(_getActor()));
    }

    // Clamped handler for addColl with 1 ETH
    function borrowerOperations_addColl_clamped_1eth(uint256 _troveId) public asActor {
        uint256 _collAmount = 1e18;
        borrowerOperations.addColl(_troveId, _collAmount);
    }

    // Clamped handler for adjustTrove with clamped collateral increase
    function borrowerOperations_adjustTrove_clamped_collIncrease(uint256 _troveId) public asActor {
        borrowerOperations.adjustTrove(_troveId, collToken.balanceOf(_getActor()), true, 1000e18, true, 1e18);
    }

    // Clamped handler for adjustTrove with clamped BOLD decrease
    function borrowerOperations_adjustTrove_clamped_debtDecrease(uint256 _troveId) public asActor {
        borrowerOperations.adjustTrove(_troveId, 1e18, false, boldToken.balanceOf(_getActor()), false, 1e18);
    }

    // Clamped handler for adjustTroveInterestRate
    function borrowerOperations_adjustTroveInterestRate_clamped_5bps(uint256 _troveId, uint256 _upperHint, uint256 _lowerHint) public asActor {
        uint256 _newAnnualInterestRate = 5e15;
        uint256 _maxUpfrontFee = 1e18;
        borrowerOperations.adjustTroveInterestRate(_troveId, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    // Clamped handler for adjustTroveInterestRate - 1%
    function borrowerOperations_adjustTroveInterestRate_clamped_1pct(uint256 _troveId, uint256 _upperHint, uint256 _lowerHint) public asActor {
        uint256 _newAnnualInterestRate = 1e16;
        uint256 _maxUpfrontFee = 10e18;
        borrowerOperations.adjustTroveInterestRate(_troveId, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    // Clamped handler for adjustTroveInterestRate - 5%
    function borrowerOperations_adjustTroveInterestRate_clamped_5pct(uint256 _troveId, uint256 _upperHint, uint256 _lowerHint) public asActor {
        uint256 _newAnnualInterestRate = 5e16;
        uint256 _maxUpfrontFee = 1e18;
        borrowerOperations.adjustTroveInterestRate(_troveId, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    // Clamped handler for adjustZombieTrove with clamped values
    function borrowerOperations_adjustZombieTrove_clamped(uint256 _troveId, uint256 _upperHint, uint256 _lowerHint) public asActor {
        borrowerOperations.adjustZombieTrove(_troveId, collToken.balanceOf(_getActor()), true, 1000e18, false, _upperHint, _lowerHint, 1e18);
    }

    // Clamped handler for registerBatchManager
    function borrowerOperations_registerBatchManager_clamped_conservative() public asActor {
        uint128 _minInterestRate = 5e15;
        uint128 _maxInterestRate = 1e17;
        uint128 _currentInterestRate = 1e16;
        uint128 _annualManagementFee = 1e16;
        uint128 _minInterestRateChangePeriod = 3600;
        borrowerOperations.registerBatchManager(_minInterestRate, _maxInterestRate, _currentInterestRate, _annualManagementFee, _minInterestRateChangePeriod);
    }

    // Clamped handler for registerBatchManager - aggressive
    function borrowerOperations_registerBatchManager_clamped_aggressive() public asActor {
        uint128 _minInterestRate = 1e16;
        uint128 _maxInterestRate = 25e17;
        uint128 _currentInterestRate = 5e16;
        uint128 _annualManagementFee = 5e16;
        uint128 _minInterestRateChangePeriod = 86400;
        borrowerOperations.registerBatchManager(_minInterestRate, _maxInterestRate, _currentInterestRate, _annualManagementFee, _minInterestRateChangePeriod);
    }

    // Clamped handler for removeFromBatch
    function borrowerOperations_removeFromBatch_clamped(uint256 _troveId, uint256 _upperHint, uint256 _lowerHint) public asActor {
        uint256 _newAnnualInterestRate = 5e15;
        uint256 _maxUpfrontFee = 1e18;
        borrowerOperations.removeFromBatch(_troveId, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    // Clamped handler for repayBold with max amount
    function borrowerOperations_repayBold_clamped_max(uint256 _troveId) public asActor {
        borrowerOperations.repayBold(_troveId, boldToken.balanceOf(_getActor()));
    }

    // Clamped handler for repayBold with 1000 BOLD
    function borrowerOperations_repayBold_clamped_1000(uint256 _troveId) public asActor {
        uint256 _boldAmount = 1000e18;
        borrowerOperations.repayBold(_troveId, _boldAmount);
    }

    // Clamped handler for setAddManager
    function borrowerOperations_setAddManager_clamped(uint256 _troveId) public asActor {
        address _manager = _getActors()[0];
        borrowerOperations.setAddManager(_troveId, _manager);
    }

    // Clamped handler for setBatchManagerAnnualInterestRate - low rate
    function borrowerOperations_setBatchManagerAnnualInterestRate_clamped_low(uint256 _upperHint, uint256 _lowerHint) public asActor {
        uint128 _newAnnualInterestRate = 5e15;
        uint256 _maxUpfrontFee = 1e18;
        borrowerOperations.setBatchManagerAnnualInterestRate(_newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    // Clamped handler for setBatchManagerAnnualInterestRate - medium rate
    function borrowerOperations_setBatchManagerAnnualInterestRate_clamped_med(uint256 _upperHint, uint256 _lowerHint) public asActor {
        uint128 _newAnnualInterestRate = 5e16;
        uint256 _maxUpfrontFee = 10e18;
        borrowerOperations.setBatchManagerAnnualInterestRate(_newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    // Clamped handler for setInterestBatchManager
    function borrowerOperations_setInterestBatchManager_clamped(uint256 _troveId, uint256 _upperHint, uint256 _lowerHint) public asActor {
        address _newBatchManager = _getActors()[0];
        uint256 _maxUpfrontFee = 1e18;
        borrowerOperations.setInterestBatchManager(_troveId, _newBatchManager, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    // Clamped handler for setInterestIndividualDelegate
    function borrowerOperations_setInterestIndividualDelegate_clamped(uint256 _troveId, uint256 _upperHint, uint256 _lowerHint) public asActor {
        address _delegate = _getActors()[0];
        uint128 _minInterestRate = 5e15;
        uint128 _maxInterestRate = 1e17;
        uint256 _newAnnualInterestRate = 1e16;
        uint256 _maxUpfrontFee = 1e18;
        uint256 _minInterestRateChangePeriod = 3600;
        borrowerOperations.setInterestIndividualDelegate(_troveId, _delegate, _minInterestRate, _maxInterestRate, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee, _minInterestRateChangePeriod);
    }

    // Clamped handler for setRemoveManager
    function borrowerOperations_setRemoveManager_clamped(uint256 _troveId) public asActor {
        address _manager = _getActors()[0];
        borrowerOperations.setRemoveManager(_troveId, _manager);
    }

    // Clamped handler for setRemoveManagerWithReceiver
    function borrowerOperations_setRemoveManagerWithReceiver_clamped(uint256 _troveId) public asActor {
        address _manager = _getActors()[0];
        address _receiver = _getActors()[0];
        borrowerOperations.setRemoveManagerWithReceiver(_troveId, _manager, _receiver);
    }

    // Clamped handler for switchBatchManager
    function borrowerOperations_switchBatchManager_clamped(uint256 _troveId, uint256 _removeUpperHint, uint256 _removeLowerHint, uint256 _addUpperHint, uint256 _addLowerHint) public asActor {
        address _newBatchManager = _getActors()[0];
        uint256 _maxUpfrontFee = 1e18;
        borrowerOperations.switchBatchManager(_troveId, _removeUpperHint, _removeLowerHint, _newBatchManager, _addUpperHint, _addLowerHint, _maxUpfrontFee);
    }

    // Clamped handler for withdrawBold with 1000 BOLD
    function borrowerOperations_withdrawBold_clamped_1000(uint256 _troveId) public asActor {
        uint256 _boldAmount = 1000e18;
        uint256 _maxUpfrontFee = 1e18;
        borrowerOperations.withdrawBold(_troveId, _boldAmount, _maxUpfrontFee);
    }

    // Clamped handler for withdrawBold with 2000 BOLD
    function borrowerOperations_withdrawBold_clamped_2000(uint256 _troveId) public asActor {
        uint256 _boldAmount = 2000e18;
        uint256 _maxUpfrontFee = 10e18;
        borrowerOperations.withdrawBold(_troveId, _boldAmount, _maxUpfrontFee);
    }

    // Clamped handler for withdrawColl with 1 ETH
    function borrowerOperations_withdrawColl_clamped_1eth(uint256 _troveId) public asActor {
        uint256 _collWithdrawal = 1e18;
        borrowerOperations.withdrawColl(_troveId, _collWithdrawal);
    }

    // Clamped handler for withdrawColl with 5 ETH
    function borrowerOperations_withdrawColl_clamped_5eth(uint256 _troveId) public asActor {
        uint256 _collWithdrawal = 5e18;
        borrowerOperations.withdrawColl(_troveId, _collWithdrawal);
    }

    // Clamped handler for lowerBatchManagementFee
    function borrowerOperations_lowerBatchManagementFee_clamped_low() public asActor {
        uint256 _newAnnualManagementFee = 1e16;
        borrowerOperations.lowerBatchManagementFee(_newAnnualManagementFee);
    }

    // Clamped handler for lowerBatchManagementFee - higher
    function borrowerOperations_lowerBatchManagementFee_clamped_high() public asActor {
        uint256 _newAnnualManagementFee = 5e16;
        borrowerOperations.lowerBatchManagementFee(_newAnnualManagementFee);
    }


    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function borrowerOperations_addColl(uint256 _troveId, uint256 _collAmount) public asActor {
        borrowerOperations.addColl(_troveId, _collAmount);
    }

    function borrowerOperations_adjustTrove(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _maxUpfrontFee) public asActor {
        borrowerOperations.adjustTrove(_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, _maxUpfrontFee);
    }

    function borrowerOperations_adjustTroveInterestRate(uint256 _troveId, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public asActor {
        borrowerOperations.adjustTroveInterestRate(_troveId, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_adjustZombieTrove(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public asActor {
        borrowerOperations.adjustZombieTrove(_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_applyPendingDebt(uint256 _troveId, uint256 _lowerHint, uint256 _upperHint) public asActor {
        borrowerOperations.applyPendingDebt(_troveId, _lowerHint, _upperHint);
    }

    function borrowerOperations_claimCollateral() public asActor {
        borrowerOperations.claimCollateral();
    }

    function borrowerOperations_closeTrove(uint256 _troveId) public asActor {
        borrowerOperations.closeTrove(_troveId);
    }

    function borrowerOperations_kickFromBatch(uint256 _troveId, uint256 _upperHint, uint256 _lowerHint) public asActor {
        borrowerOperations.kickFromBatch(_troveId, _upperHint, _lowerHint);
    }

    function borrowerOperations_lowerBatchManagementFee(uint256 _newAnnualManagementFee) public asActor {
        borrowerOperations.lowerBatchManagementFee(_newAnnualManagementFee);
    }

    function borrowerOperations_openTrove(address _owner, uint256 _ownerIndex, uint256 _collAmount, uint256 _boldAmount, uint256 _upperHint, uint256 _lowerHint, uint256 _annualInterestRate, uint256 _maxUpfrontFee, address _addManager, address _removeManager, address _receiver) public asActor {
        borrowerOperations.openTrove(_owner, _ownerIndex, _collAmount, _boldAmount, _upperHint, _lowerHint, _annualInterestRate, _maxUpfrontFee, _addManager, _removeManager, _receiver);
    }

    function borrowerOperations_openTroveAndJoinInterestBatchManager(IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory _params) public asActor {
        borrowerOperations.openTroveAndJoinInterestBatchManager(_params);
    }

    function borrowerOperations_registerBatchManager(uint128 _minInterestRate, uint128 _maxInterestRate, uint128 _currentInterestRate, uint128 _annualManagementFee, uint128 _minInterestRateChangePeriod) public asActor {
        borrowerOperations.registerBatchManager(_minInterestRate, _maxInterestRate, _currentInterestRate, _annualManagementFee, _minInterestRateChangePeriod);
    }

    function borrowerOperations_removeFromBatch(uint256 _troveId, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public asActor {
        borrowerOperations.removeFromBatch(_troveId, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_removeInterestIndividualDelegate(uint256 _troveId) public asActor {
        borrowerOperations.removeInterestIndividualDelegate(_troveId);
    }

    function borrowerOperations_repayBold(uint256 _troveId, uint256 _boldAmount) public asActor {
        borrowerOperations.repayBold(_troveId, _boldAmount);
    }

    function borrowerOperations_setAddManager(uint256 _troveId, address _manager) public asActor {
        borrowerOperations.setAddManager(_troveId, _manager);
    }

    function borrowerOperations_setBatchManagerAnnualInterestRate(uint128 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public asActor {
        borrowerOperations.setBatchManagerAnnualInterestRate(_newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_setInterestBatchManager(uint256 _troveId, address _newBatchManager, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public asActor {
        borrowerOperations.setInterestBatchManager(_troveId, _newBatchManager, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_setInterestIndividualDelegate(uint256 _troveId, address _delegate, uint128 _minInterestRate, uint128 _maxInterestRate, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee, uint256 _minInterestRateChangePeriod) public asActor {
        borrowerOperations.setInterestIndividualDelegate(_troveId, _delegate, _minInterestRate, _maxInterestRate, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee, _minInterestRateChangePeriod);
    }

    function borrowerOperations_setRemoveManager(uint256 _troveId, address _manager) public asActor {
        borrowerOperations.setRemoveManager(_troveId, _manager);
    }

    function borrowerOperations_setRemoveManagerWithReceiver(uint256 _troveId, address _manager, address _receiver) public asActor {
        borrowerOperations.setRemoveManagerWithReceiver(_troveId, _manager, _receiver);
    }

    function borrowerOperations_switchBatchManager(uint256 _troveId, uint256 _removeUpperHint, uint256 _removeLowerHint, address _newBatchManager, uint256 _addUpperHint, uint256 _addLowerHint, uint256 _maxUpfrontFee) public asActor {
        borrowerOperations.switchBatchManager(_troveId, _removeUpperHint, _removeLowerHint, _newBatchManager, _addUpperHint, _addLowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_withdrawBold(uint256 _troveId, uint256 _boldAmount, uint256 _maxUpfrontFee) public asActor {
        borrowerOperations.withdrawBold(_troveId, _boldAmount, _maxUpfrontFee);
    }

    function borrowerOperations_withdrawColl(uint256 _troveId, uint256 _collWithdrawal) public asActor {
        borrowerOperations.withdrawColl(_troveId, _collWithdrawal);
    }
}