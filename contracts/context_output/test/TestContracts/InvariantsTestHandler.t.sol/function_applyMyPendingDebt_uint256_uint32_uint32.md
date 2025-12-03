# Function: applyMyPendingDebt(uint256,uint32,uint32)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `applyMyPendingDebt(uint256,uint32,uint32)`
- **Visibility**: external
- **Source Range**: 66849:3012:270

## Implementation

```solidity
function applyMyPendingDebt(uint256 i, uint32 upperHintSeed, uint32 lowerHintSeed) external {
    ApplyMyPendingDebtContext memory v;
    i = _bound(i, 0, branches.length - 1);
    v.upperHint = _pickHint(i, upperHintSeed);
    v.lowerHint = _pickHint(i, lowerHintSeed);
    v.c = branches[i];
    v.pendingInterest = v.c.activePool.calcPendingAggInterest();
    v.troveId = _troveIdOf(i, msg.sender);
    v.batchManager = _batchManagerOf[i][v.troveId];
    v.batchManagementFee = v.c.troveManager.getLatestBatchData(v.batchManager).accruedManagementFee;
    v.t = v.c.troveManager.getLatestTroveData(v.troveId);
    v.trove = _troves[i][v.troveId];
    v.wasOpen = _isOpen(i, v.troveId);
    info("upper hint: ", _hintToString(i, v.upperHint));
    info("lower hint: ", _hintToString(i, v.lowerHint));
    logCall("applyMyPendingDebt", i.toString(), upperHintSeed.toString(), lowerHintSeed.toString());
    try v.c.borrowerOperations.applyPendingDebt(v.troveId, v.lowerHint, v.upperHint) {
        assertTrue(v.wasOpen, "Should have failed as Trove wasn't open");
        assertGtDecimal(v.t.entireDebt, 0, 18, "Should have failed as debt was zero");
        assertFalse(isShutdown[i], "Should have failed as branch had been shut down");
        v.trove.applyPending();
        _troves[i][v.troveId] = v.trove;
        if (v.t.entireDebt >= MIN_DEBT) {
            _zombieTroveIds[i].remove(v.troveId);
            if (designatedVictimId[i] == v.troveId) designatedVictimId[i] = 0;
        }
        if (v.batchManager != address(0)) _touchBatch(i, v.batchManager);
        _mintYield(i, v.pendingInterest, 0);
    } catch (bytes memory revertData) {
        bytes4 selector;
        (selector, v.errorString) = _decodeCustomError(revertData);
        if (selector == BorrowerOperations.TroveNotOpen.selector) {
            assertFalse(v.wasOpen, "Shouldn't have failed as Trove was open");
        } else if (selector == BorrowerOperations.TroveWithZeroDebt.selector) {
            assertEqDecimal(v.t.entireDebt, 0, 18, "Shouldn't have failed as debt was non-zero");
        } else if (selector == BorrowerOperations.IsShutDown.selector) {
            assertTrue(isShutdown[i], "Shouldn't have failed as branch hadn't been shut down");
        } else {
            revert(string.concat("Unexpected error: ", v.errorString));
        }
    }
    if (bytes(v.errorString).length > 0) {
        if (_assumeNoExpectedFailures) vm.assume(false);
        info("Expected error: ", v.errorString);
        _log();
    } else {
        if (v.batchManager != address(0)) _sweepBold(v.batchManager, v.batchManagementFee);
    }
}
```

## Related Implementations

### _bound(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 1646:1263:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_bound(uint256,uint256,uint256)`

```solidity
function _bound(uint256 x, uint256 min, uint256 max) virtual internal pure returns (uint256 result) {
    require(min <= max, "StdUtils bound(uint256,uint256,uint256): Max is less than min.");
    if ((x >= min) && (x <= max)) return x;
    uint256 size = (max - min) + 1;
    if ((x <= 3) && (size > x)) return min + x;
    if ((x >= (UINT256_MAX - 3)) && (size > (UINT256_MAX - x))) return max - (UINT256_MAX - x);
    if (x > max) {
        uint256 diff = x - max;
        uint256 rem = diff % size;
        if (rem == 0) return max;
        result = (min + rem) - 1;
    } else if (x < min) {
        uint256 diff = min - x;
        uint256 rem = diff % size;
        if (rem == 0) return min;
        result = (max - rem) + 1;
    }
}
```

### _pickHint(uint256,uint256)

