# Function: closeTrove(uint256)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `closeTrove(uint256)`
- **Visibility**: external
- **Source Range**: 44248:3827:270

## Implementation

```solidity
function closeTrove(uint256 i) external {
    CloseTroveContext memory v;
    i = _bound(i, 0, branches.length - 1);
    v.c = branches[i];
    v.pendingInterest = v.c.activePool.calcPendingAggInterest();
    v.troveId = _troveIdOf(i, msg.sender);
    v.t = v.c.troveManager.getLatestTroveData(v.troveId);
    v.batchManager = _batchManagerOf[i][v.troveId];
    v.batchManagementFee = v.c.troveManager.getLatestBatchData(v.batchManager).accruedManagementFee;
    v.wasOpen = _isOpen(i, v.troveId);
    logCall("closeTrove", i.toString());
    v.dealt = Math.min(v.t.entireDebt, _handlerBold);
    _dealBold(msg.sender, v.dealt);
    vm.prank(msg.sender);
    try v.c.borrowerOperations.closeTrove(v.troveId) {
        uint256 newTCR = _TCR(i);
        assertTrue(v.wasOpen, "Should have failed as Trove wasn't open");
        if (!isShutdown[i]) assertGt(numTroves(i), 1, "Should have failed to close last Trove in the system");
        if (!isShutdown[i]) assertGeDecimal(newTCR, CCR[i], 18, "Should have failed as new TCR < CCR");
        delete _troves[i][v.troveId];
        delete _batchManagerOf[i][v.troveId];
        delete _timeSinceLastTroveInterestRateAdjustment[i][v.troveId];
        ++_troveIndexOf[i][msg.sender];
        _troveIds[i].remove(v.troveId);
        _zombieTroveIds[i].remove(v.troveId);
        if (designatedVictimId[i] == v.troveId) designatedVictimId[i] = 0;
        if (v.batchManager != address(0)) {
            _batches[i][v.batchManager].troves.remove(v.troveId);
            _touchBatch(i, v.batchManager);
        }
        _mintYield(i, v.pendingInterest, 0);
    } catch Error(string memory reason) {
        v.errorString = reason;
        if (reason.equals("ERC721: invalid token ID")) {
            assertFalse(v.wasOpen, "Open Trove should have an NFT");
        } else {
            revert(reason);
        }
    } catch (bytes memory revertData) {
        bytes4 selector;
        (selector, v.errorString) = _decodeCustomError(revertData);
        if (selector == BorrowerOperations.NotEnoughBoldBalance.selector) {
            assertLtDecimal(v.dealt, v.t.entireDebt, 18, "Shouldn't have failed as caller had enough Bold");
        } else if (selector == BorrowerOperations.TCRBelowCCR.selector) {
            uint256 newTCR = _TCR(i, -int256(v.t.entireColl), -int256(v.t.entireDebt), 0);
            assertFalse(isShutdown[i], "Shouldn't have failed as branch had been shut down");
            assertLtDecimal(newTCR, CCR[i], 18, "Shouldn't have failed as new TCR >= CCR");
            info("New TCR would have been: ", newTCR.decimal());
        } else if (selector == TroveManager.OnlyOneTroveLeft.selector) {
            assertEq(numTroves(i), 1, "Shouldn't have failed as there was at least one Trove left in the system");
        } else {
            revert(string.concat("Unexpected error: ", v.errorString));
        }
    }
    if (bytes(v.errorString).length > 0) {
        if (_assumeNoExpectedFailures) vm.assume(false);
        info("Expected error: ", v.errorString);
        _log();
        _sweepBold(msg.sender, v.dealt);
    } else {
        _sweepColl(i, msg.sender, v.t.entireColl);
        _sweepWETH(msg.sender, ETH_GAS_COMPENSATION);
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

### logCall(string,string)

- **Kind**: internal
- **Source**: 593:178:251
- **Link**: `test/TestContracts/BaseHandler.sol:BaseHandler:logCall(string,string)`

```solidity
function logCall(string memory functionName, string memory a) internal view {
    _logCaller();
    _log(_callPrefix(), functionName, "(", a, ");");
    _log();
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

### _logCaller()

- **Kind**: internal
- **Source**: 189:101:251
- **Link**: `test/TestContracts/BaseHandler.sol:BaseHandler:_logCaller()`

```solidity
function _logCaller() internal view {
    _log("vm.prank(", vm.getLabel(msg.sender), ");");
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

### min(uint256,uint256)

- **Kind**: internal
- **Source**: 588:104:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:min(uint256,uint256)`

```solidity
///  @dev Returns the smallest of two numbers.
function min(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a < b) ? a : b;
}
```

### _dealBold(address,uint256)

- **Kind**: internal
- **Source**: 115491:135:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_dealBold(address,uint256)`

```solidity
function _dealBold(address to, uint256 amount) internal {
    boldToken.transfer(to, amount);
    _handlerBold -= amount;
}
```

### _TCR(uint256)

- **Kind**: internal
- **Source**: 108521:97:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_TCR(uint256)`

```solidity
function _TCR(uint256 i) internal view returns (uint256) {
    return _TCR(i, 0, 0, 0);
}
```

### _TCR(uint256,int256,int256,uint256)

- **Kind**: internal
- **Source**: 108624:341:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_TCR(uint256,int256,int256,uint256)`

```solidity
function _TCR(uint256 i, int256 collDelta, int256 debtDelta, uint256 upfrontFee) internal view returns (uint256) {
    uint256 coll = branches[i].troveManager.getEntireBranchColl().add(collDelta);
    uint256 debt = branches[i].troveManager.getEntireBranchDebt().add(debtDelta) + upfrontFee;
    return _CR(i, coll, debt);
}
```

### add(uint256,int256)

- **Kind**: free-function
- **Source**: 3111:103:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:add(uint256,int256)`

```solidity
function add(uint256 x, int256 delta) pure returns (uint256) {
    return uint256(int256(x) + delta);
}
```

### _CR(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 107456:162:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_CR(uint256,uint256,uint256)`

```solidity
function _CR(uint256 i, uint256 coll, uint256 debt) internal view returns (uint256) {
    return (debt > 0) ? ((coll * _price[i]) / debt) : type(uint256).max;
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

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 13228:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertGt(left, right, err);
}
```

### numTroves(uint256)

- **Kind**: internal
- **Source**: 13995:103:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:numTroves(uint256)`

```solidity
function numTroves(uint256 i) public view returns (uint256) {
    return _troveIds[i].size();
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

### assertGeDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 15894:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGeDecimal(uint256,uint256,uint256,string)`

```solidity
function assertGeDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertGeDecimal(left, right, decimals, err);
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

### get(struct EnumerableSet,uint256)

- **Kind**: internal
- **Source**: 514:127:288
- **Link**: `test/Utils/EnumerableSet.sol:EnumerableSetMethods:get(struct EnumerableSet,uint256)`

```solidity
function get(EnumerableSet storage set, uint256 i) internal view returns (uint256) {
    return set._elements[i + 1];
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

### equals(string,string)

- **Kind**: internal
- **Source**: 567:145:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:equals(string,string)`

```solidity
function equals(string memory a, string memory b) internal pure returns (bool) {
    return keccak256(bytes(a)) == keccak256(bytes(b));
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

### assertLtDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 12342:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLtDecimal(uint256,uint256,uint256,string)`

```solidity
function assertLtDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertLtDecimal(left, right, decimals, err);
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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
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

### _sweepColl(uint256,address,uint256)

- **Kind**: internal
- **Source**: 114977:164:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_sweepColl(uint256,address,uint256)`

```solidity
function _sweepColl(uint256 i, address from, uint256 amount) internal {
    vm.prank(from);
    branches[i].collToken.transfer(address(this), amount);
}
```

### _sweepWETH(address,uint256)

- **Kind**: internal
- **Source**: 114565:136:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_sweepWETH(address,uint256)`

```solidity
function _sweepWETH(address from, uint256 amount) internal {
    vm.prank(from);
    weth.transfer(address(this), amount);
}
```

## External Calls

- **IActivePool::calcPendingAggInterest()**
- **ITroveManagerTester::getLatestTroveData(uint256)**
- **ITroveManagerTester::getLatestBatchData(address)**
- **Vm::prank(address)**
- **IBorrowerOperationsTester::closeTrove(uint256)**
- **Vm::assume(bool)**

## State Variable Reads

- **_batchManagerOf** (`mapping(uint256 => mapping(uint256 => address))`)
- **_handlerBold** (`uint256`)
- **isShutdown** (`mapping(uint256 => bool)`)
- **CCR** (`mapping(uint256 => uint256)`)
- **designatedVictimId** (`mapping(uint256 => uint256)`)
- **_assumeNoExpectedFailures** (`bool`)
- **UINT256_MAX** (`uint256`)
- **_troveIndexOf** (`mapping(uint256 => mapping(address => uint256))`)
- **_troveIds** (`mapping(uint256 => struct EnumerableSet)`)
- **_price** (`mapping(uint256 => uint256)`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **_batches** (`mapping(uint256 => mapping(address => struct InvariantsTestHandler.Batch))`)
- **_troves** (`mapping(uint256 => mapping(uint256 => struct Trove))`)
- **ONE** (`uint256`)
- **DECIMAL_UNIT** (`string`)
- **DECIMAL_SEPARATOR** (`string`)
- **GROUP_DIGITS** (`uint256`)
- **GROUP_SEPARATOR** (`bytes1`)

## State Variable Writes

- **_troves** (`mapping(uint256 => mapping(uint256 => struct Trove))`)
- **_batchManagerOf** (`mapping(uint256 => mapping(uint256 => address))`)
- **_timeSinceLastTroveInterestRateAdjustment** (`mapping(uint256 => mapping(uint256 => uint256))`)
- **_troveIndexOf** (`mapping(uint256 => mapping(address => uint256))`)
- **_troveIds** (`mapping(uint256 => struct EnumerableSet)`)
- **_zombieTroveIds** (`mapping(uint256 => struct EnumerableSet)`)
- **designatedVictimId** (`mapping(uint256 => uint256)`)
- **_batches** (`mapping(uint256 => mapping(address => struct InvariantsTestHandler.Batch))`)
- **_handlerBold** (`uint256`)
- **spBoldYield** (`mapping(uint256 => uint256)`)
- **_pendingInterest** (`mapping(uint256 => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.closeTrove(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [i, 0, branches.length - 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._troveIdOf(uint256,address) (NodeID: 2)
  │   💬 Args: [i, msg.sender]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._isOpen(uint256,uint256) (NodeID: 3)
  │   💬 Args: [i, v.troveId]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 4)
  │     💬 Args: [_troveIds[i], troveId]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseHandler.logCall(string,string) (NodeID: 5)
  │   💬 Args: ["closeTrove", i.toString()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 20)
  │ │   💬 Args: [i]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 21)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseHandler._logCaller() (NodeID: 6)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 7)
  │ │     💬 Args: ["vm.prank(", vm.getLabel(msg.sender), ");"]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 8)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 9)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 10)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging._log(string,string,string,string,string) (NodeID: 11)
  │ │   💬 Args: [_callPrefix(), functionName, "(", a, ");"]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseHandler._callPrefix() (NodeID: 15)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 12)
  │ │     💬 Args: [string.concat(a, b, c, d, e)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 13)
  │ │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 14)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log() (NodeID: 16)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log() (NodeID: 17)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 18)
  │         💬 Args: [abi.encodeWithSignature("log()")]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 19)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 22)
  │   💬 Args: [v.t.entireDebt, _handlerBold]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._dealBold(address,uint256) (NodeID: 23)
  │   💬 Args: [msg.sender, v.dealt]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._TCR(uint256) (NodeID: 24)
  │   💬 Args: [i]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._TCR(uint256,int256,int256,uint256) (NodeID: 25)
  │     💬 Args: [i, 0, 0, 0]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 26)
  │   │   💬 Args: [branches[i].troveManager.getEntireBranchColl(), collDelta]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 27)
  │   │   💬 Args: [branches[i].troveManager.getEntireBranchDebt(), debtDelta]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 28)
  │       💬 Args: [i, coll, debt]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 29)
  │   💬 Args: [v.wasOpen, "Should have failed as Trove wasn't open"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 30)
  │   💬 Args: [numTroves(i), 1, "Should have failed to close last Trove in the system"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler.numTroves(uint256) (NodeID: 31)
  │     💬 Args: [i]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 32)
  │       💬 Args: [_troveIds[i]]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGeDecimal(uint256,uint256,uint256,string) (NodeID: 33)
  │   💬 Args: [newTCR, CCR[i], 18, "Should have failed as new TCR < CCR"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSetMethods.remove(struct EnumerableSet,uint256) (NodeID: 34)
  │   💬 Args: [_troveIds[i], v.troveId]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 35)
  │     💬 Args: [set, element]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSetMethods.remove(struct EnumerableSet,uint256) (NodeID: 36)
  │   💬 Args: [_zombieTroveIds[i], v.troveId]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 37)
  │     💬 Args: [set, element]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSetMethods.remove(struct EnumerableSet,uint256) (NodeID: 38)
  │   💬 Args: [_batches[i][v.batchManager].troves, v.troveId]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 39)
  │     💬 Args: [set, element]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._touchBatch(uint256,address) (NodeID: 40)
  │   💬 Args: [i, v.batchManager]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 41)
  │ │   💬 Args: [_batches[i][batchManager].troves]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 42)
  │ │   💬 Args: [_batches[i][batchManager].troves, j]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingInterest(struct Trove) (NodeID: 43)
  │ │   💬 Args: [trove]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingBatchManagementFee(struct Trove) (NodeID: 44)
  │     💬 Args: [trove]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._mintYield(uint256,uint256,uint256) (NodeID: 45)
  │   💬 Args: [i, v.pendingInterest, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StringFormatting.equals(string,string) (NodeID: 46)
  │   💬 Args: [reason, "ERC721: invalid token ID"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 47)
  │   💬 Args: [v.wasOpen, "Open Trove should have an NFT"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._decodeCustomError(bytes) (NodeID: 48)
  │   💬 Args: [revertData]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 49)
  │ │   💬 Args: [revertData, 4]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 50)
  │ │     💬 Args: [str, start, int256(str.length)]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 51)
  │ │   💬 Args: [uint256(param)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 52)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 53)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 54)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 55)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 56)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 57)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 58)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 59)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 60)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 61)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 62)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 63)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 64)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 65)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 66)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 67)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 68)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 69)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 70)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 71)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 72)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 73)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._revert(bytes) (NodeID: 74)
  │     💬 Args: [revertData]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLtDecimal(uint256,uint256,uint256,string) (NodeID: 75)
  │   💬 Args: [v.dealt, v.t.entireDebt, 18, "Shouldn't have failed as caller had enough Bold"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._TCR(uint256,int256,int256,uint256) (NodeID: 76)
  │   💬 Args: [i, -int256(v.t.entireColl), -int256(v.t.entireDebt), 0]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 77)
  │ │   💬 Args: [branches[i].troveManager.getEntireBranchColl(), collDelta]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 78)
  │ │   💬 Args: [branches[i].troveManager.getEntireBranchDebt(), debtDelta]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 79)
  │     💬 Args: [i, coll, debt]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 80)
  │   💬 Args: [isShutdown[i], "Shouldn't have failed as branch had been shut down"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLtDecimal(uint256,uint256,uint256,string) (NodeID: 81)
  │   💬 Args: [newTCR, CCR[i], 18, "Shouldn't have failed as new TCR >= CCR"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 82)
  │   💬 Args: ["New TCR would have been: ", newTCR.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 87)
  │ │   💬 Args: [newTCR]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 88)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 89)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 90)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 91)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 92)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 93)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 94)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 95)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 96)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 97)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 98)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 99)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 100)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 101)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 102)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 103)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 104)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 105)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 106)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 107)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 108)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 109)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 83)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 84)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 85)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 86)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 110)
  │   💬 Args: [numTroves(i), 1, "Shouldn't have failed as there was at least one Trove left in the system"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler.numTroves(uint256) (NodeID: 111)
  │     💬 Args: [i]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 112)
  │       💬 Args: [_troveIds[i]]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 113)
  │   💬 Args: ["Expected error: ", v.errorString]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 114)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 115)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 116)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 117)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging._log() (NodeID: 118)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log() (NodeID: 119)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 120)
  │       💬 Args: [abi.encodeWithSignature("log()")]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 121)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepBold(address,uint256) (NodeID: 122)
  │   💬 Args: [msg.sender, v.dealt]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepColl(uint256,address,uint256) (NodeID: 123)
  │   💬 Args: [i, msg.sender, v.t.entireColl]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepWETH(address,uint256) (NodeID: 124)
  │   💬 Args: [msg.sender, ETH_GAS_COMPENSATION]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepBold(address,uint256) (NodeID: 125)
      💬 Args: [v.batchManager, v.batchManagementFee]
      👁️  Def: internal
```
