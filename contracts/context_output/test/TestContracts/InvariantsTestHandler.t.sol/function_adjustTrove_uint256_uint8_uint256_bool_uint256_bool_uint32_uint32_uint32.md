# Function: adjustTrove(uint256,uint8,uint256,bool,uint256,bool,uint32,uint32,uint32)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `adjustTrove(uint256,uint8,uint256,bool,uint256,bool,uint32,uint32,uint32)`
- **Visibility**: external
- **Source Range**: 28030:10321:270

## Implementation

```solidity
function adjustTrove(uint256 i, uint8 prop, uint256 collChange, bool isCollInc, uint256 debtChange, bool isDebtInc, uint32 useZombieSeed, uint32 upperHintSeed, uint32 lowerHintSeed) external {
    AdjustTroveContext memory v;
    v.i = i = _bound(i, 0, branches.length - 1);
    v.prop = AdjustedTroveProperties(_bound(prop, 0, uint8(AdjustedTroveProperties._COUNT) - 1));
    useZombieSeed %= 100;
    v.upperHint = _pickHint(i, upperHintSeed);
    v.lowerHint = _pickHint(i, lowerHintSeed);
    v.c = branches[i];
    v.pendingInterest = v.c.activePool.calcPendingAggInterest();
    v.oldTCR = _TCR(i);
    v.troveId = _troveIdOf(i, msg.sender);
    v.t = v.c.troveManager.getLatestTroveData(v.troveId);
    v.batchManager = _batchManagerOf[i][v.troveId];
    v.batchManagementFee = v.c.troveManager.getLatestBatchData(v.batchManager).accruedManagementFee;
    v.trove = _troves[i][v.troveId];
    v.wasActive = _isActive(i, v.troveId);
    v.wasZombie = _isZombie(i, v.troveId);
    if (v.wasActive || v.wasZombie) {
        if (v.wasZombie) {
            v.useZombie = useZombieSeed != 0;
        } else {
            v.useZombie = useZombieSeed == 0;
        }
    } else {
        v.useZombie = useZombieSeed < 50;
    }
    collChange = (v.prop != AdjustedTroveProperties.onlyDebt) ? _bound(collChange, 0, v.t.entireColl + 1) : 0;
    debtChange = (v.prop != AdjustedTroveProperties.onlyColl) ? _bound(debtChange, 0, v.t.entireDebt + 1) : 0;
    if (!isDebtInc) debtChange = Math.min(debtChange, _handlerBold);
    v.maxDebtDec = (v.t.entireDebt > MIN_DEBT) ? (v.t.entireDebt - MIN_DEBT) : 0;
    v.collDelta = isCollInc ? int256(collChange) : (-int256(collChange));
    v.debtDelta = isDebtInc ? int256(debtChange) : (-int256(Math.min(debtChange, v.maxDebtDec)));
    v.$collDelta36 = v.collDelta * int256(_price[i]);
    v.upfrontFee = hintHelpers.predictAdjustTroveUpfrontFee(i, v.troveId, isDebtInc ? debtChange : 0);
    if (v.upfrontFee > 0) assertGtDecimal(v.debtDelta, 0, 18, "Only debt increase should incur upfront fee");
    v.functionName = _getAdjustmentFunctionName(v.prop, isCollInc, isDebtInc, v.useZombie);
    info("upper hint: ", _hintToString(i, v.upperHint));
    info("lower hint: ", _hintToString(i, v.lowerHint));
    info("upfront fee: ", v.upfrontFee.decimal());
    info("function: ", v.functionName);
    logCall("adjustTrove", i.toString(), v.prop.toString(), collChange.decimal(), isCollInc.toString(), debtChange.decimal(), isDebtInc.toString(), useZombieSeed.toString(), upperHintSeed.toString(), lowerHintSeed.toString());
    if (isCollInc) _dealCollAndApprove(i, msg.sender, collChange, address(v.c.borrowerOperations));
    if (!isDebtInc) _dealBold(msg.sender, debtChange);
    vm.prank(msg.sender);
    try _functionCaller.call(address(v.c.borrowerOperations), v.useZombie ? _encodeZombieTroveAdjustment(v.troveId, collChange, isCollInc, debtChange, isDebtInc, v.upperHint, v.lowerHint, v.upfrontFee) : _encodeActiveTroveAdjustment(v.prop, v.troveId, collChange, isCollInc, debtChange, isDebtInc, v.upfrontFee)) {
        v.newICR = _ICR(i, v.troveId);
        v.newTCR = _TCR(i);
        assertFalse(isShutdown[i], "Should have failed as branch had been shut down");
        assertFalse((v.collDelta == 0) && (v.debtDelta == 0), "Should have failed as there was no change");
        if (v.useZombie) assertTrue(v.wasZombie, "Should have failed as Trove wasn't zombie");
        if (!v.useZombie) assertTrue(v.wasActive, "Should have failed as Trove wasn't active");
        assertLeDecimal(-v.collDelta, int256(v.t.entireColl), 18, "Should have failed as withdrawal > coll");
        assertLeDecimal(-v.debtDelta, int256(v.t.entireDebt), 18, "Should have failed as repayment > debt");
        v.newDebt = v.t.entireDebt.add(v.debtDelta) + v.upfrontFee;
        assertGeDecimal(v.newDebt, MIN_DEBT, 18, "Should have failed as new debt < MIN_DEBT");
        if (v.batchManager == address(0)) {
            assertGeDecimal(v.newICR, MCR[i], 18, "Should have failed as new ICR < MCR");
        } else {
            assertGeDecimal(v.newICR, MCR[i] + BCR[i], 18, "Should have failed as new ICR < MCR + BCR");
        }
        if (v.oldTCR >= CCR[i]) {
            assertGeDecimal(v.newTCR, CCR[i], 18, "Should have failed as new TCR < CCR");
        } else {
            if (v.debtDelta > 0) {
                assertGtDecimal(v.newTCR, CCR[i], 18, "Borrowing should have failed as new TCR < CCR");
            }
            assertGeDecimal((-v.debtDelta) * 1e18, -v.$collDelta36, 36, "Repayment < withdrawal when TCR < CCR");
        }
        v.trove.applyPending();
        v.trove.coll = v.trove.coll.add(v.collDelta);
        v.trove.debt = v.trove.debt.add(v.debtDelta) + v.upfrontFee;
        _troves[i][v.troveId] = v.trove;
        _zombieTroveIds[i].remove(v.troveId);
        if (designatedVictimId[i] == v.troveId) designatedVictimId[i] = 0;
        if (v.batchManager != address(0)) _touchBatch(i, v.batchManager);
        _mintYield(i, v.pendingInterest, v.upfrontFee);
    } catch (bytes memory revertData) {
        bytes4 selector;
        (selector, v.errorString) = _decodeCustomError(revertData);
        if (selector == BorrowerOperations.IsShutDown.selector) {
            assertTrue(isShutdown[i], "Shouldn't have failed as branch hadn't been shut down");
        } else if (selector == BorrowerOperations.ZeroAdjustment.selector) {
            assertEqDecimal(v.collDelta, 0, 18, "Shouldn't have failed as there was a coll change");
            assertEqDecimal(v.debtDelta, 0, 18, "Shouldn't have failed as there was a debt change");
        } else if (selector == BorrowerOperations.TroveNotActive.selector) {
            assertFalse(v.useZombie, string.concat("Shouldn't have been thrown by ", v.functionName));
            assertFalse(v.wasActive, "Shouldn't have failed as Trove was active");
        } else if (selector == BorrowerOperations.TroveNotZombie.selector) {
            assertTrue(v.useZombie, string.concat("Shouldn't have been thrown by ", v.functionName));
            assertFalse(v.wasZombie, "Shouldn't have failed as Trove was zombie");
        } else if (selector == BorrowerOperations.CollWithdrawalTooHigh.selector) {
            assertGtDecimal(-v.collDelta, int256(v.t.entireColl), 18, "Shouldn't have failed as withdrawal <= coll");
        } else if (selector == BorrowerOperations.DebtBelowMin.selector) {
            v.newDebt = (v.t.entireDebt + v.upfrontFee).add(v.debtDelta);
            assertLtDecimal(v.newDebt, MIN_DEBT, 18, "Shouldn't have failed as new debt >= MIN_DEBT");
            info("New debt would have been: ", v.newDebt.decimal());
        } else if (selector == BorrowerOperations.ICRBelowMCR.selector) {
            assertEq(v.batchManager, address(0), "Shouldn't have thrown ICRBelowMCR as Trove was in a batch");
            v.newICR = _ICR(i, v.collDelta, v.debtDelta, v.upfrontFee, v.t);
            assertLtDecimal(v.newICR, MCR[i], 18, "Shouldn't have failed as new ICR >= MCR");
            info("New ICR would have been: ", v.newICR.decimal());
        } else if (selector == BorrowerOperations.ICRBelowMCRPlusBCR.selector) {
            assertNotEq(v.batchManager, address(0), "Shouldn't have thrown ICRBelowMCRPlusBCR as Trove wasn't in a batch");
            v.newICR = _ICR(v.i, v.collDelta, v.debtDelta, v.upfrontFee, v.t);
            assertLtDecimal(v.newICR, MCR[v.i] + BCR[v.i], 18, "Shouldn't have failed as new ICR >= MCR + BCR");
            info("New ICR would have been: ", v.newICR.decimal());
        } else if (selector == BorrowerOperations.TCRBelowCCR.selector) {
            v.newTCR = _TCR(i, v.collDelta, v.debtDelta, v.upfrontFee);
            assertLtDecimal(v.newTCR, CCR[i], 18, "Shouldn't have failed as new TCR >= CCR");
            info("New TCR would have been: ", v.newTCR.decimal());
        } else if (selector == BorrowerOperations.RepaymentNotMatchingCollWithdrawal.selector) {
            assertLtDecimal(v.oldTCR, CCR[i], 18, "Shouldn't have failed as TCR >= CCR");
            assertLtDecimal((-v.debtDelta) * 1e18, -v.$collDelta36, 36, "Shouldn't have failed as repayment >= withdrawal");
        } else {
            revert(string.concat("Unexpected error: ", v.errorString));
        }
    }
    if (bytes(v.errorString).length > 0) {
        if (_assumeNoExpectedFailures) vm.assume(false);
        info("Expected error: ", v.errorString);
        _log();
        if (isCollInc) _sweepCollAndUnapprove(i, msg.sender, collChange, address(v.c.borrowerOperations));
        if (!isDebtInc) _sweepBold(msg.sender, debtChange);
    } else {
        if (!isCollInc) _sweepColl(i, msg.sender, collChange);
        if (isDebtInc) _sweepBold(msg.sender, debtChange);
        if (!isDebtInc) _sweepBold(msg.sender, debtChange - uint256(-v.debtDelta));
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

### _troveIdOf(uint256,address)

- **Kind**: internal
- **Source**: 109113:171:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_troveIdOf(uint256,address)`