- **Kind**: internal
- **Source**: 110829:574:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_pickHint(uint256,uint256)`

```solidity
function _pickHint(uint256 i, uint256 seed) internal view returns (uint256) {
    uint256 rem = seed % (2 * (_troveIds[i].size() + 1));
    if (rem == 0) {
        return 0;
    } else if (rem <= _troveIds[i].size()) {
        return _troveIds[i].get(rem - 1);
    } else {
        return uint256(keccak256(abi.encodePacked(seed)));
    }
}
```

### size(struct EnumerableSet)

- **Kind**: internal
- **Source**: 647:153:288
- **Link**: `test/Utils/EnumerableSet.sol:EnumerableSetMethods:size(struct EnumerableSet)`

```solidity
function size(EnumerableSet storage set) internal view returns (uint256) {
    return (set._elements.length >= 1) ? (set._elements.length - 1) : 0;
}
```

### get(struct EnumerableSet,uint256)

- **Kind**: internal
- **Source**: 514:127:288
- **Link**: `test/Utils/EnumerableSet.sol:EnumerableSetMethods:get(struct EnumerableSet,uint256)`

```solidity
function get(EnumerableSet storage set, uint256 i) internal view returns (uint256) {
    return set._elements[i + 1];
}
```

### _troveIdOf(uint256,address)

- **Kind**: internal
- **Source**: 109113:171:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_troveIdOf(uint256,address)`

```solidity
function _troveIdOf(uint256 i, address owner) internal view returns (uint256) {
    return uint256(keccak256(abi.encode(owner, owner, _troveIndexOf[i][owner])));
}
```

### _isOpen(uint256,uint256)

- **Kind**: internal
- **Source**: 110412:123:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_isOpen(uint256,uint256)`

```solidity
function _isOpen(uint256 i, uint256 troveId) internal view returns (bool) {
    return _troveIds[i].has(troveId);
}
```

### has(struct EnumerableSet,uint256)

- **Kind**: internal
- **Source**: 372:136:288
- **Link**: `test/Utils/EnumerableSet.sol:EnumerableSetMethods:has(struct EnumerableSet,uint256)`

```solidity
function has(EnumerableSet storage set, uint256 element) internal view returns (bool) {
    return set._indexOf[element] != 0;
}
```

### info(string,string)

- **Kind**: internal
- **Source**: 2851:96:289
- **Link**: `test/Utils/Logging.sol:Logging:info(string,string)`

```solidity
function info(string memory a, string memory b) internal pure {
    _log("// ", a, b);
}
```

### _hintToString(uint256,uint256)

- **Kind**: internal
- **Source**: 111769:330:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_hintToString(uint256,uint256)`

```solidity
function _hintToString(uint256 i, uint256 troveId) internal view returns (string memory) {
    ITroveManagerTester troveManager = branches[i].troveManager;
    if (_isOpen(i, troveId)) {
        return vm.getLabel(troveManager.ownerOf(troveId));
    } else {
        return troveId.toString();
    }
}
```

### toString(uint256)

- **Kind**: internal
- **Source**: 447:696:96
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Strings.sol:Strings:toString(uint256)`

```solidity
///  @dev Converts a `uint256` to its ASCII `string` decimal representation.
function toString(uint256 value) internal pure returns (string memory) {
    unchecked {
        uint256 length = Math.log10(value) + 1;
        string memory buffer = new string(length);
        uint256 ptr;
        /// @solidity memory-safe-assembly
        assembly {
            ptr := add(buffer, add(32, length))
        }
        while (true) {
            ptr--;
            /// @solidity memory-safe-assembly
            assembly {
                mstore8(ptr, byte(mod(value, 10), _SYMBOLS))
            }
            value /= 10;
            if (value == 0) break;
        }
        return buffer;
    }
}
```

### log10(uint256)

- **Kind**: internal
- **Source**: 10139:916:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:log10(uint256)`

```solidity
///  @dev Return the log in base 10, rounded down, of a positive value.
///  Returns 0 if given 0.
function log10(uint256 value) internal pure returns (uint256) {
    uint256 result = 0;
    unchecked {
        if (value >= (10 ** 64)) {
            value /= 10 ** 64;
            result += 64;
        }
        if (value >= (10 ** 32)) {
            value /= 10 ** 32;
            result += 32;
        }
        if (value >= (10 ** 16)) {
            value /= 10 ** 16;
            result += 16;
        }
        if (value >= (10 ** 8)) {
            value /= 10 ** 8;
            result += 8;
        }
        if (value >= (10 ** 4)) {
            value /= 10 ** 4;
            result += 4;
        }
        if (value >= (10 ** 2)) {
            value /= 10 ** 2;
            result += 2;
        }
        if (value >= (10 ** 1)) {
            result += 1;
        }
    }
    return result;
}
```

### _log(string,string,string)

