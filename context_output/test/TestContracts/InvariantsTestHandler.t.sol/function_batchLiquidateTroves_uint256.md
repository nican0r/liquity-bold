# Function: batchLiquidateTroves(uint256)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `batchLiquidateTroves(uint256)`
- **Visibility**: external
- **Source Range**: 48226:5821:270

## Implementation

```solidity
function batchLiquidateTroves(uint256 i) external {
    i = _bound(i, 0, branches.length - 1);
    TestDeployer.LiquityContractsDev memory c = branches[i];
    uint256 pendingInterest = c.activePool.calcPendingAggInterest();
    LiquidationTransientState storage l = _planLiquidation(i);
    uint256[] memory batchManagementFee = new uint256[](l.batchManagers.size());
    for (uint256 j = 0; j < l.batchManagers.size(); ++j) {
        batchManagementFee[j] = c.troveManager.getLatestBatchData(l.batchManagers.get(j)).accruedManagementFee;
    }
    info("batch: [", _labelsFrom(l.batch).join(", "), "]");
    info("liquidated: [", _labelsFrom(l.liquidated).join(", "), "]");
    info("SP offset: ", l.t.spOffset.decimal());
    info("coll redist: ", l.t.collRedist.decimal());
    info("debt redist: ", l.t.debtRedist.decimal());
    logCall("batchLiquidateTroves", i.toString());
    string memory errorString;
    vm.prank(msg.sender);
    try c.troveManager.batchLiquidateTroves(_troveIdsFrom(i, l.batch)) {
        info("SP BOLD: ", c.stabilityPool.getTotalBoldDeposits().decimal());
        info("P: ", c.stabilityPool.P().decimal());
        _log();
        assertGt(l.batch.length, 0, "Should have failed as batch was empty");
        assertGt(l.liquidated.size(), 0, "Should have failed as there was nothing to liquidate");
        assertGt(numTroves(i) - l.liquidated.size(), 0, "Should have failed to liquidate last Trove");
        for (uint256 j = 0; j < l.liquidated.size(); ++j) {
            address owner = l.liquidated.get(j);
            uint256 troveId = _troveIdOf(i, owner);
            address batchManager = _batchManagerOf[i][troveId];
            delete _troves[i][troveId];
            delete _batchManagerOf[i][troveId];
            delete _timeSinceLastTroveInterestRateAdjustment[i][troveId];
            ++_troveIndexOf[i][owner];
            _troveIds[i].remove(troveId);
            _zombieTroveIds[i].remove(troveId);
            if (designatedVictimId[i] == troveId) designatedVictimId[i] = 0;
            if (batchManager != address(0)) _batches[i][batchManager].troves.remove(troveId);
        }
        if (l.t.debtRedist > 0) {
            uint256[] memory stakes = new uint256[](_troveIds[i].size());
            uint256 totalStakes = 0;
            for (uint256 j = 0; j < _troveIds[i].size(); ++j) {
                Trove memory trove = _troves[i][_troveIds[i].get(j)];
                trove.applyPendingRedist();
                totalStakes += stakes[j] = trove.coll;
            }
            assertGtDecimal(totalStakes, 0, 18, "No stakes");
            for (uint256 j = 0; j < _troveIds[i].size(); ++j) {
                uint256 stake = stakes[j];
                uint256 troveId = _troveIds[i].get(j);
                Trove memory trove = _troves[i][troveId];
                trove.redist((l.t.collRedist * stake) / totalStakes, (l.t.debtRedist * stake) / totalStakes);
                _troves[i][troveId] = trove;
            }
        }
        for (uint256 j = 0; j < l.batchManagers.size(); ++j) {
            _touchBatch(i, l.batchManagers.get(j));
        }
        _mintYield(i, pendingInterest, 0);
        spColl[i] += l.t.spCollGain;
        spBoldDeposits[i] -= l.t.spOffset;
        collSurplus[i] += l.t.collSurplus;
        totalCollRedist[i] += l.t.collRedist;
        totalDebtRedist[i] += l.t.debtRedist;
    } catch Panic(uint256 code) {
        uint256 totalStakes = 0;
        for (uint256 j = 0; j < l.remaining.size(); ++j) {
            Trove memory trove = _troves[i][l.remaining.get(j)];
            trove.applyPendingRedist();
            totalStakes += trove.coll;
        }
        assertEq(code, 0x12, "Unexpected panic code");
        assertGtDecimal(l.t.debtRedist, 0, 18, "Shouldn't have failed as there was nothing to redistribute");
        assertApproxEqAbsDecimal(totalStakes, 0, 1e5, 18, "Shouldn't have failed as there was stake remaining");
        errorString = "Division by zero due to totalStakes == 0";
    } catch (bytes memory revertData) {
        bytes4 selector;
        (selector, errorString) = _decodeCustomError(revertData);
        if (selector == TroveManager.EmptyData.selector) {
            assertEq(l.batch.length, 0, "Shouldn't have failed as batch was not empty");
        } else if (selector == TroveManager.NothingToLiquidate.selector) {
            assertEq(l.liquidated.size(), 0, "Shouldn't have failed as there were liquidatable Troves");
        } else if (selector == TroveManager.OnlyOneTroveLeft.selector) {
            assertEq(numTroves(i) - l.liquidated.size(), 0, "Shouldn't have failed as there were Troves left");
        } else {
            revert(string.concat("Unexpected error: ", errorString));
        }
    }
    if (bytes(errorString).length > 0) {
        if (_assumeNoExpectedFailures) vm.assume(false);
        info("Expected error: ", errorString);
        _log();
    } else {
        _sweepColl(i, msg.sender, l.t.collGasComp);
        _sweepWETH(msg.sender, l.liquidated.size() * ETH_GAS_COMPENSATION);
        for (uint256 j = 0; j < l.batchManagers.size(); ++j) {
            _sweepBold(l.batchManagers.get(j), batchManagementFee[j]);
        }
    }
    _resetLiquidation();
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

### _planLiquidation(uint256)

- **Kind**: internal
- **Source**: 117485:847:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_planLiquidation(uint256)`