```solidity
function _troveIdOf(uint256 i, address owner) internal view returns (uint256) {
    return uint256(keccak256(abi.encode(owner, owner, _troveIndexOf[i][owner])));
}
```

### _isActive(uint256,uint256)

- **Kind**: internal
- **Source**: 110678:145:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_isActive(uint256,uint256)`

```solidity
function _isActive(uint256 i, uint256 troveId) internal view returns (bool) {
    return _isOpen(i, troveId) && (!_isZombie(i, troveId));
}
```

### _isZombie(uint256,uint256)

- **Kind**: internal
- **Source**: 110541:131:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_isZombie(uint256,uint256)`

```solidity
function _isZombie(uint256 i, uint256 troveId) internal view returns (bool) {
    return _zombieTroveIds[i].has(troveId);
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

### _isOpen(uint256,uint256)

- **Kind**: internal
- **Source**: 110412:123:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_isOpen(uint256,uint256)`

```solidity
function _isOpen(uint256 i, uint256 troveId) internal view returns (bool) {
    return _troveIds[i].has(troveId);
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

### assertGtDecimal(int256,int256,uint256,string)

- **Kind**: internal
- **Source**: 14116:174:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGtDecimal(int256,int256,uint256,string)`

```solidity
function assertGtDecimal(int256 left, int256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertGtDecimal(left, right, decimals, err);
}
```

### _getAdjustmentFunctionName(enum AdjustedTroveProperties,bool,bool,bool)

