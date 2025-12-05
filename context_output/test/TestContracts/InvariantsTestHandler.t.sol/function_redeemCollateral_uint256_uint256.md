# Function: redeemCollateral(uint256,uint256)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `redeemCollateral(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 54053:6106:270

## Implementation

```solidity
function redeemCollateral(uint256 amount, uint256 maxIterationsPerCollateral) external {
    uint256 maxNumTroves = 0;
    for (uint256 i = 0; i < branches.length; ++i) {
        maxNumTroves = Math.max(numTroves(i), maxNumTroves);
    }
    amount = _bound(amount, 0, _handlerBold);
    maxIterationsPerCollateral = _bound(maxIterationsPerCollateral, 0, (maxNumTroves * 11) / 10);
    uint256 totalUnbacked = _getTotalUnbacked();
    if (totalUnbacked > 0) amount = Math.min(amount, totalUnbacked);
    uint256 oldBaseRate = _getBaseRate();
    uint256 boldSupply = boldToken.totalSupply();
    uint256 redemptionRate = _getRedemptionRate(oldBaseRate + _getBaseRateIncrease(boldSupply, amount));
    uint256[] memory pendingInterest = new uint256[](branches.length);
    for (uint256 i = 0; i < branches.length; ++i) {
        pendingInterest[i] = branches[i].activePool.calcPendingAggInterest();
    }
    (uint256 totalDebtRedeemed, mapping(uint256 => RedemptionTransientState) storage r) = _planRedemption(amount, maxIterationsPerCollateral, redemptionRate);
    assertLeDecimal(totalDebtRedeemed, amount, 18, "Total redeemed exceeds input amount");
    uint256[][] memory batchManagementFee = new uint256[][](branches.length);
    for (uint256 j = 0; j < branches.length; ++j) {
        batchManagementFee[j] = new uint256[](r[j].batchManagers.size());
        for (uint256 i = 0; i < r[j].batchManagers.size(); ++i) {
            batchManagementFee[j][i] = branches[j].troveManager.getLatestBatchData(r[j].batchManagers.get(i)).accruedManagementFee;
        }
    }
    info("redemption rate: ", redemptionRate.decimal());
    info("redeemed BOLD: ", totalDebtRedeemed.decimal());
    info("redeemed Troves: [");
    for (uint256 i = 0; i < branches.length; ++i) {
        info("  [", isShutdown[i] ? "/* shutdown */" : _labelsFrom(i, r[i].redeemed).join(", "), "],");
    }
    info("]");
    logCall("redeemCollateral", amount.decimal(), maxIterationsPerCollateral.toString());
    _dealBold(msg.sender, amount);
    string memory errorString;
    vm.prank(msg.sender);
    try collateralRegistry.redeemCollateral(amount, maxIterationsPerCollateral, redemptionRate) {
        assertGtDecimal(amount, 0, 18, "Should have failed as amount was zero");
        _baseRate = Math.min(oldBaseRate + _getBaseRateIncrease(boldSupply, totalDebtRedeemed), _100pct);
        _timeSinceLastRedemption %= ONE_MINUTE;
        for (uint256 j = 0; j < branches.length; ++j) {
            if (r[j].attemptedAmount == 0) continue;
            for (uint256 i = 0; i < r[j].redeemed.length; ++i) {
                Redeemed storage redeemed = r[j].redeemed[i];
                Trove memory trove = _troves[j][redeemed.troveId];
                trove.applyPending();
                if (redeemed.coll > trove.coll) {
                    assertApproxEq(redeemed.coll, trove.coll, 1e8, "Coll underflow");
                    trove.coll = 0;
                } else {
                    trove.coll -= redeemed.coll;
                }
                if (redeemed.debt > trove.debt) {
                    assertApproxEq(redeemed.debt, trove.debt, 1e8, "Debt underflow");
                    trove.debt = 0;
                } else {
                    trove.debt -= redeemed.debt;
                }
                _troves[j][redeemed.troveId] = trove;
                if (redeemed.becomesZombie) _zombieTroveIds[j].add(redeemed.troveId);
            }
            designatedVictimId[j] = r[j].newDesignatedVictimId;
            for (uint256 i = 0; i < r[j].batchManagers.size(); ++i) {
                _touchBatch(j, r[j].batchManagers.get(i));
            }
            _mintYield(j, pendingInterest[j], 0);
        }
    } catch Error(string memory reason) {
        errorString = reason;
        if (reason.equals("CollateralRegistry: Amount must be greater than zero")) {
            assertEqDecimal(amount, 0, 18, "Shouldn't have failed as amount was greater than zero");
        } else {
            revert(reason);
        }
    }
    if (bytes(errorString).length > 0) {
        if (_assumeNoExpectedFailures) vm.assume(false);
        info("Expected error: ", errorString);
        _log();
        _sweepBold(msg.sender, amount);
    } else {
        for (uint256 j = 0; j < branches.length; ++j) {
            uint256 collReceived = branches[j].collToken.balanceOf(msg.sender);
            assertApproxEqAbsDecimal(collReceived, r[j].totalCollRedeemed, 1e5, 18, "Wrong coll amount received");
            _sweepColl(j, msg.sender, collReceived);
            for (uint256 i = 0; i < r[j].batchManagers.size(); ++i) {
                _sweepBold(r[j].batchManagers.get(i), batchManagementFee[j][i]);
            }
        }
        uint256 remainingAmount = boldToken.balanceOf(msg.sender);
        assertApproxEqAbsDecimal(remainingAmount, amount - totalDebtRedeemed, 1e5, 18, "Wrong remaining BOLD");
        _sweepBold(msg.sender, remainingAmount);
    }
    _resetRedemption();
}
```