- **Kind**: internal
- **Source**: 406:131:289
- **Link**: `test/Utils/Logging.sol:Logging:_log(string,string,string)`

```solidity
function _log(string memory a, string memory b, string memory c) internal pure {
    console.log(string.concat(a, b, c));
}
```

### log(string)

- **Kind**: internal
- **Source**: 6191:121:61
- **Link**: `lib/forge-std/src/console.sol:console:log(string)`

```solidity
function log(string memory p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
}
```

### _sendLogPayload(bytes)

- **Kind**: internal
- **Source**: 9648:133:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_sendLogPayload(bytes)`

```solidity
function _sendLogPayload(bytes memory payload) internal pure {
    _castLogPayloadViewToPure(_sendLogPayloadView)(payload);
}
```

### _castLogPayloadViewToPure(function (bytes)

- **Kind**: internal
- **Source**: 9407:235:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_castLogPayloadViewToPure(function (bytes) view)`

```solidity
function _castLogPayloadViewToPure(function(bytes memory) internal view fnIn) internal pure returns (function(bytes memory) internal pure fnOut) {
    assembly {
        fnOut := fnIn
    }
}
```

### logCall(string,string,string,string)

- **Kind**: internal
- **Source**: 989:226:251
- **Link**: `test/TestContracts/BaseHandler.sol:BaseHandler:logCall(string,string,string,string)`

```solidity
function logCall(string memory functionName, string memory a, string memory b, string memory c) internal view {
    _logCaller();
    _log(_callPrefix(), functionName, "(", _csv([a, b, c]), ");");
    _log();
}
```

### _logCaller()

- **Kind**: internal
- **Source**: 189:101:251
- **Link**: `test/TestContracts/BaseHandler.sol:BaseHandler:_logCaller()`

```solidity
function _logCaller() internal view {
    _log("vm.prank(", vm.getLabel(msg.sender), ");");
}
```

### _log(string,string,string,string,string)

- **Kind**: internal
- **Source**: 700:171:289
- **Link**: `test/Utils/Logging.sol:Logging:_log(string,string,string,string,string)`

```solidity
function _log(string memory a, string memory b, string memory c, string memory d, string memory e) internal pure {
    console.log(string.concat(a, b, c, d, e));
}
```

### _callPrefix()

- **Kind**: internal
- **Source**: 296:131:251
- **Link**: `test/TestContracts/BaseHandler.sol:BaseHandler:_callPrefix()`

```solidity
function _callPrefix() internal view returns (string memory) {
    return string.concat(vm.getLabel(address(this)), ".");
}
```

### _csv(string[3])

- **Kind**: internal
- **Source**: 3723:151:289
- **Link**: `test/Utils/Logging.sol:Logging:_csv(string[3])`

```solidity
function _csv(string[3] memory strs) internal pure returns (string memory) {
    return string.concat(strs[0], ", ", strs[1], ", ", strs[2]);
}
```

### _log()

- **Kind**: internal
- **Source**: 141:60:289
- **Link**: `test/Utils/Logging.sol:Logging:_log()`

```solidity
function _log() internal pure {
    console.log();
}
```

### log()

- **Kind**: internal
- **Source**: 986:95:61
- **Link**: `lib/forge-std/src/console.sol:console:log()`

```solidity
function log() internal pure {
    _sendLogPayload(abi.encodeWithSignature("log()"));
}
```

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1689:113:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    vm.assertTrue(data, err);
}
```

### assertGtDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 13526:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGtDecimal(uint256,uint256,uint256,string)`