- **Kind**: internal
- **Source**: 125427:838:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_getAdjustmentFunctionName(enum AdjustedTroveProperties,bool,bool,bool)`

```solidity
function _getAdjustmentFunctionName(AdjustedTroveProperties prop, bool isCollIncrease, bool isDebtIncrease, bool zombie) internal pure returns (string memory) {
    if (zombie) {
        return "adjustZombieTrove()";
    }
    if (prop == AdjustedTroveProperties.onlyColl) {
        if (isCollIncrease) {
            return "addColl()";
        } else {
            return "withdrawColl()";
        }
    }
    if (prop == AdjustedTroveProperties.onlyDebt) {
        if (isDebtIncrease) {
            return "withdrawBold()";
        } else {
            return "repayBold()";
        }
    }
    if (prop == AdjustedTroveProperties.both) {
        return "adjustTrove()";
    }
    revert("Invalid prop");
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

### logCall(string,string,string,string,string,string,string,string,string,string)

- **Kind**: internal
- **Source**: 2965:432:251
- **Link**: `test/TestContracts/BaseHandler.sol:BaseHandler:logCall(string,string,string,string,string,string,string,string,string,string)`

```solidity
function logCall(string memory functionName, string memory a, string memory b, string memory c, string memory d, string memory e, string memory f, string memory g, string memory h, string memory i) internal view {
    _logCaller();
    _log(_callPrefix(), functionName, "(", _csv([a, b, c, d, e, f, g, h, i]), ");");
    _log();
}
```

### toString(enum AdjustedTroveProperties)

- **Kind**: internal
- **Source**: 3248:429:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:ToStringFunctions:toString(enum AdjustedTroveProperties)`

```solidity
function toString(AdjustedTroveProperties prop) internal pure returns (string memory) {
    if (prop == AdjustedTroveProperties.onlyColl) return "uint8(AdjustedTroveProperties.onlyColl)";
    if (prop == AdjustedTroveProperties.onlyDebt) return "uint8(AdjustedTroveProperties.onlyDebt)";
    if (prop == AdjustedTroveProperties.both) return "uint8(AdjustedTroveProperties.both)";
    revert("Invalid prop");
}
```

### toString(bool)

- **Kind**: internal
- **Source**: 833:108:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:toString(bool)`

```solidity
function toString(bool b) internal pure returns (string memory) {
    return b ? "true" : "false";
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

### _csv(string[9])

- **Kind**: internal
- **Source**: 5102:455:289
- **Link**: `test/Utils/Logging.sol:Logging:_csv(string[9])`

```solidity
function _csv(string[9] memory strs) internal pure returns (string memory) {
    return string.concat(strs[0], ", ", strs[1], ", ", strs[2], ", ", strs[3], ", ", strs[4], ", ", strs[5], ", ", strs[6], ", ", strs[7], ", ", strs[8]);
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

### _dealCollAndApprove(uint256,address,uint256,address)

- **Kind**: internal
- **Source**: 114160:399:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_dealCollAndApprove(uint256,address,uint256,address)`

```solidity
function _dealCollAndApprove(uint256 i, address to, uint256 amount, address spender) internal {
    IERC20 collToken = branches[i].collToken;
    uint256 balance = collToken.balanceOf(to);
    uint256 allowance = collToken.allowance(to, spender);
    deal(address(collToken), to, balance + amount);
    vm.prank(to);
    collToken.approve(spender, allowance + amount);
}
```

### deal(address,address,uint256)

- **Kind**: internal
- **Source**: 27270:117:50
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:deal(address,address,uint256)`

```solidity
function deal(address token, address to, uint256 give) virtual internal {
    deal(token, to, give, false);
}
```

### deal(address,address,uint256,bool)

- **Kind**: internal
- **Source**: 27666:837:50
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:deal(address,address,uint256,bool)`

```solidity
function deal(address token, address to, uint256 give, bool adjust) virtual internal {
    (, bytes memory balData) = token.staticcall(abi.encodeWithSelector(0x70a08231, to));
    uint256 prevBal = abi.decode(balData, (uint256));
    stdstore.target(token).sig(0x70a08231).with_key(to).checked_write(give);
    if (adjust) {
        (, bytes memory totSupData) = token.staticcall(abi.encodeWithSelector(0x18160ddd));
        uint256 totSup = abi.decode(totSupData, (uint256));
        if (give < prevBal) {
            totSup -= (prevBal - give);
        } else {
            totSup += (give - prevBal);
        }
        stdstore.target(token).sig(0x18160ddd).checked_write(totSup);
    }
}
```

### target(struct StdStorage,address)

- **Kind**: internal
- **Source**: 13258:156:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:target(struct StdStorage,address)`

```solidity
function target(StdStorage storage self, address _target) internal returns (StdStorage storage) {
    return stdStorageSafe.target(self, _target);
}
```

### target(struct StdStorage,address)

- **Kind**: internal
- **Source**: 6747:156:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:target(struct StdStorage,address)`

```solidity
function target(StdStorage storage self, address _target) internal returns (StdStorage storage) {
    self._target = _target;
    return self;
}
```

### sig(struct StdStorage,bytes4)

- **Kind**: internal
- **Source**: 13420:143:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:sig(struct StdStorage,bytes4)`

```solidity
function sig(StdStorage storage self, bytes4 _sig) internal returns (StdStorage storage) {
    return stdStorageSafe.sig(self, _sig);
}
```

### sig(struct StdStorage,bytes4)

- **Kind**: internal
- **Source**: 6909:143:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:sig(struct StdStorage,bytes4)`

```solidity
function sig(StdStorage storage self, bytes4 _sig) internal returns (StdStorage storage) {
    self._sig = _sig;
    return self;
}
```

### with_key(struct StdStorage,address)

- **Kind**: internal
- **Source**: 13725:152:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:with_key(struct StdStorage,address)`

```solidity
function with_key(StdStorage storage self, address who) internal returns (StdStorage storage) {
    return stdStorageSafe.with_key(self, who);
}
```

### with_key(struct StdStorage,address)

- **Kind**: internal
- **Source**: 7400:179:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:with_key(struct StdStorage,address)`

```solidity
function with_key(StdStorage storage self, address who) internal returns (StdStorage storage) {
    self._keys.push(bytes32(uint256(uint160(who))));
    return self;
}
```

### checked_write(struct StdStorage,uint256)

- **Kind**: internal
- **Source**: 14946:120:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:checked_write(struct StdStorage,uint256)`

```solidity
function checked_write(StdStorage storage self, uint256 amt) internal {
    checked_write(self, bytes32(amt));
}
```

### checked_write(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 15438:1484:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:checked_write(struct StdStorage,bytes32)`

```solidity
function checked_write(StdStorage storage self, bytes32 set) internal {
    address who = self._target;
    bytes4 fsig = self._sig;
    uint256 field_depth = self._depth;
    bytes memory params = stdStorageSafe.getCallParams(self);
    if (!self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found) {
        find(self, false);
    }
    FindData storage data = self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
    if ((data.offsetLeft + data.offsetRight) > 0) {
        uint256 maxVal = 2 ** (256 - (data.offsetLeft + data.offsetRight));
        require(uint256(set) < maxVal, string(abi.encodePacked("stdStorage find(StdStorage): Packed slot. We can't fit value greater than ", vm.toString(maxVal))));
    }
    bytes32 curVal = vm.load(who, bytes32(data.slot));
    bytes32 valToSet = stdStorageSafe.getUpdatedSlotValue(curVal, uint256(set), data.offsetLeft, data.offsetRight);
    vm.store(who, bytes32(data.slot), valToSet);
    (bool success, bytes32 callResult) = stdStorageSafe.callTarget(self);
    if ((!success) || (callResult != set)) {
        vm.store(who, bytes32(data.slot), curVal);
        revert("stdStorage find(StdStorage): Failed to write value.");
    }
    clear(self);
}
```

### getCallParams(struct StdStorage)

- **Kind**: internal
- **Source**: 953:236:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getCallParams(struct StdStorage)`

```solidity
function getCallParams(StdStorage storage self) internal view returns (bytes memory) {
    if (self._calldata.length == 0) {
        return flatten(self._keys);
    } else {
        return self._calldata;
    }
}
```

### flatten(bytes32[])

- **Kind**: internal
- **Source**: 11186:393:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:flatten(bytes32[])`

```solidity
function flatten(bytes32[] memory b) private pure returns (bytes memory) {
    bytes memory result = new bytes(b.length * 32);
    for (uint256 i = 0; i < b.length; i++) {
        bytes32 k = b[i];
        /// @solidity memory-safe-assembly
        assembly {
            mstore(add(result, add(32, mul(32, i))), k)
        }
    }
    return result;
}
```

### find(struct StdStorage,bool)

- **Kind**: internal
- **Source**: 13111:141:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:find(struct StdStorage,bool)`

```solidity
function find(StdStorage storage self, bool _clear) internal returns (uint256) {
    return stdStorageSafe.find(self, _clear).slot;
}
```

### find(struct StdStorage,bool)

- **Kind**: internal
- **Source**: 4249:2492:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:find(struct StdStorage,bool)`

```solidity
/// @notice find an arbitrary storage slot given a function sig, input data, address of the contract and a value to check against
function find(StdStorage storage self, bool _clear) internal returns (FindData storage) {
    address who = self._target;
    bytes4 fsig = self._sig;
    uint256 field_depth = self._depth;
    bytes memory params = getCallParams(self);
    if (self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found) {
        if (_clear) {
            clear(self);
        }
        return self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
    }
    vm.record();
    (, bytes32 callResult) = callTarget(self);
    (bytes32[] memory reads, ) = vm.accesses(address(who));
    if (reads.length == 0) {
        revert("stdStorage find(StdStorage): No storage use detected for target.");
    } else {
        for (uint256 i = reads.length; (--i) >= 0; ) {
            bytes32 prev = vm.load(who, reads[i]);
            if (prev == bytes32(0)) {
                emit WARNING_UninitedSlot(who, uint256(reads[i]));
            }
            if (!checkSlotMutatesCall(self, reads[i])) {
                continue;
            }
            (uint256 offsetLeft, uint256 offsetRight) = (0, 0);
            if (self._enable_packed_slots) {
                bool found;
                (found, offsetLeft, offsetRight) = findOffsets(self, reads[i]);
                if (!found) {
                    continue;
                }
            }
            uint256 curVal = (uint256(prev) & getMaskByOffsets(offsetLeft, offsetRight)) >> offsetRight;
            if (uint256(callResult) != curVal) {
                continue;
            }
            emit SlotFound(who, fsig, keccak256(abi.encodePacked(params, field_depth)), uint256(reads[i]));
            self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))] = FindData(uint256(reads[i]), offsetLeft, offsetRight, true);
            break;
        }
    }
    require(self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found, "stdStorage find(StdStorage): Slot(s) not found.");
    if (_clear) {
        clear(self);
    }
    return self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
}
```

### clear(struct StdStorage)

- **Kind**: internal
- **Source**: 11585:239:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:clear(struct StdStorage)`

```solidity
function clear(StdStorage storage self) internal {
    delete self._target;
    delete self._sig;
    delete self._keys;
    delete self._depth;
    delete self._enable_packed_slots;
    delete self._calldata;
}
```

### callTarget(struct StdStorage)

- **Kind**: internal
- **Source**: 1251:343:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:callTarget(struct StdStorage)`

```solidity
function callTarget(StdStorage storage self) internal view returns (bool, bytes32) {
    bytes memory cald = abi.encodePacked(self._sig, getCallParams(self));
    (bool success, bytes memory rdat) = self._target.staticcall(cald);
    bytes32 result = bytesToBytes32(rdat, 32 * self._depth);
    return (success, result);
}
```

### bytesToBytes32(bytes,uint256)

- **Kind**: internal
- **Source**: 10876:304:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:bytesToBytes32(bytes,uint256)`

```solidity
function bytesToBytes32(bytes memory b, uint256 offset) private pure returns (bytes32) {
    bytes32 out;
    uint256 max = (b.length > 32) ? 32 : b.length;
    for (uint256 i = 0; i < max; i++) {
        out |= bytes32(b[offset + i] & 0xFF) >> (i * 8);
    }
    return out;
}
```

### checkSlotMutatesCall(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 1851:546:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:checkSlotMutatesCall(struct StdStorage,bytes32)`

```solidity
function checkSlotMutatesCall(StdStorage storage self, bytes32 slot) internal returns (bool) {
    bytes32 prevSlotValue = vm.load(self._target, slot);
    (bool success, bytes32 prevReturnValue) = callTarget(self);
    bytes32 testVal = (prevReturnValue == bytes32(0)) ? bytes32(UINT256_MAX) : bytes32(0);
    vm.store(self._target, slot, testVal);
    (, bytes32 newReturnValue) = callTarget(self);
    vm.store(self._target, slot, prevSlotValue);
    return (success && (prevReturnValue != newReturnValue));
}
```

### findOffsets(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 3080:534:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:findOffsets(struct StdStorage,bytes32)`

```solidity
function findOffsets(StdStorage storage self, bytes32 slot) internal returns (bool, uint256, uint256) {
    bytes32 prevSlotValue = vm.load(self._target, slot);
    (bool foundLeft, uint256 offsetLeft) = findOffset(self, slot, true);
    (bool foundRight, uint256 offsetRight) = findOffset(self, slot, false);
    vm.store(self._target, slot, prevSlotValue);
    return (foundLeft && foundRight, offsetLeft, offsetRight);
}
```

### findOffset(struct StdStorage,bytes32,bool)

- **Kind**: internal
- **Source**: 2560:514:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:findOffset(struct StdStorage,bytes32,bool)`

```solidity
function findOffset(StdStorage storage self, bytes32 slot, bool left) internal returns (bool, uint256) {
    for (uint256 offset = 0; offset < 256; offset++) {
        uint256 valueToPut = left ? (1 << (255 - offset)) : (1 << offset);
        vm.store(self._target, slot, bytes32(valueToPut));
        (bool success, bytes32 data) = callTarget(self);
        if (success && (uint256(data) > 0)) {
            return (true, offset);
        }
    }
    return (false, 0);
}
```

### getMaskByOffsets(uint256,uint256)

- **Kind**: internal
- **Source**: 12017:376:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getMaskByOffsets(uint256,uint256)`

```solidity
function getMaskByOffsets(uint256 offsetLeft, uint256 offsetRight) internal pure returns (uint256 mask) {
    assembly {
        mask := shl(offsetRight, sub(shl(sub(256, add(offsetRight, offsetLeft)), 1), 1))
    }
}
```

### getUpdatedSlotValue(bytes32,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 12455:300:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getUpdatedSlotValue(bytes32,uint256,uint256,uint256)`

```solidity
function getUpdatedSlotValue(bytes32 curValue, uint256 varValue, uint256 offsetLeft, uint256 offsetRight) internal pure returns (bytes32 newValue) {
    return bytes32((uint256(curValue) & (~getMaskByOffsets(offsetLeft, offsetRight))) | (varValue << offsetRight));
}
```

### clear(struct StdStorage)

- **Kind**: internal
- **Source**: 14704:92:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:clear(struct StdStorage)`

```solidity
function clear(StdStorage storage self) internal {
    stdStorageSafe.clear(self);
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

### _encodeZombieTroveAdjustment(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 127527:520:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_encodeZombieTroveAdjustment(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256)`

```solidity
function _encodeZombieTroveAdjustment(uint256 troveId, uint256 collChange, bool isCollIncrease, uint256 debtChange, bool isDebtIncrease, uint256 upperHint, uint256 lowerHint, uint256 maxUpfrontFee) internal pure returns (bytes memory) {
    return abi.encodeCall(IBorrowerOperations.adjustZombieTrove, (troveId, collChange, isCollIncrease, debtChange, isDebtIncrease, upperHint, lowerHint, maxUpfrontFee));
}
```

### _encodeActiveTroveAdjustment(enum AdjustedTroveProperties,uint256,uint256,bool,uint256,bool,uint256)

- **Kind**: internal
- **Source**: 126271:1250:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_encodeActiveTroveAdjustment(enum AdjustedTroveProperties,uint256,uint256,bool,uint256,bool,uint256)`

```solidity
function _encodeActiveTroveAdjustment(AdjustedTroveProperties prop, uint256 troveId, uint256 collChange, bool isCollIncrease, uint256 debtChange, bool isDebtIncrease, uint256 maxUpfrontFee) internal pure returns (bytes memory) {
    if (prop == AdjustedTroveProperties.onlyColl) {
        if (isCollIncrease) {
            return abi.encodeCall(IBorrowerOperations.addColl, (troveId, collChange));
        } else {
            return abi.encodeCall(IBorrowerOperations.withdrawColl, (troveId, collChange));
        }
    }
    if (prop == AdjustedTroveProperties.onlyDebt) {
        if (isDebtIncrease) {
            return abi.encodeCall(IBorrowerOperations.withdrawBold, (troveId, debtChange, maxUpfrontFee));
        } else {
            return abi.encodeCall(IBorrowerOperations.repayBold, (troveId, debtChange));
        }
    }
    if (prop == AdjustedTroveProperties.both) {
        return abi.encodeCall(IBorrowerOperations.adjustTrove, (troveId, collChange, isCollIncrease, debtChange, isDebtIncrease, maxUpfrontFee));
    }
    revert("Invalid prop");
}
```

### _ICR(uint256,uint256)

- **Kind**: internal
- **Source**: 107624:123:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_ICR(uint256,uint256)`

```solidity
function _ICR(uint256 i, uint256 troveId) internal view returns (uint256) {
    return _ICR(i, 0, 0, 0, troveId);
}
```

### _ICR(uint256,int256,int256,uint256,uint256)

- **Kind**: internal
- **Source**: 107893:277:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_ICR(uint256,int256,int256,uint256,uint256)`

```solidity
function _ICR(uint256 i, int256 collDelta, int256 debtDelta, uint256 upfrontFee, uint256 troveId) internal view returns (uint256) {
    return _ICR(i, collDelta, debtDelta, upfrontFee, branches[i].troveManager.getLatestTroveData(troveId));
}
```

### _ICR(uint256,int256,int256,uint256,struct LatestTroveData)

- **Kind**: internal
- **Source**: 108176:339:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_ICR(uint256,int256,int256,uint256,struct LatestTroveData)`

```solidity
function _ICR(uint256 i, int256 collDelta, int256 debtDelta, uint256 upfrontFee, LatestTroveData memory trove) internal view returns (uint256) {
    uint256 coll = trove.entireColl.add(collDelta);
    uint256 debt = trove.entireDebt.add(debtDelta) + upfrontFee;
    return _CR(i, coll, debt);
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

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1689:113:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    vm.assertTrue(data, err);
}
```

### assertLeDecimal(int256,int256,uint256,string)

- **Kind**: internal
- **Source**: 15300:174:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLeDecimal(int256,int256,uint256,string)`

```solidity
function assertLeDecimal(int256 left, int256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertLeDecimal(left, right, decimals, err);
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

### assertGtDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 13526:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGtDecimal(uint256,uint256,uint256,string)`

```solidity
function assertGtDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertGtDecimal(left, right, decimals, err);
}
```

### assertGeDecimal(int256,int256,uint256,string)

- **Kind**: internal
- **Source**: 16484:174:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGeDecimal(int256,int256,uint256,string)`

```solidity
function assertGeDecimal(int256 left, int256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertGeDecimal(left, right, decimals, err);
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

### assertEqDecimal(int256,int256,uint256,string)

- **Kind**: internal
- **Source**: 3274:174:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEqDecimal(int256,int256,uint256,string)`

```solidity
function assertEqDecimal(int256 left, int256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertEqDecimal(left, right, decimals, err);
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

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 3570:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### assertNotEq(address,address,string)

- **Kind**: internal
- **Source**: 8568:140:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertNotEq(address,address,string)`

```solidity
function assertNotEq(address left, address right, string memory err) virtual internal pure {
    vm.assertNotEq(left, right, err);
}
```

### assertLtDecimal(int256,int256,uint256,string)

- **Kind**: internal
- **Source**: 12932:174:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLtDecimal(int256,int256,uint256,string)`

```solidity
function assertLtDecimal(int256 left, int256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertLtDecimal(left, right, decimals, err);
}
```

### _sweepCollAndUnapprove(uint256,address,uint256,address)

- **Kind**: internal
- **Source**: 115147:338:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_sweepCollAndUnapprove(uint256,address,uint256,address)`

```solidity
function _sweepCollAndUnapprove(uint256 i, address from, uint256 amount, address spender) internal {
    _sweepColl(i, from, amount);
    IERC20 collToken = branches[i].collToken;
    uint256 allowance = collToken.allowance(from, spender);
    vm.prank(from);
    collToken.approve(spender, allowance - amount);
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
- **ITroveManagerTester::getLatestTroveData(uint256)**
- **ITroveManagerTester::getLatestBatchData(address)**
- **HintHelpers::predictAdjustTroveUpfrontFee(uint256,uint256,uint256)**
- **Vm::prank(address)**
- **FunctionCaller::call(address,bytes)**
- **Vm::assume(bool)**

## Native Transfers

- **_functionCaller** (state variable) [test/TestContracts/InvariantsTestHandler.t.sol/contract_FunctionCaller.md]

## State Variable Reads

- **_batchManagerOf** (`mapping(uint256 => mapping(uint256 => address))`)
- **_troves** (`mapping(uint256 => mapping(uint256 => struct Trove))`)
- **_handlerBold** (`uint256`)
- **_price** (`mapping(uint256 => uint256)`)
- **_functionCaller** (`contract FunctionCaller`) [test/TestContracts/InvariantsTestHandler.t.sol/contract_FunctionCaller.md]
- **isShutdown** (`mapping(uint256 => bool)`)
- **MCR** (`mapping(uint256 => uint256)`)
- **BCR** (`mapping(uint256 => uint256)`)
- **CCR** (`mapping(uint256 => uint256)`)
- **designatedVictimId** (`mapping(uint256 => uint256)`)
- **_assumeNoExpectedFailures** (`bool`)
- **UINT256_MAX** (`uint256`)
- **_troveIds** (`mapping(uint256 => struct EnumerableSet)`)
- **_troveIndexOf** (`mapping(uint256 => mapping(address => uint256))`)
- **_zombieTroveIds** (`mapping(uint256 => struct EnumerableSet)`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **ONE** (`uint256`)
- **DECIMAL_UNIT** (`string`)
- **DECIMAL_SEPARATOR** (`string`)
- **GROUP_DIGITS** (`uint256`)
- **GROUP_SEPARATOR** (`bytes1`)
- **stdstore** (`struct StdStorage`)
- **_batches** (`mapping(uint256 => mapping(address => struct InvariantsTestHandler.Batch))`)

## State Variable Writes

- **_troves** (`mapping(uint256 => mapping(uint256 => struct Trove))`)
- **_zombieTroveIds** (`mapping(uint256 => struct EnumerableSet)`)
- **designatedVictimId** (`mapping(uint256 => uint256)`)
- **_handlerBold** (`uint256`)
- **_batches** (`mapping(uint256 => mapping(address => struct InvariantsTestHandler.Batch))`)
- **spBoldYield** (`mapping(uint256 => uint256)`)
- **_pendingInterest** (`mapping(uint256 => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.adjustTrove(uint256,uint8,uint256,bool,uint256,bool,uint32,uint32,uint32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [i, 0, branches.length - 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 2)
  │   💬 Args: [prop, 0, uint8(AdjustedTroveProperties._COUNT) - 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._pickHint(uint256,uint256) (NodeID: 3)
  │   💬 Args: [i, upperHintSeed]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 4)
  │ │   💬 Args: [_troveIds[i]]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 5)
  │ │   💬 Args: [_troveIds[i]]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 6)
  │     💬 Args: [_troveIds[i], rem - 1]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._pickHint(uint256,uint256) (NodeID: 7)
  │   💬 Args: [i, lowerHintSeed]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 8)
  │ │   💬 Args: [_troveIds[i]]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 9)
  │ │   💬 Args: [_troveIds[i]]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 10)
  │     💬 Args: [_troveIds[i], rem - 1]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._TCR(uint256) (NodeID: 11)
  │   💬 Args: [i]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._TCR(uint256,int256,int256,uint256) (NodeID: 12)
  │     💬 Args: [i, 0, 0, 0]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 13)
  │   │   💬 Args: [branches[i].troveManager.getEntireBranchColl(), collDelta]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 14)
  │   │   💬 Args: [branches[i].troveManager.getEntireBranchDebt(), debtDelta]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 15)
  │       💬 Args: [i, coll, debt]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._troveIdOf(uint256,address) (NodeID: 16)
  │   💬 Args: [i, msg.sender]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._isActive(uint256,uint256) (NodeID: 17)
  │   💬 Args: [i, v.troveId]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._isZombie(uint256,uint256) (NodeID: 18)
  │ │   💬 Args: [i, troveId]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 19)
  │ │     💬 Args: [_zombieTroveIds[i], troveId]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._isOpen(uint256,uint256) (NodeID: 20)
  │     💬 Args: [i, troveId]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 21)
  │       💬 Args: [_troveIds[i], troveId]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._isZombie(uint256,uint256) (NodeID: 22)
  │   💬 Args: [i, v.troveId]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 23)
  │     💬 Args: [_zombieTroveIds[i], troveId]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 24)
  │   💬 Args: [collChange, 0, v.t.entireColl + 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 25)
  │   💬 Args: [debtChange, 0, v.t.entireDebt + 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 26)
  │   💬 Args: [debtChange, _handlerBold]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 27)
  │   💬 Args: [debtChange, v.maxDebtDec]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGtDecimal(int256,int256,uint256,string) (NodeID: 28)
  │   💬 Args: [v.debtDelta, 0, 18, "Only debt increase should incur upfront fee"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._getAdjustmentFunctionName(enum AdjustedTroveProperties,bool,bool,bool) (NodeID: 29)
  │   💬 Args: [v.prop, isCollInc, isDebtInc, v.useZombie]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 30)
  │   💬 Args: ["upper hint: ", _hintToString(i, v.upperHint)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._hintToString(uint256,uint256) (NodeID: 35)
  │ │   💬 Args: [i, v.upperHint]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: InvariantsTestHandler._isOpen(uint256,uint256) (NodeID: 36)
  │ │ │   💬 Args: [i, troveId]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 37)
  │ │ │     💬 Args: [_troveIds[i], troveId]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 38)
  │ │     💬 Args: [troveId]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 39)
  │ │       💬 Args: [value]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 31)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 32)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 33)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 34)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 40)
  │   💬 Args: ["lower hint: ", _hintToString(i, v.lowerHint)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._hintToString(uint256,uint256) (NodeID: 45)
  │ │   💬 Args: [i, v.lowerHint]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: InvariantsTestHandler._isOpen(uint256,uint256) (NodeID: 46)
  │ │ │   💬 Args: [i, troveId]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 47)
  │ │ │     💬 Args: [_troveIds[i], troveId]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 48)
  │ │     💬 Args: [troveId]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 49)
  │ │       💬 Args: [value]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 41)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 42)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 43)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 44)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 50)
  │   💬 Args: ["upfront fee: ", v.upfrontFee.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 55)
  │ │   💬 Args: [v.upfrontFee]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 56)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 57)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 58)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 59)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 60)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 61)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 62)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 63)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 64)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 65)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 66)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 67)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 68)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 69)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 70)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 71)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 72)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 73)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 74)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 75)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 76)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 77)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 51)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 52)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 53)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 54)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 78)
  │   💬 Args: ["function: ", v.functionName]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 79)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 80)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 81)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 82)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseHandler.logCall(string,string,string,string,string,string,string,string,string,string) (NodeID: 83)
  │   💬 Args: ["adjustTrove", i.toString(), v.prop.toString(), collChange.decimal(), isCollInc.toString(), debtChange.decimal(), isDebtInc.toString(), useZombieSeed.toString(), upperHintSeed.toString(), lowerHintSeed.toString()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 99)
  │ │   💬 Args: [i]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 100)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ToStringFunctions.toString(enum AdjustedTroveProperties) (NodeID: 101)
  │ │   💬 Args: [v.prop]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 102)
  │ │   💬 Args: [collChange]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 103)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 104)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 105)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 106)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 107)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 108)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 109)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 110)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 111)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 112)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 113)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 114)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 115)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 116)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 117)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 118)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 119)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 120)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 121)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 122)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 123)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 124)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.toString(bool) (NodeID: 125)
  │ │   💬 Args: [isCollInc]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 126)
  │ │   💬 Args: [debtChange]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 127)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 128)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 129)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 130)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 131)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 132)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 133)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 134)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 135)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 136)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 137)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 138)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 139)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 140)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 141)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 142)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 143)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 144)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 145)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 146)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 147)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 148)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.toString(bool) (NodeID: 149)
  │ │   💬 Args: [isDebtInc]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 150)
  │ │   💬 Args: [useZombieSeed]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 151)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 152)
  │ │   💬 Args: [upperHintSeed]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 153)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 154)
  │ │   💬 Args: [lowerHintSeed]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 155)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseHandler._logCaller() (NodeID: 84)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 85)
  │ │     💬 Args: ["vm.prank(", vm.getLabel(msg.sender), ");"]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 86)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 87)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 88)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging._log(string,string,string,string,string) (NodeID: 89)
  │ │   💬 Args: [_callPrefix(), functionName, "(", _csv([a, b, c, d, e, f, g, h, i]), ");"]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseHandler._callPrefix() (NodeID: 93)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Logging._csv(string[9]) (NodeID: 94)
  │ │ │   💬 Args: [[a, b, c, d, e, f, g, h, i]]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 90)
  │ │     💬 Args: [string.concat(a, b, c, d, e)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 91)
  │ │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 92)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log() (NodeID: 95)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log() (NodeID: 96)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 97)
  │         💬 Args: [abi.encodeWithSignature("log()")]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 98)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._dealCollAndApprove(uint256,address,uint256,address) (NodeID: 156)
  │   💬 Args: [i, msg.sender, collChange, address(v.c.borrowerOperations)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 157)
  │     💬 Args: [address(collToken), to, balance + amount]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 158)
  │       💬 Args: [token, to, give, false]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 159)
  │     │   💬 Args: [stdstore, token]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 160)
  │     │     💬 Args: [self, _target]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 161)
  │     │   💬 Args: [stdstore.target(token), 0x70a08231]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 162)
  │     │     💬 Args: [self, _sig]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 163)
  │     │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 164)
  │     │     💬 Args: [self, who]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 165)
  │     │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 166)
  │     │     💬 Args: [self, bytes32(amt)]
  │     │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 167)
  │     │   │   💬 Args: [self]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 168)
  │     │   │     💬 Args: [self._keys]
  │     │   │     👁️  Def: private
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 169)
  │     │   │   💬 Args: [self, false]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 170)
  │     │   │     💬 Args: [self, _clear]
  │     │   │     👁️  Def: internal
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 171)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 172)
  │     │   │   │     💬 Args: [self._keys]
  │     │   │   │     👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 173)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 174)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 175)
  │     │   │   │ │   💬 Args: [self]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 176)
  │     │   │   │ │     💬 Args: [self._keys]
  │     │   │   │ │     👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 177)
  │     │   │   │     💬 Args: [rdat, 32 * self._depth]
  │     │   │   │     👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 178)
  │     │   │   │   💬 Args: [self, reads[i]]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 179)
  │     │   │   │ │   💬 Args: [self]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 180)
  │     │   │   │ │ │   💬 Args: [self]
  │     │   │   │ │ │   👁️  Def: internal
  │     │   │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 181)
  │     │   │   │ │ │     💬 Args: [self._keys]
  │     │   │   │ │ │     👁️  Def: private
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 182)
  │     │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │     │   │   │ │     👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 183)
  │     │   │   │     💬 Args: [self]
  │     │   │   │     👁️  Def: internal
  │     │   │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 184)
  │     │   │   │   │   💬 Args: [self]
  │     │   │   │   │   👁️  Def: internal
  │     │   │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 185)
  │     │   │   │   │     💬 Args: [self._keys]
  │     │   │   │   │     👁️  Def: private
  │     │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 186)
  │     │   │   │       💬 Args: [rdat, 32 * self._depth]
  │     │   │   │       👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 187)
  │     │   │   │   💬 Args: [self, reads[i]]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 188)
  │     │   │   │ │   💬 Args: [self, slot, true]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 189)
  │     │   │   │ │     💬 Args: [self]
  │     │   │   │ │     👁️  Def: internal
  │     │   │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 190)
  │     │   │   │ │   │   💬 Args: [self]
  │     │   │   │ │   │   👁️  Def: internal
  │     │   │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 191)
  │     │   │   │ │   │     💬 Args: [self._keys]
  │     │   │   │ │   │     👁️  Def: private
  │     │   │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 192)
  │     │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │     │   │   │ │       👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 193)
  │     │   │   │     💬 Args: [self, slot, false]
  │     │   │   │     👁️  Def: internal
  │     │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 194)
  │     │   │   │       💬 Args: [self]
  │     │   │   │       👁️  Def: internal
  │     │   │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 195)
  │     │   │   │     │   💬 Args: [self]
  │     │   │   │     │   👁️  Def: internal
  │     │   │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 196)
  │     │   │   │     │     💬 Args: [self._keys]
  │     │   │   │     │     👁️  Def: private
  │     │   │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 197)
  │     │   │   │         💬 Args: [rdat, 32 * self._depth]
  │     │   │   │         👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 198)
  │     │   │   │   💬 Args: [offsetLeft, offsetRight]
  │     │   │   │   👁️  Def: internal
  │     │   │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 199)
  │     │   │       💬 Args: [self]
  │     │   │       👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 200)
  │     │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 201)
  │     │   │     💬 Args: [offsetLeft, offsetRight]
  │     │   │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 202)
  │     │   │   💬 Args: [self]
  │     │   │   👁️  Def: internal
  │     │   │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 203)
  │     │   │ │   💬 Args: [self]
  │     │   │ │   👁️  Def: internal
  │     │   │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 204)
  │     │   │ │     💬 Args: [self._keys]
  │     │   │ │     👁️  Def: private
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 205)
  │     │   │     💬 Args: [rdat, 32 * self._depth]
  │     │   │     👁️  Def: private
  │     │   └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 206)
  │     │       💬 Args: [self]
  │     │       👁️  Def: internal
  │     │     └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 207)
  │     │         💬 Args: [self]
  │     │         👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 208)
  │     │   💬 Args: [stdstore, token]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 209)
  │     │     💬 Args: [self, _target]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 210)
  │     │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 211)
  │     │     💬 Args: [self, _sig]
  │     │     👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 212)
  │         💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 213)
  │           💬 Args: [self, bytes32(amt)]
  │           👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 214)
  │         │   💬 Args: [self]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 215)
  │         │     💬 Args: [self._keys]
  │         │     👁️  Def: private
  │         ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 216)
  │         │   💬 Args: [self, false]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 217)
  │         │     💬 Args: [self, _clear]
  │         │     👁️  Def: internal
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 218)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 219)
  │         │   │     💬 Args: [self._keys]
  │         │   │     👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 220)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 221)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 222)
  │         │   │ │   💬 Args: [self]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 223)
  │         │   │ │     💬 Args: [self._keys]
  │         │   │ │     👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 224)
  │         │   │     💬 Args: [rdat, 32 * self._depth]
  │         │   │     👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 225)
  │         │   │   💬 Args: [self, reads[i]]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 226)
  │         │   │ │   💬 Args: [self]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 227)
  │         │   │ │ │   💬 Args: [self]
  │         │   │ │ │   👁️  Def: internal
  │         │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 228)
  │         │   │ │ │     💬 Args: [self._keys]
  │         │   │ │ │     👁️  Def: private
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 229)
  │         │   │ │     💬 Args: [rdat, 32 * self._depth]
  │         │   │ │     👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 230)
  │         │   │     💬 Args: [self]
  │         │   │     👁️  Def: internal
  │         │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 231)
  │         │   │   │   💬 Args: [self]
  │         │   │   │   👁️  Def: internal
  │         │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 232)
  │         │   │   │     💬 Args: [self._keys]
  │         │   │   │     👁️  Def: private
  │         │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 233)
  │         │   │       💬 Args: [rdat, 32 * self._depth]
  │         │   │       👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 234)
  │         │   │   💬 Args: [self, reads[i]]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 235)
  │         │   │ │   💬 Args: [self, slot, true]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 236)
  │         │   │ │     💬 Args: [self]
  │         │   │ │     👁️  Def: internal
  │         │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 237)
  │         │   │ │   │   💬 Args: [self]
  │         │   │ │   │   👁️  Def: internal
  │         │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 238)
  │         │   │ │   │     💬 Args: [self._keys]
  │         │   │ │   │     👁️  Def: private
  │         │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 239)
  │         │   │ │       💬 Args: [rdat, 32 * self._depth]
  │         │   │ │       👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 240)
  │         │   │     💬 Args: [self, slot, false]
  │         │   │     👁️  Def: internal
  │         │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 241)
  │         │   │       💬 Args: [self]
  │         │   │       👁️  Def: internal
  │         │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 242)
  │         │   │     │   💬 Args: [self]
  │         │   │     │   👁️  Def: internal
  │         │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 243)
  │         │   │     │     💬 Args: [self._keys]
  │         │   │     │     👁️  Def: private
  │         │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 244)
  │         │   │         💬 Args: [rdat, 32 * self._depth]
  │         │   │         👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 245)
  │         │   │   💬 Args: [offsetLeft, offsetRight]
  │         │   │   👁️  Def: internal
  │         │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 246)
  │         │       💬 Args: [self]
  │         │       👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 247)
  │         │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 248)
  │         │     💬 Args: [offsetLeft, offsetRight]
  │         │     👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 249)
  │         │   💬 Args: [self]
  │         │   👁️  Def: internal
  │         │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 250)
  │         │ │   💬 Args: [self]
  │         │ │   👁️  Def: internal
  │         │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 251)
  │         │ │     💬 Args: [self._keys]
  │         │ │     👁️  Def: private
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 252)
  │         │     💬 Args: [rdat, 32 * self._depth]
  │         │     👁️  Def: private
  │         └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 253)
  │             💬 Args: [self]
  │             👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 254)
  │               💬 Args: [self]
  │               👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._dealBold(address,uint256) (NodeID: 255)
  │   💬 Args: [msg.sender, debtChange]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._encodeZombieTroveAdjustment(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256) (NodeID: 256)
  │   💬 Args: [v.troveId, collChange, isCollInc, debtChange, isDebtInc, v.upperHint, v.lowerHint, v.upfrontFee]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._encodeActiveTroveAdjustment(enum AdjustedTroveProperties,uint256,uint256,bool,uint256,bool,uint256) (NodeID: 257)
  │   💬 Args: [v.prop, v.troveId, collChange, isCollInc, debtChange, isDebtInc, v.upfrontFee]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._ICR(uint256,uint256) (NodeID: 258)
  │   💬 Args: [i, v.troveId]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._ICR(uint256,int256,int256,uint256,uint256) (NodeID: 259)
  │     💬 Args: [i, 0, 0, 0, troveId]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: InvariantsTestHandler._ICR(uint256,int256,int256,uint256,struct LatestTroveData) (NodeID: 260)
  │       💬 Args: [i, collDelta, debtDelta, upfrontFee, branches[i].troveManager.getLatestTroveData(troveId)]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 261)
  │     │   💬 Args: [trove.entireColl, collDelta]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 262)
  │     │   💬 Args: [trove.entireDebt, debtDelta]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 263)
  │         💬 Args: [i, coll, debt]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._TCR(uint256) (NodeID: 264)
  │   💬 Args: [i]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._TCR(uint256,int256,int256,uint256) (NodeID: 265)
  │     💬 Args: [i, 0, 0, 0]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 266)
  │   │   💬 Args: [branches[i].troveManager.getEntireBranchColl(), collDelta]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 267)
  │   │   💬 Args: [branches[i].troveManager.getEntireBranchDebt(), debtDelta]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 268)
  │       💬 Args: [i, coll, debt]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 269)
  │   💬 Args: [isShutdown[i], "Should have failed as branch had been shut down"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 270)
  │   💬 Args: [(v.collDelta == 0) && (v.debtDelta == 0), "Should have failed as there was no change"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 271)
  │   💬 Args: [v.wasZombie, "Should have failed as Trove wasn't zombie"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 272)
  │   💬 Args: [v.wasActive, "Should have failed as Trove wasn't active"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLeDecimal(int256,int256,uint256,string) (NodeID: 273)
  │   💬 Args: [-v.collDelta, int256(v.t.entireColl), 18, "Should have failed as withdrawal > coll"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLeDecimal(int256,int256,uint256,string) (NodeID: 274)
  │   💬 Args: [-v.debtDelta, int256(v.t.entireDebt), 18, "Should have failed as repayment > debt"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 275)
  │   💬 Args: [v.t.entireDebt, v.debtDelta]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGeDecimal(uint256,uint256,uint256,string) (NodeID: 276)
  │   💬 Args: [v.newDebt, MIN_DEBT, 18, "Should have failed as new debt < MIN_DEBT"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGeDecimal(uint256,uint256,uint256,string) (NodeID: 277)
  │   💬 Args: [v.newICR, MCR[i], 18, "Should have failed as new ICR < MCR"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGeDecimal(uint256,uint256,uint256,string) (NodeID: 278)
  │   💬 Args: [v.newICR, MCR[i] + BCR[i], 18, "Should have failed as new ICR < MCR + BCR"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGeDecimal(uint256,uint256,uint256,string) (NodeID: 279)
  │   💬 Args: [v.newTCR, CCR[i], 18, "Should have failed as new TCR < CCR"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGtDecimal(uint256,uint256,uint256,string) (NodeID: 280)
  │   💬 Args: [v.newTCR, CCR[i], 18, "Borrowing should have failed as new TCR < CCR"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGeDecimal(int256,int256,uint256,string) (NodeID: 281)
  │   💬 Args: [(-v.debtDelta) * 1e18, -v.$collDelta36, 36, "Repayment < withdrawal when TCR < CCR"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveMethods.applyPending(struct Trove) (NodeID: 282)
  │   💬 Args: [v.trove]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingRedist(struct Trove) (NodeID: 283)
  │ │   💬 Args: [trove]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingInterest(struct Trove) (NodeID: 284)
  │ │   💬 Args: [trove]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingBatchManagementFee(struct Trove) (NodeID: 285)
  │     💬 Args: [trove]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 286)
  │   💬 Args: [v.trove.coll, v.collDelta]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 287)
  │   💬 Args: [v.trove.debt, v.debtDelta]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSetMethods.remove(struct EnumerableSet,uint256) (NodeID: 288)
  │   💬 Args: [_zombieTroveIds[i], v.troveId]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 289)
  │     💬 Args: [set, element]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._touchBatch(uint256,address) (NodeID: 290)
  │   💬 Args: [i, v.batchManager]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 291)
  │ │   💬 Args: [_batches[i][batchManager].troves]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 292)
  │ │   💬 Args: [_batches[i][batchManager].troves, j]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingInterest(struct Trove) (NodeID: 293)
  │ │   💬 Args: [trove]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingBatchManagementFee(struct Trove) (NodeID: 294)
  │     💬 Args: [trove]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._mintYield(uint256,uint256,uint256) (NodeID: 295)
  │   💬 Args: [i, v.pendingInterest, v.upfrontFee]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._decodeCustomError(bytes) (NodeID: 296)
  │   💬 Args: [revertData]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 297)
  │ │   💬 Args: [revertData, 4]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 298)
  │ │     💬 Args: [str, start, int256(str.length)]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 299)
  │ │   💬 Args: [uint256(param)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 300)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 301)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 302)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 303)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 304)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 305)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 306)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 307)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 308)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 309)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 310)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 311)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 312)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 313)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 314)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 315)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 316)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 317)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 318)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 319)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 320)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 321)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._revert(bytes) (NodeID: 322)
  │     💬 Args: [revertData]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 323)
  │   💬 Args: [isShutdown[i], "Shouldn't have failed as branch hadn't been shut down"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(int256,int256,uint256,string) (NodeID: 324)
  │   💬 Args: [v.collDelta, 0, 18, "Shouldn't have failed as there was a coll change"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(int256,int256,uint256,string) (NodeID: 325)
  │   💬 Args: [v.debtDelta, 0, 18, "Shouldn't have failed as there was a debt change"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 326)
  │   💬 Args: [v.useZombie, string.concat("Shouldn't have been thrown by ", v.functionName)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 327)
  │   💬 Args: [v.wasActive, "Shouldn't have failed as Trove was active"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 328)
  │   💬 Args: [v.useZombie, string.concat("Shouldn't have been thrown by ", v.functionName)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 329)
  │   💬 Args: [v.wasZombie, "Shouldn't have failed as Trove was zombie"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGtDecimal(int256,int256,uint256,string) (NodeID: 330)
  │   💬 Args: [-v.collDelta, int256(v.t.entireColl), 18, "Shouldn't have failed as withdrawal <= coll"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 331)
  │   💬 Args: [(v.t.entireDebt + v.upfrontFee), v.debtDelta]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLtDecimal(uint256,uint256,uint256,string) (NodeID: 332)
  │   💬 Args: [v.newDebt, MIN_DEBT, 18, "Shouldn't have failed as new debt >= MIN_DEBT"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 333)
  │   💬 Args: ["New debt would have been: ", v.newDebt.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 338)
  │ │   💬 Args: [v.newDebt]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 339)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 340)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 341)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 342)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 343)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 344)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 345)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 346)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 347)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 348)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 349)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 350)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 351)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 352)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 353)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 354)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 355)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 356)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 357)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 358)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 359)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 360)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 334)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 335)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 336)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 337)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 361)
  │   💬 Args: [v.batchManager, address(0), "Shouldn't have thrown ICRBelowMCR as Trove was in a batch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._ICR(uint256,int256,int256,uint256,struct LatestTroveData) (NodeID: 362)
  │   💬 Args: [i, v.collDelta, v.debtDelta, v.upfrontFee, v.t]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 363)
  │ │   💬 Args: [trove.entireColl, collDelta]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 364)
  │ │   💬 Args: [trove.entireDebt, debtDelta]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 365)
  │     💬 Args: [i, coll, debt]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLtDecimal(uint256,uint256,uint256,string) (NodeID: 366)
  │   💬 Args: [v.newICR, MCR[i], 18, "Shouldn't have failed as new ICR >= MCR"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 367)
  │   💬 Args: ["New ICR would have been: ", v.newICR.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 372)
  │ │   💬 Args: [v.newICR]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 373)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 374)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 375)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 376)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 377)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 378)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 379)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 380)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 381)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 382)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 383)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 384)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 385)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 386)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 387)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 388)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 389)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 390)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 391)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 392)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 393)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 394)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 368)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 369)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 370)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 371)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 395)
  │   💬 Args: [v.batchManager, address(0), "Shouldn't have thrown ICRBelowMCRPlusBCR as Trove wasn't in a batch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._ICR(uint256,int256,int256,uint256,struct LatestTroveData) (NodeID: 396)
  │   💬 Args: [v.i, v.collDelta, v.debtDelta, v.upfrontFee, v.t]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 397)
  │ │   💬 Args: [trove.entireColl, collDelta]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 398)
  │ │   💬 Args: [trove.entireDebt, debtDelta]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 399)
  │     💬 Args: [i, coll, debt]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLtDecimal(uint256,uint256,uint256,string) (NodeID: 400)
  │   💬 Args: [v.newICR, MCR[v.i] + BCR[v.i], 18, "Shouldn't have failed as new ICR >= MCR + BCR"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 401)
  │   💬 Args: ["New ICR would have been: ", v.newICR.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 406)
  │ │   💬 Args: [v.newICR]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 407)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 408)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 409)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 410)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 411)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 412)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 413)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 414)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 415)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 416)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 417)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 418)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 419)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 420)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 421)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 422)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 423)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 424)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 425)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 426)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 427)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 428)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 402)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 403)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 404)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 405)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._TCR(uint256,int256,int256,uint256) (NodeID: 429)
  │   💬 Args: [i, v.collDelta, v.debtDelta, v.upfrontFee]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 430)
  │ │   💬 Args: [branches[i].troveManager.getEntireBranchColl(), collDelta]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 431)
  │ │   💬 Args: [branches[i].troveManager.getEntireBranchDebt(), debtDelta]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 432)
  │     💬 Args: [i, coll, debt]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLtDecimal(uint256,uint256,uint256,string) (NodeID: 433)
  │   💬 Args: [v.newTCR, CCR[i], 18, "Shouldn't have failed as new TCR >= CCR"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 434)
  │   💬 Args: ["New TCR would have been: ", v.newTCR.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 439)
  │ │   💬 Args: [v.newTCR]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 440)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 441)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 442)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 443)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 444)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 445)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 446)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 447)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 448)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 449)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 450)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 451)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 452)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 453)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 454)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 455)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 456)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 457)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 458)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 459)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 460)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 461)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 435)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 436)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 437)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 438)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLtDecimal(uint256,uint256,uint256,string) (NodeID: 462)
  │   💬 Args: [v.oldTCR, CCR[i], 18, "Shouldn't have failed as TCR >= CCR"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLtDecimal(int256,int256,uint256,string) (NodeID: 463)
  │   💬 Args: [(-v.debtDelta) * 1e18, -v.$collDelta36, 36, "Shouldn't have failed as repayment >= withdrawal"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 464)
  │   💬 Args: ["Expected error: ", v.errorString]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 465)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 466)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 467)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 468)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging._log() (NodeID: 469)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log() (NodeID: 470)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 471)
  │       💬 Args: [abi.encodeWithSignature("log()")]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 472)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepCollAndUnapprove(uint256,address,uint256,address) (NodeID: 473)
  │   💬 Args: [i, msg.sender, collChange, address(v.c.borrowerOperations)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._sweepColl(uint256,address,uint256) (NodeID: 474)
  │     💬 Args: [i, from, amount]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepBold(address,uint256) (NodeID: 475)
  │   💬 Args: [msg.sender, debtChange]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepColl(uint256,address,uint256) (NodeID: 476)
  │   💬 Args: [i, msg.sender, collChange]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepBold(address,uint256) (NodeID: 477)
  │   💬 Args: [msg.sender, debtChange]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepBold(address,uint256) (NodeID: 478)
  │   💬 Args: [msg.sender, debtChange - uint256(-v.debtDelta)]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepBold(address,uint256) (NodeID: 479)
      💬 Args: [v.batchManager, v.batchManagementFee]
      👁️  Def: internal
```