## Related Implementations

### max(uint256,uint256)

- **Kind**: internal
- **Source**: 413:104:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:max(uint256,uint256)`

```solidity
///  @dev Returns the largest of two numbers.
function max(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a > b) ? a : b;
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

### _getTotalUnbacked()

- **Kind**: internal
- **Source**: 107195:255:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_getTotalUnbacked()`

```solidity
function _getTotalUnbacked() internal view returns (uint256 totalUnbacked) {
    for (uint256 i = 0; i < branches.length; ++i) {
        if (isShutdown[i] || (_TCR(i) < SCR[i])) continue;
        totalUnbacked += _getUnbacked(i);
    }
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

### _getUnbacked(uint256)

- **Kind**: internal
- **Source**: 106978:211:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_getUnbacked(uint256)`

```solidity
function _getUnbacked(uint256 i) internal view returns (uint256) {
    uint256 sp = spBoldDeposits[i];
    uint256 totalDebt = _getTotalDebt(i);
    return (sp < totalDebt) ? (totalDebt - sp) : 0;
}
```

### _getTotalDebt(uint256)

- **Kind**: internal
- **Source**: 106836:136:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_getTotalDebt(uint256)`

```solidity
function _getTotalDebt(uint256 i) internal view returns (uint256) {
    return branches[i].troveManager.getEntireBranchDebt();
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

### _getBaseRate()

- **Kind**: internal
- **Source**: 106135:327:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_getBaseRate()`

```solidity
function _getBaseRate() internal view returns (uint256) {
    uint256 minutesSinceLastRedemption = _timeSinceLastRedemption / ONE_MINUTE;
    uint256 decaySinceLastRedemption = REDEMPTION_MINUTE_DECAY_FACTOR.pow(minutesSinceLastRedemption);
    return (_baseRate * decaySinceLastRedemption) / DECIMAL_PRECISION;
}
```

### pow(uint256,uint256)

- **Kind**: free-function
- **Source**: 346:416:290
- **Link**: `test/Utils/Math.sol:pow(uint256,uint256)`

```solidity
function pow(uint256 decimalBase, uint256 intExponent) pure returns (uint256) {
    if (intExponent == 0) return DECIMAL_PRECISION;
    if (intExponent == 1) return decimalBase;
    uint256 x = decimalBase;
    uint256 y = DECIMAL_PRECISION;
    for (; intExponent > 1; intExponent >>= 1) {
        if ((intExponent & 1) == 1) y = roundedMul(x, y);
        x = roundedMul(x, x);
    }
    return roundedMul(x, y);
}
```

### roundedMul(uint256,uint256)

- **Kind**: free-function
- **Source**: 124:132:290
- **Link**: `test/Utils/Math.sol:roundedMul(uint256,uint256)`

```solidity
function roundedMul(uint256 x, uint256 y) pure returns (uint256) {
    return ((x * y) + (DECIMAL_PRECISION / 2)) / DECIMAL_PRECISION;
}
```

### _getRedemptionRate(uint256)

- **Kind**: internal
- **Source**: 106678:152:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_getRedemptionRate(uint256)`

```solidity
function _getRedemptionRate(uint256 baseRate) internal pure returns (uint256) {
    return Math.min(REDEMPTION_FEE_FLOOR + baseRate, _100pct);
}
```

### _getBaseRateIncrease(uint256,uint256)

- **Kind**: internal
- **Source**: 106468:204:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_getBaseRateIncrease(uint256,uint256)`

```solidity
function _getBaseRateIncrease(uint256 boldSupply, uint256 redeemed) internal pure returns (uint256) {
    return (boldSupply > 0) ? (((redeemed * DECIMAL_PRECISION) / boldSupply) / REDEMPTION_BETA) : 0;
}
```

### _planRedemption(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 119797:2153:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_planRedemption(uint256,uint256,uint256)`

```solidity
function _planRedemption(uint256 amount, uint256 maxIterationsPerCollateral, uint256 feePct) internal returns (uint256 totalDebtRedeemed, mapping(uint256 => RedemptionTransientState) storage r) {
    uint256 totalProportions = 0;
    uint256[] memory proportions = new uint256[](branches.length);
    r = _redemption;
    for (uint256 i = 0; i < branches.length; ++i) {
        if (isShutdown[i] || (_TCR(i) < SCR[i])) continue;
        totalProportions += proportions[i] = _getUnbacked(i);
    }
    if (totalProportions == 0) {
        for (uint256 i = 0; i < branches.length; ++i) {
            if (isShutdown[i] || (_TCR(i) < SCR[i])) continue;
            totalProportions += proportions[i] = _getTotalDebt(i);
        }
    }
    for (uint256 i = 0; i < branches.length; ++i) {
        r[i].newDesignatedVictimId = designatedVictimId[i];
        if (totalProportions == 0) continue;
        r[i].attemptedAmount = (amount * proportions[i]) / totalProportions;
        amount -= r[i].attemptedAmount;
        totalProportions -= proportions[i];
        if (r[i].attemptedAmount == 0) continue;
        uint256 remainingAmount = r[i].attemptedAmount;
        uint256 lastTrove = branches[i].sortedTroves.getPrev(0);
        (uint256 troveId, uint256 nextTroveId) = (designatedVictimId[i] != 0) ? (designatedVictimId[i], lastTrove) : (lastTrove, branches[i].sortedTroves.getPrev(lastTrove));
        for (uint256 j = 0; (j < maxIterationsPerCollateral) || (maxIterationsPerCollateral == 0); ++j) {
            if ((remainingAmount == 0) || (troveId == 0)) break;
            uint256 debtRedeemed = _planOneRedemption(i, troveId, remainingAmount, feePct);
            totalDebtRedeemed += debtRedeemed;
            remainingAmount -= debtRedeemed;
            troveId = nextTroveId;
            nextTroveId = branches[i].sortedTroves.getPrev(nextTroveId);
        }
    }
}
```

### _planOneRedemption(uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 118543:1248:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_planOneRedemption(uint256,uint256,uint256,uint256)`

```solidity
function _planOneRedemption(uint256 i, uint256 troveId, uint256 remainingAmount, uint256 feePct) internal returns (uint256 debtRedeemed) {
    LatestTroveData memory trove = branches[i].troveManager.getLatestTroveData(troveId);
    if (_ICR(i, trove) < _100pct) return 0;
    debtRedeemed = Math.min(remainingAmount, trove.entireDebt);
    uint256 newDebt = trove.entireDebt - debtRedeemed;
    uint256 collRedeemedPlusFee = (debtRedeemed * DECIMAL_PRECISION) / _price[i];
    uint256 fee = (collRedeemedPlusFee * feePct) / _100pct;
    uint256 collRedeemed = collRedeemedPlusFee - fee;
    mapping(uint256 => RedemptionTransientState) storage r = _redemption;
    r[i].redeemed.push(Redeemed({troveId: troveId, coll: collRedeemed, debt: debtRedeemed, becomesZombie: newDebt < MIN_DEBT}));
    r[i].totalCollRedeemed += collRedeemed;
    address batchManager = _batchManagerOf[i][troveId];
    if (batchManager != address(0)) r[i].batchManagers.add(batchManager);
    if ((troveId == designatedVictimId[i]) && (newDebt == 0)) r[i].newDesignatedVictimId = 0;
    if ((0 < newDebt) && (newDebt < MIN_DEBT)) r[i].newDesignatedVictimId = troveId;
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

### add(struct EnumerableAddressSet,address)

- **Kind**: internal
- **Source**: 3085:130:288
- **Link**: `test/Utils/EnumerableSet.sol:EnumerableAddressSetMethods:add(struct EnumerableAddressSet,address)`

```solidity
function add(EnumerableAddressSet storage set, address element) internal {
    set._base.add(uint256(uint160(element)));
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

### assertLeDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 14710:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLeDecimal(uint256,uint256,uint256,string)`

```solidity
function assertLeDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertLeDecimal(left, right, decimals, err);
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

### info(string)

- **Kind**: internal
- **Source**: 2769:76:289
- **Link**: `test/Utils/Logging.sol:Logging:info(string)`

```solidity
function info(string memory a) internal pure {
    _log("// ", a);
}
```

### _log(string,string)

- **Kind**: internal
- **Source**: 289:111:289
- **Link**: `test/Utils/Logging.sol:Logging:_log(string,string)`

```solidity
function _log(string memory a, string memory b) internal pure {
    console.log(string.concat(a, b));
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

### _labelsFrom(uint256,struct InvariantsTestHandler.Redeemed[])

- **Kind**: internal
- **Source**: 110093:313:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_labelsFrom(uint256,struct InvariantsTestHandler.Redeemed[])`

```solidity
function _labelsFrom(uint256 i, Redeemed[] storage redeemed) internal view returns (string[] memory ret) {
    ret = new string[](redeemed.length);
    for (uint256 j = 0; j < redeemed.length; ++j) {
        ret[j] = vm.getLabel(branches[i].troveManager.ownerOf(redeemed[j].troveId));
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

### logCall(string,string,string)

- **Kind**: internal
- **Source**: 777:206:251
- **Link**: `test/TestContracts/BaseHandler.sol:BaseHandler:logCall(string,string,string)`

```solidity
function logCall(string memory functionName, string memory a, string memory b) internal view {
    _logCaller();
    _log(_callPrefix(), functionName, "(", _csv([a, b]), ");");
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

### _csv(string[2])

- **Kind**: internal
- **Source**: 3581:136:289
- **Link**: `test/Utils/Logging.sol:Logging:_csv(string[2])`

```solidity
function _csv(string[2] memory strs) internal pure returns (string memory) {
    return string.concat(strs[0], ", ", strs[1]);
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

### assertGtDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 13526:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGtDecimal(uint256,uint256,uint256,string)`

```solidity
function assertGtDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertGtDecimal(left, right, decimals, err);
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

### assertApproxEq(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 1082:302:250
- **Link**: `test/TestContracts/Assertions.sol:Assertions:assertApproxEq(uint256,uint256,uint256,string)`

```solidity
function assertApproxEq(uint256 a, uint256 b, uint256 maxPercentDelta, string memory err) internal pure {
    if (b < 1e18) {
        assertApproxEqAbsDecimal(a, b, maxPercentDelta, 18, err);
    } else {
        assertApproxEqRelDecimal(a, b, maxPercentDelta, 18, err);
    }
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

### assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 19242:338:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string)`

```solidity
function assertApproxEqRelDecimal(uint256 left, uint256 right, uint256 maxPercentDelta, uint256 decimals, string memory err) virtual internal pure {
    vm.assertApproxEqRelDecimal(left, right, maxPercentDelta, decimals, err);
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

### equals(string,string)

- **Kind**: internal
- **Source**: 567:145:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:equals(string,string)`

```solidity
function equals(string memory a, string memory b) internal pure returns (bool) {
    return keccak256(bytes(a)) == keccak256(bytes(b));
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

### _resetRedemption()

- **Kind**: internal
- **Source**: 121956:195:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_resetRedemption()`

```solidity
function _resetRedemption() internal {
    for (uint256 i = 0; i < branches.length; ++i) {
        _redemption[i].batchManagers.reset();
        delete _redemption[i];
    }
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

## External Calls

- **IBoldToken::totalSupply()**
- **IActivePool::calcPendingAggInterest()**
- **ITroveManagerTester::getLatestBatchData(address)**
- **Vm::prank(address)**
- **ICollateralRegistry::redeemCollateral(uint256,uint256,uint256)**
- **Vm::assume(bool)**
- **IERC20Metadata::balanceOf(address)**
- **IBoldToken::balanceOf(address)**

## State Variable Reads

- **_handlerBold** (`uint256`)
- **isShutdown** (`mapping(uint256 => bool)`)
- **_troves** (`mapping(uint256 => mapping(uint256 => struct Trove))`)
- **_assumeNoExpectedFailures** (`bool`)
- **_troveIds** (`mapping(uint256 => struct EnumerableSet)`)
- **UINT256_MAX** (`uint256`)
- **SCR** (`mapping(uint256 => uint256)`)
- **_price** (`mapping(uint256 => uint256)`)
- **spBoldDeposits** (`mapping(uint256 => uint256)`)
- **_timeSinceLastRedemption** (`uint256`)
- **_baseRate** (`uint256`)
- **_redemption** (`mapping(uint256 => struct InvariantsTestHandler.RedemptionTransientState)`)
- **designatedVictimId** (`mapping(uint256 => uint256)`)
- **_batchManagerOf** (`mapping(uint256 => mapping(uint256 => address))`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **ONE** (`uint256`)
- **DECIMAL_UNIT** (`string`)
- **DECIMAL_SEPARATOR** (`string`)
- **GROUP_DIGITS** (`uint256`)
- **GROUP_SEPARATOR** (`bytes1`)
- **_batches** (`mapping(uint256 => mapping(address => struct InvariantsTestHandler.Batch))`)

## State Variable Writes

- **_baseRate** (`uint256`)
- **_timeSinceLastRedemption** (`uint256`)
- **_troves** (`mapping(uint256 => mapping(uint256 => struct Trove))`)
- **_zombieTroveIds** (`mapping(uint256 => struct EnumerableSet)`)
- **designatedVictimId** (`mapping(uint256 => uint256)`)
- **_handlerBold** (`uint256`)
- **_batches** (`mapping(uint256 => mapping(address => struct InvariantsTestHandler.Batch))`)
- **spBoldYield** (`mapping(uint256 => uint256)`)
- **_pendingInterest** (`mapping(uint256 => uint256)`)
- **_redemption** (`mapping(uint256 => struct InvariantsTestHandler.RedemptionTransientState)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.redeemCollateral(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Math.max(uint256,uint256) (NodeID: 1)
  │   💬 Args: [numTroves(i), maxNumTroves]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler.numTroves(uint256) (NodeID: 2)
  │     💬 Args: [i]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 3)
  │       💬 Args: [_troveIds[i]]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 4)
  │   💬 Args: [amount, 0, _handlerBold]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 5)
  │   💬 Args: [maxIterationsPerCollateral, 0, (maxNumTroves * 11) / 10]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._getTotalUnbacked() (NodeID: 6)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._TCR(uint256) (NodeID: 7)
  │ │   💬 Args: [i]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: InvariantsTestHandler._TCR(uint256,int256,int256,uint256) (NodeID: 8)
  │ │     💬 Args: [i, 0, 0, 0]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 9)
  │ │   │   💬 Args: [branches[i].troveManager.getEntireBranchColl(), collDelta]
  │ │   │   👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 10)
  │ │   │   💬 Args: [branches[i].troveManager.getEntireBranchDebt(), debtDelta]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 11)
  │ │       💬 Args: [i, coll, debt]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._getUnbacked(uint256) (NodeID: 12)
  │     💬 Args: [i]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: InvariantsTestHandler._getTotalDebt(uint256) (NodeID: 13)
  │       💬 Args: [i]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 14)
  │   💬 Args: [amount, totalUnbacked]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._getBaseRate() (NodeID: 15)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.pow(uint256,uint256) (NodeID: 16)
  │     💬 Args: [REDEMPTION_MINUTE_DECAY_FACTOR, minutesSinceLastRedemption]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.roundedMul(uint256,uint256) (NodeID: 17)
  │   │   💬 Args: [x, y]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.roundedMul(uint256,uint256) (NodeID: 18)
  │   │   💬 Args: [x, x]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Unknown.roundedMul(uint256,uint256) (NodeID: 19)
  │       💬 Args: [x, y]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._getRedemptionRate(uint256) (NodeID: 20)
  │   💬 Args: [oldBaseRate + _getBaseRateIncrease(boldSupply, amount)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._getBaseRateIncrease(uint256,uint256) (NodeID: 22)
  │ │   💬 Args: [boldSupply, amount]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 21)
  │     💬 Args: [REDEMPTION_FEE_FLOOR + baseRate, _100pct]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._planRedemption(uint256,uint256,uint256) (NodeID: 23)
  │   💬 Args: [amount, maxIterationsPerCollateral, redemptionRate]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._TCR(uint256) (NodeID: 24)
  │ │   💬 Args: [i]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: InvariantsTestHandler._TCR(uint256,int256,int256,uint256) (NodeID: 25)
  │ │     💬 Args: [i, 0, 0, 0]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 26)
  │ │   │   💬 Args: [branches[i].troveManager.getEntireBranchColl(), collDelta]
  │ │   │   👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 27)
  │ │   │   💬 Args: [branches[i].troveManager.getEntireBranchDebt(), debtDelta]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 28)
  │ │       💬 Args: [i, coll, debt]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._getUnbacked(uint256) (NodeID: 29)
  │ │   💬 Args: [i]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: InvariantsTestHandler._getTotalDebt(uint256) (NodeID: 30)
  │ │     💬 Args: [i]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._TCR(uint256) (NodeID: 31)
  │ │   💬 Args: [i]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: InvariantsTestHandler._TCR(uint256,int256,int256,uint256) (NodeID: 32)
  │ │     💬 Args: [i, 0, 0, 0]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 33)
  │ │   │   💬 Args: [branches[i].troveManager.getEntireBranchColl(), collDelta]
  │ │   │   👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 34)
  │ │   │   💬 Args: [branches[i].troveManager.getEntireBranchDebt(), debtDelta]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 35)
  │ │       💬 Args: [i, coll, debt]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._getTotalDebt(uint256) (NodeID: 36)
  │ │   💬 Args: [i]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._planOneRedemption(uint256,uint256,uint256,uint256) (NodeID: 37)
  │     💬 Args: [i, troveId, remainingAmount, feePct]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: InvariantsTestHandler._ICR(uint256,struct LatestTroveData) (NodeID: 38)
  │   │   💬 Args: [i, trove]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: InvariantsTestHandler._ICR(uint256,int256,int256,uint256,struct LatestTroveData) (NodeID: 39)
  │   │     💬 Args: [i, 0, 0, 0, trove]
  │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 40)
  │   │   │   💬 Args: [trove.entireColl, collDelta]
  │   │   │   👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 41)
  │   │   │   💬 Args: [trove.entireDebt, debtDelta]
  │   │   │   👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 42)
  │   │       💬 Args: [i, coll, debt]
  │   │       👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 43)
  │   │   💬 Args: [remainingAmount, trove.entireDebt]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableAddressSetMethods.add(struct EnumerableAddressSet,address) (NodeID: 44)
  │       💬 Args: [r[i].batchManagers, batchManager]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: EnumerableSetMethods.add(struct EnumerableSet,uint256) (NodeID: 45)
  │         💬 Args: [set._base, uint256(uint160(element))]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 46)
  │           💬 Args: [set, element]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLeDecimal(uint256,uint256,uint256,string) (NodeID: 47)
  │   💬 Args: [totalDebtRedeemed, amount, 18, "Total redeemed exceeds input amount"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 48)
  │   💬 Args: [r[j].batchManagers]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 49)
  │     💬 Args: [set._base]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 50)
  │   💬 Args: [r[j].batchManagers]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 51)
  │     💬 Args: [set._base]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableAddressSetMethods.get(struct EnumerableAddressSet,uint256) (NodeID: 52)
  │   💬 Args: [r[j].batchManagers, i]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 53)
  │     💬 Args: [set._base, i]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 54)
  │   💬 Args: ["redemption rate: ", redemptionRate.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 59)
  │ │   💬 Args: [redemptionRate]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 60)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 61)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 62)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 63)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 64)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 65)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 66)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 67)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 68)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 69)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 70)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 71)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 72)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 73)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 74)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 75)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 76)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 77)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 78)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 79)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 80)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 81)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 55)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 56)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 57)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 58)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 82)
  │   💬 Args: ["redeemed BOLD: ", totalDebtRedeemed.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 87)
  │ │   💬 Args: [totalDebtRedeemed]
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
  ├─ [1] ⚙️ FUNCTION: Logging.info(string) (NodeID: 110)
  │   💬 Args: ["redeemed Troves: ["]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 111)
  │     💬 Args: ["// ", a]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 112)
  │       💬 Args: [string.concat(a, b)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 113)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 114)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string,string) (NodeID: 115)
  │   💬 Args: ["  [", isShutdown[i] ? "/* shutdown */" : _labelsFrom(i, r[i].redeemed).join(", "), "],"]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._labelsFrom(uint256,struct InvariantsTestHandler.Redeemed[]) (NodeID: 120)
  │ │   💬 Args: [i, r[i].redeemed]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.join(string[],string) (NodeID: 121)
  │ │   💬 Args: [_labelsFrom(i, r[i].redeemed), ", "]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string,string) (NodeID: 116)
  │     💬 Args: ["// ", a, b, c]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 117)
  │       💬 Args: [string.concat(a, b, c, d)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 118)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 119)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string) (NodeID: 122)
  │   💬 Args: ["]"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 123)
  │     💬 Args: ["// ", a]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 124)
  │       💬 Args: [string.concat(a, b)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 125)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 126)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseHandler.logCall(string,string,string) (NodeID: 127)
  │   💬 Args: ["redeemCollateral", amount.decimal(), maxIterationsPerCollateral.toString()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 143)
  │ │   💬 Args: [amount]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 144)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 145)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 146)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 147)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 148)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 149)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 150)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 151)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 152)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 153)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 154)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 155)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 156)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 157)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 158)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 159)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 160)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 161)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 162)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 163)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 164)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 165)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 166)
  │ │   💬 Args: [maxIterationsPerCollateral]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 167)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseHandler._logCaller() (NodeID: 128)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 129)
  │ │     💬 Args: ["vm.prank(", vm.getLabel(msg.sender), ");"]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 130)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 131)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 132)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging._log(string,string,string,string,string) (NodeID: 133)
  │ │   💬 Args: [_callPrefix(), functionName, "(", _csv([a, b]), ");"]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseHandler._callPrefix() (NodeID: 137)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Logging._csv(string[2]) (NodeID: 138)
  │ │ │   💬 Args: [[a, b]]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 134)
  │ │     💬 Args: [string.concat(a, b, c, d, e)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 135)
  │ │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 136)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log() (NodeID: 139)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log() (NodeID: 140)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 141)
  │         💬 Args: [abi.encodeWithSignature("log()")]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 142)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._dealBold(address,uint256) (NodeID: 168)
  │   💬 Args: [msg.sender, amount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGtDecimal(uint256,uint256,uint256,string) (NodeID: 169)
  │   💬 Args: [amount, 0, 18, "Should have failed as amount was zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 170)
  │   💬 Args: [oldBaseRate + _getBaseRateIncrease(boldSupply, totalDebtRedeemed), _100pct]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._getBaseRateIncrease(uint256,uint256) (NodeID: 171)
  │     💬 Args: [boldSupply, totalDebtRedeemed]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveMethods.applyPending(struct Trove) (NodeID: 172)
  │   💬 Args: [trove]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingRedist(struct Trove) (NodeID: 173)
  │ │   💬 Args: [trove]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingInterest(struct Trove) (NodeID: 174)
  │ │   💬 Args: [trove]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingBatchManagementFee(struct Trove) (NodeID: 175)
  │     💬 Args: [trove]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Assertions.assertApproxEq(uint256,uint256,uint256,string) (NodeID: 176)
  │   💬 Args: [redeemed.coll, trove.coll, 1e8, "Coll underflow"]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 177)
  │ │   💬 Args: [a, b, maxPercentDelta, 18, err]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 178)
  │     💬 Args: [a, b, maxPercentDelta, 18, err]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Assertions.assertApproxEq(uint256,uint256,uint256,string) (NodeID: 179)
  │   💬 Args: [redeemed.debt, trove.debt, 1e8, "Debt underflow"]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 180)
  │ │   💬 Args: [a, b, maxPercentDelta, 18, err]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 181)
  │     💬 Args: [a, b, maxPercentDelta, 18, err]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSetMethods.add(struct EnumerableSet,uint256) (NodeID: 182)
  │   💬 Args: [_zombieTroveIds[j], redeemed.troveId]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 183)
  │     💬 Args: [set, element]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 184)
  │   💬 Args: [r[j].batchManagers]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 185)
  │     💬 Args: [set._base]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._touchBatch(uint256,address) (NodeID: 186)
  │   💬 Args: [j, r[j].batchManagers.get(i)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableAddressSetMethods.get(struct EnumerableAddressSet,uint256) (NodeID: 191)
  │ │   💬 Args: [r[j].batchManagers, i]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 192)
  │ │     💬 Args: [set._base, i]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 187)
  │ │   💬 Args: [_batches[i][batchManager].troves]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 188)
  │ │   💬 Args: [_batches[i][batchManager].troves, j]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingInterest(struct Trove) (NodeID: 189)
  │ │   💬 Args: [trove]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingBatchManagementFee(struct Trove) (NodeID: 190)
  │     💬 Args: [trove]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._mintYield(uint256,uint256,uint256) (NodeID: 193)
  │   💬 Args: [j, pendingInterest[j], 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StringFormatting.equals(string,string) (NodeID: 194)
  │   💬 Args: [reason, "CollateralRegistry: Amount must be greater than zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 195)
  │   💬 Args: [amount, 0, 18, "Shouldn't have failed as amount was greater than zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 196)
  │   💬 Args: ["Expected error: ", errorString]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 197)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 198)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 199)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 200)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging._log() (NodeID: 201)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log() (NodeID: 202)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 203)
  │       💬 Args: [abi.encodeWithSignature("log()")]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 204)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepBold(address,uint256) (NodeID: 205)
  │   💬 Args: [msg.sender, amount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 206)
  │   💬 Args: [collReceived, r[j].totalCollRedeemed, 1e5, 18, "Wrong coll amount received"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepColl(uint256,address,uint256) (NodeID: 207)
  │   💬 Args: [j, msg.sender, collReceived]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 208)
  │   💬 Args: [r[j].batchManagers]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 209)
  │     💬 Args: [set._base]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepBold(address,uint256) (NodeID: 210)
  │   💬 Args: [r[j].batchManagers.get(i), batchManagementFee[j][i]]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableAddressSetMethods.get(struct EnumerableAddressSet,uint256) (NodeID: 211)
  │     💬 Args: [r[j].batchManagers, i]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 212)
  │       💬 Args: [set._base, i]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 213)
  │   💬 Args: [remainingAmount, amount - totalDebtRedeemed, 1e5, 18, "Wrong remaining BOLD"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepBold(address,uint256) (NodeID: 214)
  │   💬 Args: [msg.sender, remainingAmount]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: InvariantsTestHandler._resetRedemption() (NodeID: 215)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableAddressSetMethods.reset(struct EnumerableAddressSet) (NodeID: 216)
        💬 Args: [_redemption[i].batchManagers]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.reset(struct EnumerableSet) (NodeID: 217)
          💬 Args: [set._base]
          👁️  Def: internal
```