```solidity
function _planLiquidation(uint256 i) internal returns (LiquidationTransientState storage l) {
    ITroveManager troveManager = branches[i].troveManager;
    l = _liquidation;
    l.remaining.add(_troveIds[i]);
    for (uint256 j = 0; j < l.batch.length; ++j) {
        if (l.liquidated.has(l.batch[j])) continue;
        uint256 troveId = _troveIdOf(i, l.batch[j]);
        address batchManager = _batchManagerOf[i][troveId];
        LatestTroveData memory trove = troveManager.getLatestTroveData(troveId);
        if (_ICR(i, trove) >= MCR[i]) continue;
        l.remaining.remove(troveId);
        l.liquidated.add(l.batch[j]);
        if (batchManager != address(0)) l.batchManagers.add(batchManager);
        _aggregateLiquidation(i, trove, l.t);
    }
}
```

### add(struct EnumerableSet,struct EnumerableSet)

- **Kind**: internal
- **Source**: 1313:208:288
- **Link**: `test/Utils/EnumerableSet.sol:EnumerableSetMethods:add(struct EnumerableSet,struct EnumerableSet)`

```solidity
function add(EnumerableSet storage set, EnumerableSet storage otherSet) internal {
    for (uint256 i = 1; i < otherSet._elements.length; ++i) {
        set.add(otherSet._elements[i]);
    }
}
```

### add(struct EnumerableSet,uint256)

- **Kind**: internal
- **Source**: 806:312:288
- **Link**: `test/Utils/EnumerableSet.sol:EnumerableSetMethods:add(struct EnumerableSet,uint256)`