```solidity
function assertGtDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertGtDecimal(left, right, decimals, err);
}
```

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 1905:115:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    vm.assertFalse(data, err);
}
```

### applyPending(struct Trove)

- **Kind**: internal
- **Source**: 2366:185:293
- **Link**: `test/Utils/Trove.sol:TroveMethods:applyPending(struct Trove)`

```solidity
function applyPending(Trove memory trove) internal pure {
    trove.applyPendingRedist();
    trove.applyPendingInterest();
    trove.applyPendingBatchManagementFee();
}
```

### applyPendingRedist(struct Trove)

- **Kind**: internal
- **Source**: 1585:361:293
- **Link**: `test/Utils/Trove.sol:TroveMethods:applyPendingRedist(struct Trove)`

```solidity
function applyPendingRedist(Trove memory trove) internal pure {
    trove.coll += trove._pendingCollRedist;
    trove.debt += trove._pendingDebtRedist;
    trove.totalCollRedist += trove._pendingCollRedist;
    trove.totalDebtRedist += trove._pendingDebtRedist;
    trove._pendingCollRedist = 0;
    trove._pendingDebtRedist = 0;
}
```

### applyPendingInterest(struct Trove)

- **Kind**: internal
- **Source**: 1952:186:293
- **Link**: `test/Utils/Trove.sol:TroveMethods:applyPendingInterest(struct Trove)`

```solidity
function applyPendingInterest(Trove memory trove) internal pure {
    trove.debt += trove._pendingInterest / (ONE_YEAR * DECIMAL_PRECISION);
    trove._pendingInterest = 0;
}
```

### applyPendingBatchManagementFee(struct Trove)

- **Kind**: internal
- **Source**: 2144:216:293
- **Link**: `test/Utils/Trove.sol:TroveMethods:applyPendingBatchManagementFee(struct Trove)`

```solidity
function applyPendingBatchManagementFee(Trove memory trove) internal pure {
    trove.debt += trove._pendingBatchManagementFee / (ONE_YEAR * DECIMAL_PRECISION);
    trove._pendingBatchManagementFee = 0;
}
```

### remove(struct EnumerableSet,uint256)

- **Kind**: internal
- **Source**: 1527:438:288
- **Link**: `test/Utils/EnumerableSet.sol:EnumerableSetMethods:remove(struct EnumerableSet,uint256)`

```solidity
function remove(EnumerableSet storage set, uint256 element) internal {
    if (!set.has(element)) return;
    uint256 lastElement = set._elements[set._elements.length - 1];
    uint256 indexOfRemovedElement = set._indexOf[element];
    set._indexOf[lastElement] = indexOfRemovedElement;
    set._elements[indexOfRemovedElement] = lastElement;
    set._elements.pop();
    delete set._indexOf[element];
}
```

### _touchBatch(uint256,address)

- **Kind**: internal
- **Source**: 113349:481:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_touchBatch(uint256,address)`

```solidity
function _touchBatch(uint256 i, address batchManager) internal {
    for (uint256 j = 0; j < _batches[i][batchManager].troves.size(); ++j) {
        uint256 troveId = _batches[i][batchManager].troves.get(j);
        Trove memory trove = _troves[i][troveId];
        trove.applyPendingInterest();
        trove.applyPendingBatchManagementFee();
        _troves[i][troveId] = trove;
    }
    _batches[i][batchManager].pendingManagementFee = 0;
}
```

### _mintYield(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 112705:317:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_mintYield(uint256,uint256,uint256)`

```solidity
function _mintYield(uint256 i, uint256 pendingInterest, uint256 upfrontFee) internal {
    uint256 mintedYield = pendingInterest + upfrontFee;
    uint256 mintedSPBoldYield = (mintedYield * SP_YIELD_SPLIT) / DECIMAL_PRECISION;
    spBoldYield[i] += mintedSPBoldYield;
    _pendingInterest[i] = 0;
}
```

### _decodeCustomError(bytes)

