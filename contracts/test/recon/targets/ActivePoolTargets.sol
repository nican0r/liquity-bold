// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

import "src/ActivePool.sol";

abstract contract ActivePoolTargets is
    BaseTargetFunctions,
    Properties
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///


    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function activePool_accountForReceivedColl(uint256 _amount) public asActor {
        activePool.accountForReceivedColl(_amount);
    }

    function activePool_mintAggInterest() public asActor {
        activePool.mintAggInterest();
    }

    function activePool_mintAggInterestAndAccountForTroveChange(TroveChange memory _troveChange, address _batchAddress) public asActor {
        activePool.mintAggInterestAndAccountForTroveChange(_troveChange, _batchAddress);
    }

    function activePool_mintBatchManagementFeeAndAccountForChange(TroveChange memory _troveChange, address _batchAddress) public asActor {
        activePool.mintBatchManagementFeeAndAccountForChange(_troveChange, _batchAddress);
    }

    function activePool_receiveColl(uint256 _amount) public asActor {
        activePool.receiveColl(_amount);
    }

    function activePool_sendColl(address _account, uint256 _amount) public asActor {
        activePool.sendColl(_account, _amount);
    }

    function activePool_sendCollToDefaultPool(uint256 _amount) public asActor {
        activePool.sendCollToDefaultPool(_amount);
    }

    function activePool_setShutdownFlag() public asActor {
        activePool.setShutdownFlag();
    }
}