```solidity
function add(EnumerableSet storage set, uint256 element) internal {
    if (set.has(element)) return;
    if (set._elements.length == 0) set._elements.push();
    set._indexOf[element] = set._elements.length;
    set._elements.push(element);
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

### has(struct EnumerableAddressSet,address)

- **Kind**: internal
- **Source**: 2642:157:288
- **Link**: `test/Utils/EnumerableSet.sol:EnumerableAddressSetMethods:has(struct EnumerableAddressSet,address)`

```solidity
function has(EnumerableAddressSet storage set, address element) internal view returns (bool) {
    return set._base.has(uint256(uint160(element)));
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

### _ICR(uint256,struct LatestTroveData)

- **Kind**: internal
- **Source**: 107753:134:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_ICR(uint256,struct LatestTroveData)`

```solidity
function _ICR(uint256 i, LatestTroveData memory trove) internal view returns (uint256) {
    return _ICR(i, 0, 0, 0, trove);
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

### add(struct EnumerableAddressSet,address)

- **Kind**: internal
- **Source**: 3085:130:288
- **Link**: `test/Utils/EnumerableSet.sol:EnumerableAddressSetMethods:add(struct EnumerableAddressSet,address)`

```solidity
function add(EnumerableAddressSet storage set, address element) internal {
    set._base.add(uint256(uint160(element)));
}
```

### _aggregateLiquidation(uint256,struct LatestTroveData,struct InvariantsTestHandler.LiquidationTotals)

- **Kind**: internal
- **Source**: 115920:1559:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_aggregateLiquidation(uint256,struct LatestTroveData,struct InvariantsTestHandler.LiquidationTotals)`

```solidity
function _aggregateLiquidation(uint256 i, LatestTroveData memory trove, LiquidationTotals storage t) internal {
    uint256 spRemaining = spBoldDeposits[i] - t.spOffset;
    uint256 spOffset = Math.min(trove.entireDebt, (spRemaining > MIN_BOLD_IN_SP) ? (spRemaining - MIN_BOLD_IN_SP) : 0);
    t.spOffset += spOffset;
    uint256 collRemaining = trove.entireColl;
    uint256 collSPPortion = (collRemaining * spOffset) / trove.entireDebt;
    uint256 collGasComp = Math.min(collSPPortion / COLL_GAS_COMPENSATION_DIVISOR, COLL_GAS_COMPENSATION_CAP);
    t.collGasComp += collGasComp;
    collRemaining -= collGasComp;
    uint256 spCollGain = Math.min(collSPPortion - collGasComp, (spOffset * (_100pct + LIQ_PENALTY_SP[i])) / _price[i]);
    t.spCollGain += spCollGain;
    collRemaining -= spCollGain;
    uint256 debtRedist = trove.entireDebt - spOffset;
    t.debtRedist += debtRedist;
    uint256 collRedist = Math.min(collRemaining, (debtRedist * (_100pct + LIQ_PENALTY_REDIST[i])) / _price[i]);
    t.collRedist += collRedist;
    collRemaining -= collRedist;
    t.collSurplus += collRemaining;
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

### size(struct EnumerableAddressSet)

- **Kind**: internal
- **Source**: 2959:120:288
- **Link**: `test/Utils/EnumerableSet.sol:EnumerableAddressSetMethods:size(struct EnumerableAddressSet)`

```solidity
function size(EnumerableAddressSet storage set) internal view returns (uint256) {
    return set._base.size();
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

### get(struct EnumerableAddressSet,uint256)

- **Kind**: internal
- **Source**: 2805:148:288
- **Link**: `test/Utils/EnumerableSet.sol:EnumerableAddressSetMethods:get(struct EnumerableAddressSet,uint256)`

```solidity
function get(EnumerableAddressSet storage set, uint256 i) internal view returns (address) {
    return address(uint160(set._base.get(i)));
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

### info(string,string,string)

- **Kind**: internal
- **Source**: 2953:116:289
- **Link**: `test/Utils/Logging.sol:Logging:info(string,string,string)`

```solidity
function info(string memory a, string memory b, string memory c) internal pure {
    _log("// ", a, b, c);
}
```

### _labelsFrom(address[])

- **Kind**: internal
- **Source**: 109564:251:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_labelsFrom(address[])`

```solidity
function _labelsFrom(address[] storage owners) internal view returns (string[] memory ret) {
    ret = new string[](owners.length);
    for (uint256 i = 0; i < owners.length; ++i) {
        ret[i] = vm.getLabel(owners[i]);
    }
}
```

### join(string[],string)

- **Kind**: internal
- **Source**: 4142:283:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:join(string[],string)`

```solidity
function join(string[] memory strs, string memory sep) internal pure returns (string memory ret) {
    if (strs.length == 0) return "";
    ret = strs[0];
    for (uint256 i = 1; i < strs.length; ++i) {
        ret = string.concat(ret, sep, strs[i]);
    }
}
```

### _log(string,string,string,string)

- **Kind**: internal
- **Source**: 543:151:289
- **Link**: `test/Utils/Logging.sol:Logging:_log(string,string,string,string)`

```solidity
function _log(string memory a, string memory b, string memory c, string memory d) internal pure {
    console.log(string.concat(a, b, c, d));
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

### _labelsFrom(struct EnumerableAddressSet)

- **Kind**: internal
- **Source**: 109821:266:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_labelsFrom(struct EnumerableAddressSet)`

```solidity
function _labelsFrom(EnumerableAddressSet storage owners) internal view returns (string[] memory ret) {
    ret = new string[](owners.size());
    for (uint256 i = 0; i < owners.size(); ++i) {
        ret[i] = vm.getLabel(owners.get(i));
    }
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

### _log(string,string,string)

- **Kind**: internal
- **Source**: 406:131:289
- **Link**: `test/Utils/Logging.sol:Logging:_log(string,string,string)`

```solidity
function _log(string memory a, string memory b, string memory c) internal pure {
    console.log(string.concat(a, b, c));
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

### _troveIdsFrom(uint256,address[])

- **Kind**: internal
- **Source**: 109290:268:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_troveIdsFrom(uint256,address[])`

```solidity
function _troveIdsFrom(uint256 i, address[] storage owners) internal view returns (uint256[] memory ret) {
    ret = new uint256[](owners.length);
    for (uint256 j = 0; j < owners.length; ++j) {
        ret[j] = _troveIdOf(i, owners[j]);
    }
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

### assertGtDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 13526:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGtDecimal(uint256,uint256,uint256,string)`

```solidity
function assertGtDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertGtDecimal(left, right, decimals, err);
}
```

### redist(struct Trove,uint256,uint256)

- **Kind**: internal
- **Source**: 1410:169:293
- **Link**: `test/Utils/Trove.sol:TroveMethods:redist(struct Trove,uint256,uint256)`

```solidity
function redist(Trove memory trove, uint256 coll, uint256 debt) internal pure {
    trove._pendingCollRedist += coll;
    trove._pendingDebtRedist += debt;
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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 17272:268:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)`

```solidity
function assertApproxEqAbsDecimal(uint256 left, uint256 right, uint256 maxDelta, uint256 decimals, string memory err) virtual internal pure {
    vm.assertApproxEqAbsDecimal(left, right, maxDelta, decimals, err);
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

### _resetLiquidation()

- **Kind**: internal
- **Source**: 118338:199:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_resetLiquidation()`

```solidity
function _resetLiquidation() internal {
    _liquidation.remaining.reset();
    _liquidation.liquidated.reset();
    _liquidation.batchManagers.reset();
    delete _liquidation;
}
```

### reset(struct EnumerableSet)

- **Kind**: internal
- **Source**: 2386:210:288
- **Link**: `test/Utils/EnumerableSet.sol:EnumerableSetMethods:reset(struct EnumerableSet)`

```solidity
function reset(EnumerableSet storage set) internal {
    for (uint256 i = 1; i < set._elements.length; ++i) {
        delete set._indexOf[set._elements[i]];
    }
    delete set._elements;
}
```

### reset(struct EnumerableAddressSet)

- **Kind**: internal
- **Source**: 4061:92:288
- **Link**: `test/Utils/EnumerableSet.sol:EnumerableAddressSetMethods:reset(struct EnumerableAddressSet)`

```solidity
function reset(EnumerableAddressSet storage set) internal {
    set._base.reset();
}
```

## External Calls

- **IActivePool::calcPendingAggInterest()**
- **ITroveManagerTester::getLatestBatchData(address)**
- **Vm::prank(address)**
- **ITroveManagerTester::batchLiquidateTroves(uint256[])**
- **IStabilityPool::getTotalBoldDeposits()**
- **IStabilityPool::P()**
- **Vm::assume(bool)**

## State Variable Reads

- **_batchManagerOf** (`mapping(uint256 => mapping(uint256 => address))`)
- **designatedVictimId** (`mapping(uint256 => uint256)`)
- **_troveIds** (`mapping(uint256 => struct EnumerableSet)`)
- **_troves** (`mapping(uint256 => mapping(uint256 => struct Trove))`)
- **_assumeNoExpectedFailures** (`bool`)
- **UINT256_MAX** (`uint256`)
- **_liquidation** (`struct InvariantsTestHandler.LiquidationTransientState`)
- **MCR** (`mapping(uint256 => uint256)`)
- **_troveIndexOf** (`mapping(uint256 => mapping(address => uint256))`)
- **_price** (`mapping(uint256 => uint256)`)
- **spBoldDeposits** (`mapping(uint256 => uint256)`)
- **LIQ_PENALTY_SP** (`mapping(uint256 => uint256)`)
- **LIQ_PENALTY_REDIST** (`mapping(uint256 => uint256)`)
- **ONE** (`uint256`)
- **DECIMAL_UNIT** (`string`)
- **DECIMAL_SEPARATOR** (`string`)
- **GROUP_DIGITS** (`uint256`)
- **GROUP_SEPARATOR** (`bytes1`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **_batches** (`mapping(uint256 => mapping(address => struct InvariantsTestHandler.Batch))`)

## State Variable Writes

- **_troves** (`mapping(uint256 => mapping(uint256 => struct Trove))`)
- **_batchManagerOf** (`mapping(uint256 => mapping(uint256 => address))`)
- **_timeSinceLastTroveInterestRateAdjustment** (`mapping(uint256 => mapping(uint256 => uint256))`)
- **_troveIndexOf** (`mapping(uint256 => mapping(address => uint256))`)
- **_troveIds** (`mapping(uint256 => struct EnumerableSet)`)
- **_zombieTroveIds** (`mapping(uint256 => struct EnumerableSet)`)
- **designatedVictimId** (`mapping(uint256 => uint256)`)
- **_batches** (`mapping(uint256 => mapping(address => struct InvariantsTestHandler.Batch))`)
- **spColl** (`mapping(uint256 => uint256)`)
- **spBoldDeposits** (`mapping(uint256 => uint256)`)
- **collSurplus** (`mapping(uint256 => uint256)`)
- **totalCollRedist** (`mapping(uint256 => uint256)`)
- **totalDebtRedist** (`mapping(uint256 => uint256)`)
- **spBoldYield** (`mapping(uint256 => uint256)`)
- **_pendingInterest** (`mapping(uint256 => uint256)`)
- **_handlerBold** (`uint256`)
- **_liquidation** (`struct InvariantsTestHandler.LiquidationTransientState`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.batchLiquidateTroves(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [i, 0, branches.length - 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._planLiquidation(uint256) (NodeID: 2)
  │   💬 Args: [i]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.add(struct EnumerableSet,struct EnumerableSet) (NodeID: 3)
  │ │   💬 Args: [l.remaining, _troveIds[i]]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.add(struct EnumerableSet,uint256) (NodeID: 4)
  │ │     💬 Args: [set, otherSet._elements[i]]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 5)
  │ │       💬 Args: [set, element]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableAddressSetMethods.has(struct EnumerableAddressSet,address) (NodeID: 6)
  │ │   💬 Args: [l.liquidated, l.batch[j]]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 7)
  │ │     💬 Args: [set._base, uint256(uint160(element))]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._troveIdOf(uint256,address) (NodeID: 8)
  │ │   💬 Args: [i, l.batch[j]]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._ICR(uint256,struct LatestTroveData) (NodeID: 9)
  │ │   💬 Args: [i, trove]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: InvariantsTestHandler._ICR(uint256,int256,int256,uint256,struct LatestTroveData) (NodeID: 10)
  │ │     💬 Args: [i, 0, 0, 0, trove]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 11)
  │ │   │   💬 Args: [trove.entireColl, collDelta]
  │ │   │   👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 12)
  │ │   │   💬 Args: [trove.entireDebt, debtDelta]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 13)
  │ │       💬 Args: [i, coll, debt]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.remove(struct EnumerableSet,uint256) (NodeID: 14)
  │ │   💬 Args: [l.remaining, troveId]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 15)
  │ │     💬 Args: [set, element]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableAddressSetMethods.add(struct EnumerableAddressSet,address) (NodeID: 16)
  │ │   💬 Args: [l.liquidated, l.batch[j]]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.add(struct EnumerableSet,uint256) (NodeID: 17)
  │ │     💬 Args: [set._base, uint256(uint160(element))]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 18)
  │ │       💬 Args: [set, element]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableAddressSetMethods.add(struct EnumerableAddressSet,address) (NodeID: 19)
  │ │   💬 Args: [l.batchManagers, batchManager]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.add(struct EnumerableSet,uint256) (NodeID: 20)
  │ │     💬 Args: [set._base, uint256(uint160(element))]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 21)
  │ │       💬 Args: [set, element]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._aggregateLiquidation(uint256,struct LatestTroveData,struct InvariantsTestHandler.LiquidationTotals) (NodeID: 22)
  │     💬 Args: [i, trove, l.t]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 23)
  │   │   💬 Args: [trove.entireDebt, (spRemaining > MIN_BOLD_IN_SP) ? (spRemaining - MIN_BOLD_IN_SP) : 0]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 24)
  │   │   💬 Args: [collSPPortion / COLL_GAS_COMPENSATION_DIVISOR, COLL_GAS_COMPENSATION_CAP]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 25)
  │   │   💬 Args: [collSPPortion - collGasComp, (spOffset * (_100pct + LIQ_PENALTY_SP[i])) / _price[i]]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 26)
  │       💬 Args: [collRemaining, (debtRedist * (_100pct + LIQ_PENALTY_REDIST[i])) / _price[i]]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 27)
  │   💬 Args: [l.batchManagers]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 28)
  │     💬 Args: [set._base]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 29)
  │   💬 Args: [l.batchManagers]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 30)
  │     💬 Args: [set._base]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableAddressSetMethods.get(struct EnumerableAddressSet,uint256) (NodeID: 31)
  │   💬 Args: [l.batchManagers, j]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 32)
  │     💬 Args: [set._base, i]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string,string) (NodeID: 33)
  │   💬 Args: ["batch: [", _labelsFrom(l.batch).join(", "), "]"]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._labelsFrom(address[]) (NodeID: 38)
  │ │   💬 Args: [l.batch]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.join(string[],string) (NodeID: 39)
  │ │   💬 Args: [_labelsFrom(l.batch), ", "]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string,string) (NodeID: 34)
  │     💬 Args: ["// ", a, b, c]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 35)
  │       💬 Args: [string.concat(a, b, c, d)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 36)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 37)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string,string) (NodeID: 40)
  │   💬 Args: ["liquidated: [", _labelsFrom(l.liquidated).join(", "), "]"]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._labelsFrom(struct EnumerableAddressSet) (NodeID: 45)
  │ │   💬 Args: [l.liquidated]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 46)
  │ │ │   💬 Args: [owners]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 47)
  │ │ │     💬 Args: [set._base]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 48)
  │ │ │   💬 Args: [owners]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 49)
  │ │ │     💬 Args: [set._base]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: EnumerableAddressSetMethods.get(struct EnumerableAddressSet,uint256) (NodeID: 50)
  │ │     💬 Args: [owners, i]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 51)
  │ │       💬 Args: [set._base, i]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.join(string[],string) (NodeID: 52)
  │ │   💬 Args: [_labelsFrom(l.liquidated), ", "]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string,string) (NodeID: 41)
  │     💬 Args: ["// ", a, b, c]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 42)
  │       💬 Args: [string.concat(a, b, c, d)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 43)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 44)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 53)
  │   💬 Args: ["SP offset: ", l.t.spOffset.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 58)
  │ │   💬 Args: [l.t.spOffset]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 59)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 60)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 61)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 62)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 63)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 64)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 65)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 66)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 67)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 68)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 69)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 70)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 71)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 72)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 73)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 74)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 75)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 76)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 77)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 78)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 79)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 80)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 54)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 55)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 56)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 57)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 81)
  │   💬 Args: ["coll redist: ", l.t.collRedist.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 86)
  │ │   💬 Args: [l.t.collRedist]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 87)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 88)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 89)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 90)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 91)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 92)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 93)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 94)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 95)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 96)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 97)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 98)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 99)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 100)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 101)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 102)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 103)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 104)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 105)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 106)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 107)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 108)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 82)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 83)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 84)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 85)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 109)
  │   💬 Args: ["debt redist: ", l.t.debtRedist.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 114)
  │ │   💬 Args: [l.t.debtRedist]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 115)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 116)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 117)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 118)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 119)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 120)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 121)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 122)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 123)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 124)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 125)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 126)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 127)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 128)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 129)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 130)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 131)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 132)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 133)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 134)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 135)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 136)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 110)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 111)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 112)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 113)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseHandler.logCall(string,string) (NodeID: 137)
  │   💬 Args: ["batchLiquidateTroves", i.toString()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 152)
  │ │   💬 Args: [i]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 153)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseHandler._logCaller() (NodeID: 138)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 139)
  │ │     💬 Args: ["vm.prank(", vm.getLabel(msg.sender), ");"]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 140)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 141)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 142)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging._log(string,string,string,string,string) (NodeID: 143)
  │ │   💬 Args: [_callPrefix(), functionName, "(", a, ");"]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseHandler._callPrefix() (NodeID: 147)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 144)
  │ │     💬 Args: [string.concat(a, b, c, d, e)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 145)
  │ │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 146)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log() (NodeID: 148)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log() (NodeID: 149)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 150)
  │         💬 Args: [abi.encodeWithSignature("log()")]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 151)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._troveIdsFrom(uint256,address[]) (NodeID: 154)
  │   💬 Args: [i, l.batch]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._troveIdOf(uint256,address) (NodeID: 155)
  │     💬 Args: [i, owners[j]]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 156)
  │   💬 Args: ["SP BOLD: ", c.stabilityPool.getTotalBoldDeposits().decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 161)
  │ │   💬 Args: [c.stabilityPool.getTotalBoldDeposits()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 162)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 163)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 164)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 165)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 166)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 167)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 168)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 169)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 170)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 171)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 172)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 173)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 174)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 175)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 176)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 177)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 178)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 179)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 180)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 181)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 182)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 183)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 157)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 158)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 159)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 160)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 184)
  │   💬 Args: ["P: ", c.stabilityPool.P().decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 189)
  │ │   💬 Args: [c.stabilityPool.P()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 190)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 191)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 192)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 193)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 194)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 195)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 196)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 197)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 198)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 199)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 200)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 201)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 202)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 203)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 204)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 205)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 206)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 207)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 208)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 209)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 210)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 211)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 185)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 186)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 187)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 188)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging._log() (NodeID: 212)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log() (NodeID: 213)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 214)
  │       💬 Args: [abi.encodeWithSignature("log()")]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 215)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 216)
  │   💬 Args: [l.batch.length, 0, "Should have failed as batch was empty"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 217)
  │   💬 Args: [l.liquidated.size(), 0, "Should have failed as there was nothing to liquidate"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 218)
  │     💬 Args: [l.liquidated]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 219)
  │       💬 Args: [set._base]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 220)
  │   💬 Args: [numTroves(i) - l.liquidated.size(), 0, "Should have failed to liquidate last Trove"]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 221)
  │ │   💬 Args: [l.liquidated]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 222)
  │ │     💬 Args: [set._base]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler.numTroves(uint256) (NodeID: 223)
  │     💬 Args: [i]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 224)
  │       💬 Args: [_troveIds[i]]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 225)
  │   💬 Args: [l.liquidated]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 226)
  │     💬 Args: [set._base]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableAddressSetMethods.get(struct EnumerableAddressSet,uint256) (NodeID: 227)
  │   💬 Args: [l.liquidated, j]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 228)
  │     💬 Args: [set._base, i]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._troveIdOf(uint256,address) (NodeID: 229)
  │   💬 Args: [i, owner]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSetMethods.remove(struct EnumerableSet,uint256) (NodeID: 230)
  │   💬 Args: [_troveIds[i], troveId]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 231)
  │     💬 Args: [set, element]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSetMethods.remove(struct EnumerableSet,uint256) (NodeID: 232)
  │   💬 Args: [_zombieTroveIds[i], troveId]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 233)
  │     💬 Args: [set, element]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSetMethods.remove(struct EnumerableSet,uint256) (NodeID: 234)
  │   💬 Args: [_batches[i][batchManager].troves, troveId]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 235)
  │     💬 Args: [set, element]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 236)
  │   💬 Args: [_troveIds[i]]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 237)
  │   💬 Args: [_troveIds[i]]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 238)
  │   💬 Args: [_troveIds[i], j]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveMethods.applyPendingRedist(struct Trove) (NodeID: 239)
  │   💬 Args: [trove]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGtDecimal(uint256,uint256,uint256,string) (NodeID: 240)
  │   💬 Args: [totalStakes, 0, 18, "No stakes"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 241)
  │   💬 Args: [_troveIds[i]]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 242)
  │   💬 Args: [_troveIds[i], j]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveMethods.redist(struct Trove,uint256,uint256) (NodeID: 243)
  │   💬 Args: [trove, (l.t.collRedist * stake) / totalStakes, (l.t.debtRedist * stake) / totalStakes]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 244)
  │   💬 Args: [l.batchManagers]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 245)
  │     💬 Args: [set._base]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._touchBatch(uint256,address) (NodeID: 246)
  │   💬 Args: [i, l.batchManagers.get(j)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableAddressSetMethods.get(struct EnumerableAddressSet,uint256) (NodeID: 251)
  │ │   💬 Args: [l.batchManagers, j]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 252)
  │ │     💬 Args: [set._base, i]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 247)
  │ │   💬 Args: [_batches[i][batchManager].troves]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 248)
  │ │   💬 Args: [_batches[i][batchManager].troves, j]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingInterest(struct Trove) (NodeID: 249)
  │ │   💬 Args: [trove]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingBatchManagementFee(struct Trove) (NodeID: 250)
  │     💬 Args: [trove]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._mintYield(uint256,uint256,uint256) (NodeID: 253)
  │   💬 Args: [i, pendingInterest, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 254)
  │   💬 Args: [l.remaining]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 255)
  │   💬 Args: [l.remaining, j]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveMethods.applyPendingRedist(struct Trove) (NodeID: 256)
  │   💬 Args: [trove]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 257)
  │   💬 Args: [code, 0x12, "Unexpected panic code"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGtDecimal(uint256,uint256,uint256,string) (NodeID: 258)
  │   💬 Args: [l.t.debtRedist, 0, 18, "Shouldn't have failed as there was nothing to redistribute"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 259)
  │   💬 Args: [totalStakes, 0, 1e5, 18, "Shouldn't have failed as there was stake remaining"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._decodeCustomError(bytes) (NodeID: 260)
  │   💬 Args: [revertData]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 261)
  │ │   💬 Args: [revertData, 4]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 262)
  │ │     💬 Args: [str, start, int256(str.length)]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 263)
  │ │   💬 Args: [uint256(param)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 264)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 265)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 266)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 267)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 268)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 269)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 270)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 271)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 272)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 273)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 274)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 275)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 276)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 277)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 278)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 279)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 280)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 281)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 282)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 283)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 284)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 285)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._revert(bytes) (NodeID: 286)
  │     💬 Args: [revertData]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 287)
  │   💬 Args: [l.batch.length, 0, "Shouldn't have failed as batch was not empty"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 288)
  │   💬 Args: [l.liquidated.size(), 0, "Shouldn't have failed as there were liquidatable Troves"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 289)
  │     💬 Args: [l.liquidated]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 290)
  │       💬 Args: [set._base]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 291)
  │   💬 Args: [numTroves(i) - l.liquidated.size(), 0, "Shouldn't have failed as there were Troves left"]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 292)
  │ │   💬 Args: [l.liquidated]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 293)
  │ │     💬 Args: [set._base]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler.numTroves(uint256) (NodeID: 294)
  │     💬 Args: [i]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 295)
  │       💬 Args: [_troveIds[i]]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 296)
  │   💬 Args: ["Expected error: ", errorString]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 297)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 298)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 299)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 300)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging._log() (NodeID: 301)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log() (NodeID: 302)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 303)
  │       💬 Args: [abi.encodeWithSignature("log()")]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 304)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepColl(uint256,address,uint256) (NodeID: 305)
  │   💬 Args: [i, msg.sender, l.t.collGasComp]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepWETH(address,uint256) (NodeID: 306)
  │   💬 Args: [msg.sender, l.liquidated.size() * ETH_GAS_COMPENSATION]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 307)
  │     💬 Args: [l.liquidated]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 308)
  │       💬 Args: [set._base]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 309)
  │   💬 Args: [l.batchManagers]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 310)
  │     💬 Args: [set._base]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepBold(address,uint256) (NodeID: 311)
  │   💬 Args: [l.batchManagers.get(j), batchManagementFee[j]]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableAddressSetMethods.get(struct EnumerableAddressSet,uint256) (NodeID: 312)
  │     💬 Args: [l.batchManagers, j]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 313)
  │       💬 Args: [set._base, i]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: InvariantsTestHandler._resetLiquidation() (NodeID: 314)
      💬 Args: [no args]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.reset(struct EnumerableSet) (NodeID: 315)
    │   💬 Args: [_liquidation.remaining]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: EnumerableAddressSetMethods.reset(struct EnumerableAddressSet) (NodeID: 316)
    │   💬 Args: [_liquidation.liquidated]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.reset(struct EnumerableSet) (NodeID: 317)
    │     💬 Args: [set._base]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableAddressSetMethods.reset(struct EnumerableAddressSet) (NodeID: 318)
        💬 Args: [_liquidation.batchManagers]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.reset(struct EnumerableSet) (NodeID: 319)
          💬 Args: [set._base]
          👁️  Def: internal
```