- **Kind**: internal
- **Source**: 128655:7970:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_decodeCustomError(bytes)`

```solidity
function _decodeCustomError(bytes memory revertData) public pure returns (bytes4 selector, string memory errorString) {
    selector = bytes4(revertData);
    if (revertData.length == 4) {
        if (selector == AddRemoveManagers.NotBorrower.selector) {
            return (selector, "AddRemoveManagers.NotBorrower()");
        }
        if (selector == AddRemoveManagers.NotOwnerNorAddManager.selector) {
            return (selector, "AddRemoveManagers.NotOwnerNorAddManager()");
        }
        if (selector == AddRemoveManagers.NotOwnerNorRemoveManager.selector) {
            return (selector, "AddRemoveManagers.NotOwnerNorRemoveManager()");
        }
        if (selector == AddressesRegistry.InvalidMCR.selector) {
            return (selector, "BorrowerOperations.InvalidMCR()");
        }
        if (selector == AddressesRegistry.InvalidSCR.selector) {
            return (selector, "BorrowerOperations.InvalidSCR()");
        }
        if (selector == BorrowerOperations.IsShutDown.selector) {
            return (selector, "BorrowerOperations.IsShutDown()");
        }
        if (selector == BorrowerOperations.TCRNotBelowSCR.selector) {
            return (selector, "BorrowerOperations.TCRNotBelowSCR()");
        }
        if (selector == BorrowerOperations.ZeroAdjustment.selector) {
            return (selector, "BorrowerOperations.ZeroAdjustment()");
        }
        if (selector == BorrowerOperations.NotOwnerNorInterestManager.selector) {
            return (selector, "BorrowerOperations.NotOwnerNorInterestManager()");
        }
        if (selector == BorrowerOperations.TroveInBatch.selector) {
            return (selector, "BorrowerOperations.TroveInBatch()");
        }
        if (selector == BorrowerOperations.TroveNotInBatch.selector) {
            return (selector, "BorrowerOperations.TroveNotInBatch()");
        }
        if (selector == BorrowerOperations.InterestNotInRange.selector) {
            return (selector, "BorrowerOperations.InterestNotInRange()");
        }
        if (selector == BorrowerOperations.BatchInterestRateChangePeriodNotPassed.selector) {
            return (selector, "BorrowerOperations.BatchInterestRateChangePeriodNotPassed()");
        }
        if (selector == BorrowerOperations.TroveExists.selector) {
            return (selector, "BorrowerOperations.TroveExists()");
        }
        if (selector == BorrowerOperations.TroveNotOpen.selector) {
            return (selector, "BorrowerOperations.TroveNotOpen()");
        }
        if (selector == BorrowerOperations.TroveNotActive.selector) {
            return (selector, "BorrowerOperations.TroveNotActive()");
        }
        if (selector == BorrowerOperations.TroveNotZombie.selector) {
            return (selector, "BorrowerOperations.TroveNotZombie()");
        }
        if (selector == BorrowerOperations.TroveWithZeroDebt.selector) {
            return (selector, "BorrowerOperations.TroveWithZeroDebt()");
        }
        if (selector == BorrowerOperations.UpfrontFeeTooHigh.selector) {
            return (selector, "BorrowerOperations.UpfrontFeeTooHigh()");
        }
        if (selector == BorrowerOperations.ICRBelowMCR.selector) {
            return (selector, "BorrowerOperations.ICRBelowMCR()");
        }
        if (selector == BorrowerOperations.ICRBelowMCRPlusBCR.selector) {
            return (selector, "BorrowerOperations.ICRBelowMCRPlusBCR()");
        }
        if (selector == BorrowerOperations.RepaymentNotMatchingCollWithdrawal.selector) {
            return (selector, "BorrowerOperations.RepaymentNotMatchingCollWithdrawal()");
        }
        if (selector == BorrowerOperations.TCRBelowCCR.selector) {
            return (selector, "BorrowerOperations.TCRBelowCCR()");
        }
        if (selector == BorrowerOperations.DebtBelowMin.selector) {
            return (selector, "BorrowerOperations.DebtBelowMin()");
        }
        if (selector == BorrowerOperations.CollWithdrawalTooHigh.selector) {
            return (selector, "BorrowerOperations.CollWithdrawalTooHigh()");
        }
        if (selector == BorrowerOperations.NotEnoughBoldBalance.selector) {
            return (selector, "BorrowerOperations.NotEnoughBoldBalance()");
        }
        if (selector == BorrowerOperations.InterestRateNotNew.selector) {
            return (selector, "BorrowerOperations.InterestRateNotNew");
        }
        if (selector == BorrowerOperations.InterestRateTooLow.selector) {
            return (selector, "BorrowerOperations.InterestRateTooLow()");
        }
        if (selector == BorrowerOperations.InterestRateTooHigh.selector) {
            return (selector, "BorrowerOperations.InterestRateTooHigh()");
        }
        if (selector == BorrowerOperations.InvalidInterestBatchManager.selector) {
            return (selector, "BorrowerOperations.InvalidInterestBatchManager()");
        }
        if (selector == BorrowerOperations.BatchManagerExists.selector) {
            return (selector, "BorrowerOperations.BatchManagerExists()");
        }
        if (selector == BorrowerOperations.BatchManagerNotNew.selector) {
            return (selector, "BorrowerOperations.BatchManagerNotNew()");
        }
        if (selector == BorrowerOperations.NewFeeNotLower.selector) {
            return (selector, "BorrowerOperations.NewFeeNotLower()");
        }
        if (selector == BorrowerOperations.CallerNotPriceFeed.selector) {
            return (selector, "BorrowerOperations.CallerNotPriceFeed()");
        }
        if (selector == BorrowerOperations.MinGeMax.selector) {
            return (selector, "BorrowerOperations.MinGeMax()");
        }
        if (selector == BorrowerOperations.AnnualManagementFeeTooHigh.selector) {
            return (selector, "BorrowerOperations.AnnualManagementFeeTooHigh()");
        }
        if (selector == BorrowerOperations.MinInterestRateChangePeriodTooLow.selector) {
            return (selector, "BorrowerOperations.MinInterestRateChangePeriodTooLow()");
        }
        if (selector == TroveManager.EmptyData.selector) {
            return (selector, "TroveManager.EmptyData()");
        }
        if (selector == TroveManager.NothingToLiquidate.selector) {
            return (selector, "TroveManager.NothingToLiquidate()");
        }
        if (selector == TroveManager.CallerNotBorrowerOperations.selector) {
            return (selector, "TroveManager.CallerNotBorrowerOperations()");
        }
        if (selector == TroveManager.CallerNotCollateralRegistry.selector) {
            return (selector, "TroveManager.CallerNotCollateralRegistry()");
        }
        if (selector == TroveManager.OnlyOneTroveLeft.selector) {
            return (selector, "TroveManager.OnlyOneTroveLeft()");
        }
        if (selector == TroveManager.NotShutDown.selector) {
            return (selector, "TroveManager.NotShutDown()");
        }
        if (selector == TroveManager.ZeroAmount.selector) {
            return (selector, "TroveManager.ZeroAmount()");
        }
    }
    if (revertData.length == (4 + 32)) {
        bytes32 param = bytes32(revertData.slice(4));
        if (selector == TroveManager.MinCollNotReached.selector) {
            return (selector, string.concat("TroveManager.MinCollNotReached(", uint256(param).decimal(), ")"));
        }
    }
    _revert(revertData);
}
```

### slice(bytes,int256)

- **Kind**: internal
- **Source**: 3083:144:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:slice(bytes,int256)`

