// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

import "src/SortedTroves.sol";

abstract contract SortedTrovesTargets is
    BaseTargetFunctions,
    Properties
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///


    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function sortedTroves_insert(uint256 _id, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) public asActor {
        sortedTroves.insert(_id, _annualInterestRate, _prevId, _nextId);
    }

    function sortedTroves_insertIntoBatch(uint256 _troveId, BatchId _batchId, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) public asActor {
        sortedTroves.insertIntoBatch(_troveId, _batchId, _annualInterestRate, _prevId, _nextId);
    }

    function sortedTroves_reInsert(uint256 _id, uint256 _newAnnualInterestRate, uint256 _prevId, uint256 _nextId) public asActor {
        sortedTroves.reInsert(_id, _newAnnualInterestRate, _prevId, _nextId);
    }

    function sortedTroves_reInsertBatch(BatchId _id, uint256 _newAnnualInterestRate, uint256 _prevId, uint256 _nextId) public asActor {
        sortedTroves.reInsertBatch(_id, _newAnnualInterestRate, _prevId, _nextId);
    }

    function sortedTroves_remove(uint256 _id) public asActor {
        sortedTroves.remove(_id);
    }

    function sortedTroves_removeFromBatch(uint256 _id) public asActor {
        sortedTroves.removeFromBatch(_id);
    }
}