```solidity
function slice(bytes memory str, int256 start) internal pure returns (bytes memory) {
    return str.slice(start, int256(str.length));
}
```

### slice(bytes,int256,int256)

- **Kind**: internal
- **Source**: 3277:472:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:slice(bytes,int256,int256)`

```solidity
function slice(bytes memory str, int256 start, int256 end) internal pure returns (bytes memory ret) {
    uint256 uStart = uint256((start < 0) ? (int256(str.length) + start) : start);
    uint256 uEnd = uint256((end < 0) ? (int256(str.length) + end) : end);
    assert(((0 <= uStart) && (uStart <= uEnd)) && (uEnd <= str.length));
    ret = new bytes(uEnd - uStart);
    for (uint256 i = uStart; i < uEnd; ++i) {
        ret[i - uStart] = str[i];
    }
}
```

### decimal(uint256)

- **Kind**: internal
- **Source**: 1342:608:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:decimal(uint256)`

```solidity
function decimal(uint256 n) internal pure returns (string memory) {
    if (n == type(uint256).max) {
        return "type(uint256).max";
    }
    uint256 integerPart = n / ONE;
    uint256 fractionalPart = n % ONE;
    if (fractionalPart == 0) {
        return string.concat(integerPart.groupRight(), DECIMAL_UNIT);
    } else {
        return string.concat(integerPart.groupRight(), DECIMAL_SEPARATOR, (ONE + fractionalPart).toString().slice(1).trimEnd("0"), DECIMAL_UNIT);
    }
}
```

### groupRight(uint256)

- **Kind**: internal
- **Source**: 1956:118:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:groupRight(uint256)`

```solidity
function groupRight(uint256 n) internal pure returns (string memory) {
    return n.toString().groupRight();
}
```

### groupRight(string)

- **Kind**: internal
- **Source**: 2080:135:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:groupRight(string)`

```solidity
function groupRight(string memory str) internal pure returns (string memory) {
    return bytes(str).groupRight().toString();
}
```

### groupRight(bytes)

- **Kind**: internal
- **Source**: 2221:539:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:groupRight(bytes)`

```solidity
function groupRight(bytes memory str) internal pure returns (bytes memory ret) {
    uint256 length = str.length;
    if (length == 0) return "";
    uint256 retLength = length + ((length - 1) / GROUP_DIGITS);
    ret = new bytes(retLength);
    uint256 j = 1;
    for (uint256 i = 1; i <= retLength; ++i) {
        if ((i % (GROUP_DIGITS + 1)) == 0) {
            ret[retLength - i] = GROUP_SEPARATOR;
        } else {
            ret[retLength - i] = str[length - (j++)];
        }
    }
}
```

### toString(bytes)

- **Kind**: internal
- **Source**: 718:109:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:toString(bytes)`

```solidity
function toString(bytes memory str) internal pure returns (string memory) {
    return string(str);
}
```

### slice(string,int256)

- **Kind**: internal
- **Source**: 2766:144:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:slice(string,int256)`

```solidity
function slice(string memory str, int256 start) internal pure returns (string memory) {
    return bytes(str).slice(start).toString();
}
```

### trimEnd(string,bytes1)

- **Kind**: internal
- **Source**: 3755:146:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:trimEnd(string,bytes1)`

```solidity
function trimEnd(string memory str, bytes1 char) internal pure returns (string memory) {
    return bytes(str).trimEnd(char).toString();
}
```

### trimEnd(bytes,bytes1)

- **Kind**: internal
- **Source**: 3907:229:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:trimEnd(bytes,bytes1)`

```solidity
function trimEnd(bytes memory str, bytes1 char) internal pure returns (bytes memory) {
    uint256 end;
    for (end = str.length; (end > 0) && (str[end - 1] == char); --end) {}
    return str.slice(0, int256(end));
}
```

### _revert(bytes)

- **Kind**: internal
- **Source**: 128373:276:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_revert(bytes)`

```solidity
function _revert(bytes memory revertData) internal pure {
    assembly {
        revert(add(32, revertData), mload(revertData))
    }
}
```

### assertEqDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 2684:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEqDecimal(uint256,uint256,uint256,string)`

```solidity
function assertEqDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertEqDecimal(left, right, decimals, err);
}
```

### _sweepBold(address,uint256)

- **Kind**: internal
- **Source**: 115632:173:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_sweepBold(address,uint256)`

```solidity
function _sweepBold(address from, uint256 amount) internal {
    vm.prank(from);
    boldToken.transfer(address(this), amount);
    _handlerBold += amount;
}
```

## External Calls

- **IActivePool::calcPendingAggInterest()**
- **ITroveManagerTester::getLatestBatchData(address)**
- **ITroveManagerTester::getLatestTroveData(uint256)**
- **IBorrowerOperationsTester::applyPendingDebt(uint256,uint256,uint256)**
- **Vm::assume(bool)**

## State Variable Reads

- **_batchManagerOf** (`mapping(uint256 => mapping(uint256 => address))`)
- **_troves** (`mapping(uint256 => mapping(uint256 => struct Trove))`)
- **isShutdown** (`mapping(uint256 => bool)`)
- **designatedVictimId** (`mapping(uint256 => uint256)`)
- **_assumeNoExpectedFailures** (`bool`)
- **UINT256_MAX** (`uint256`)
- **_troveIds** (`mapping(uint256 => struct EnumerableSet)`)
- **_troveIndexOf** (`mapping(uint256 => mapping(address => uint256))`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **_batches** (`mapping(uint256 => mapping(address => struct InvariantsTestHandler.Batch))`)
- **ONE** (`uint256`)
- **DECIMAL_UNIT** (`string`)
- **DECIMAL_SEPARATOR** (`string`)
- **GROUP_DIGITS** (`uint256`)
- **GROUP_SEPARATOR** (`bytes1`)

## State Variable Writes

- **_troves** (`mapping(uint256 => mapping(uint256 => struct Trove))`)
- **_zombieTroveIds** (`mapping(uint256 => struct EnumerableSet)`)
- **designatedVictimId** (`mapping(uint256 => uint256)`)
- **_batches** (`mapping(uint256 => mapping(address => struct InvariantsTestHandler.Batch))`)
- **spBoldYield** (`mapping(uint256 => uint256)`)
- **_pendingInterest** (`mapping(uint256 => uint256)`)
- **_handlerBold** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.applyMyPendingDebt(uint256,uint32,uint32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [i, 0, branches.length - 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._pickHint(uint256,uint256) (NodeID: 2)
  │   💬 Args: [i, upperHintSeed]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 3)
  │ │   💬 Args: [_troveIds[i]]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 4)
  │ │   💬 Args: [_troveIds[i]]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 5)
  │     💬 Args: [_troveIds[i], rem - 1]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._pickHint(uint256,uint256) (NodeID: 6)
  │   💬 Args: [i, lowerHintSeed]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 7)
  │ │   💬 Args: [_troveIds[i]]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 8)
  │ │   💬 Args: [_troveIds[i]]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 9)
  │     💬 Args: [_troveIds[i], rem - 1]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._troveIdOf(uint256,address) (NodeID: 10)
  │   💬 Args: [i, msg.sender]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._isOpen(uint256,uint256) (NodeID: 11)
  │   💬 Args: [i, v.troveId]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 12)
  │     💬 Args: [_troveIds[i], troveId]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 13)
  │   💬 Args: ["upper hint: ", _hintToString(i, v.upperHint)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._hintToString(uint256,uint256) (NodeID: 18)
  │ │   💬 Args: [i, v.upperHint]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: InvariantsTestHandler._isOpen(uint256,uint256) (NodeID: 19)
  │ │ │   💬 Args: [i, troveId]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 20)
  │ │ │     💬 Args: [_troveIds[i], troveId]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 21)
  │ │     💬 Args: [troveId]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 22)
  │ │       💬 Args: [value]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 14)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 15)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 16)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 17)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 23)
  │   💬 Args: ["lower hint: ", _hintToString(i, v.lowerHint)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._hintToString(uint256,uint256) (NodeID: 28)
  │ │   💬 Args: [i, v.lowerHint]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: InvariantsTestHandler._isOpen(uint256,uint256) (NodeID: 29)
  │ │ │   💬 Args: [i, troveId]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 30)
  │ │ │     💬 Args: [_troveIds[i], troveId]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 31)
  │ │     💬 Args: [troveId]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 32)
  │ │       💬 Args: [value]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 24)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 25)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 26)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 27)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseHandler.logCall(string,string,string,string) (NodeID: 33)
  │   💬 Args: ["applyMyPendingDebt", i.toString(), upperHintSeed.toString(), lowerHintSeed.toString()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 49)
  │ │   💬 Args: [i]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 50)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 51)
  │ │   💬 Args: [upperHintSeed]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 52)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 53)
  │ │   💬 Args: [lowerHintSeed]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 54)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseHandler._logCaller() (NodeID: 34)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 35)
  │ │     💬 Args: ["vm.prank(", vm.getLabel(msg.sender), ");"]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 36)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 37)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 38)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging._log(string,string,string,string,string) (NodeID: 39)
  │ │   💬 Args: [_callPrefix(), functionName, "(", _csv([a, b, c]), ");"]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseHandler._callPrefix() (NodeID: 43)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Logging._csv(string[3]) (NodeID: 44)
  │ │ │   💬 Args: [[a, b, c]]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 40)
  │ │     💬 Args: [string.concat(a, b, c, d, e)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 41)
  │ │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 42)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log() (NodeID: 45)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log() (NodeID: 46)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 47)
  │         💬 Args: [abi.encodeWithSignature("log()")]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 48)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 55)
  │   💬 Args: [v.wasOpen, "Should have failed as Trove wasn't open"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGtDecimal(uint256,uint256,uint256,string) (NodeID: 56)
  │   💬 Args: [v.t.entireDebt, 0, 18, "Should have failed as debt was zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 57)
  │   💬 Args: [isShutdown[i], "Should have failed as branch had been shut down"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveMethods.applyPending(struct Trove) (NodeID: 58)
  │   💬 Args: [v.trove]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingRedist(struct Trove) (NodeID: 59)
  │ │   💬 Args: [trove]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingInterest(struct Trove) (NodeID: 60)
  │ │   💬 Args: [trove]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingBatchManagementFee(struct Trove) (NodeID: 61)
  │     💬 Args: [trove]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSetMethods.remove(struct EnumerableSet,uint256) (NodeID: 62)
  │   💬 Args: [_zombieTroveIds[i], v.troveId]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 63)
  │     💬 Args: [set, element]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._touchBatch(uint256,address) (NodeID: 64)
  │   💬 Args: [i, v.batchManager]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 65)
  │ │   💬 Args: [_batches[i][batchManager].troves]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 66)
  │ │   💬 Args: [_batches[i][batchManager].troves, j]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingInterest(struct Trove) (NodeID: 67)
  │ │   💬 Args: [trove]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingBatchManagementFee(struct Trove) (NodeID: 68)
  │     💬 Args: [trove]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._mintYield(uint256,uint256,uint256) (NodeID: 69)
  │   💬 Args: [i, v.pendingInterest, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._decodeCustomError(bytes) (NodeID: 70)
  │   💬 Args: [revertData]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 71)
  │ │   💬 Args: [revertData, 4]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 72)
  │ │     💬 Args: [str, start, int256(str.length)]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 73)
  │ │   💬 Args: [uint256(param)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 74)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 75)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 76)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 77)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 78)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 79)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 80)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 81)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 82)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 83)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 84)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 85)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 86)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 87)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 88)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 89)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 90)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 91)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 92)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 93)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 94)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 95)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._revert(bytes) (NodeID: 96)
  │     💬 Args: [revertData]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 97)
  │   💬 Args: [v.wasOpen, "Shouldn't have failed as Trove was open"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 98)
  │   💬 Args: [v.t.entireDebt, 0, 18, "Shouldn't have failed as debt was non-zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 99)
  │   💬 Args: [isShutdown[i], "Shouldn't have failed as branch hadn't been shut down"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 100)
  │   💬 Args: ["Expected error: ", v.errorString]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 101)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 102)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 103)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 104)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging._log() (NodeID: 105)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log() (NodeID: 106)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 107)
  │       💬 Args: [abi.encodeWithSignature("log()")]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 108)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepBold(address,uint256) (NodeID: 109)
      💬 Args: [v.batchManager, v.batchManagementFee]
      👁️  Def: internal
```
