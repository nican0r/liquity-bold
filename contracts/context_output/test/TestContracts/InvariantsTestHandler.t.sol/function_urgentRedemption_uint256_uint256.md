# Function: urgentRedemption(uint256,uint256)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `urgentRedemption(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 61879:4964:270

## Implementation

```solidity
function urgentRedemption(uint256 i, uint256 amount) external {
    i = _bound(i, 0, branches.length - 1);
    amount = _bound(amount, 0, _handlerBold);
    TestDeployer.LiquityContractsDev memory c = branches[i];
    uint256 pendingInterest = c.activePool.calcPendingAggInterest();
    UrgentRedemptionTransientState storage r = _planUrgentRedemption(i, amount);
    assertLeDecimal(r.totalDebtRedeemed, amount, 18, "Total redeemed exceeds input amount");
    uint256[] memory batchManagementFee = new uint256[](r.batchManagers.size());
    for (uint256 j = 0; j < r.batchManagers.size(); ++j) {
        batchManagementFee[j] = c.troveManager.getLatestBatchData(r.batchManagers.get(j)).accruedManagementFee;
    }
    info("redeemed BOLD: ", r.totalDebtRedeemed.decimal());
    info("batch: [", _labelsFrom(r.batch).join(", "), "]");
    logCall("urgentRedemption", i.toString(), amount.decimal());
    _dealBold(msg.sender, amount);
    string memory errorString;
    vm.prank(msg.sender);
    try c.troveManager.urgentRedemption(amount, _troveIdsFrom(i, r.batch), r.totalCollRedeemed) {
        assertTrue(isShutdown[i], "Should have failed as branch hadn't been shut down");
        assertGtDecimal(amount, 0, 18, "Should have failed as amount was zero");
        for (uint256 j = 0; j < r.redeemed.length; ++j) {
            Redeemed storage redeemed = r.redeemed[j];
            Trove memory trove = _troves[i][redeemed.troveId];
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
            _troves[i][redeemed.troveId] = trove;
        }
        for (uint256 j = 0; j < r.batchManagers.size(); ++j) {
            _touchBatch(i, r.batchManagers.get(j));
        }
        _mintYield(i, pendingInterest, 0);
    } catch (bytes memory revertData) {
        bytes4 selector;
        (selector, errorString) = _decodeCustomError(revertData);
        if (selector == TroveManager.NotShutDown.selector) {
            assertFalse(isShutdown[i], "Shouldn't have failed as branch had been shut down");
        } else if (selector == TroveManager.ZeroAmount.selector) {
            assertEqDecimal(amount, 0, 18, "Shouldn't have failed as amount was greater than zero");
        } else if (selector == TroveManager.MinCollNotReached.selector) {
            uint256 collReceived = uint256(bytes32(revertData.slice(4)));
            assertLtDecimal(collReceived, r.totalCollRedeemed, 18, "Shouldn't have failed as min coll was reached");
            assertApproxEqAbsDecimal(collReceived, r.totalCollRedeemed, 1e5, 18, "Wrong coll amount received");
        } else {
            revert(string.concat("Unexpected error: ", errorString));
        }
    }
    if (bytes(errorString).length > 0) {
        if (_assumeNoExpectedFailures) vm.assume(false);
        info("Expected error: ", errorString);
        _log();
        _sweepBold(msg.sender, amount);
    } else {
        uint256 collReceived = branches[i].collToken.balanceOf(msg.sender);
        assertApproxEqAbsDecimal(collReceived, r.totalCollRedeemed, 1e5, 18, "Wrong coll amount received");
        _sweepColl(i, msg.sender, collReceived);
        for (uint256 j = 0; j < r.batchManagers.size(); ++j) {
            _sweepBold(r.batchManagers.get(j), batchManagementFee[j]);
        }
        uint256 remainingAmount = boldToken.balanceOf(msg.sender);
        assertApproxEqAbsDecimal(remainingAmount, amount - r.totalDebtRedeemed, 1e5, 18, "Wrong remaining BOLD");
        _sweepBold(msg.sender, remainingAmount);
    }
    _resetUrgentRedemption();
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

### _planUrgentRedemption(uint256,uint256)

- **Kind**: internal
- **Source**: 122276:1511:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_planUrgentRedemption(uint256,uint256)`

```solidity
function _planUrgentRedemption(uint256 i, uint256 amount) internal returns (UrgentRedemptionTransientState storage r) {
    r = _urgentRedemption;
    for (uint256 j = 0; j < r.batch.length; ++j) {
        if (amount == 0) break;
        uint256 troveId = _troveIdOf(i, r.batch[j]);
        if (!_troveIds[i].has(troveId)) continue;
        if (r.redeemedIds.has(troveId)) continue;
        r.redeemedIds.add(troveId);
        LatestTroveData memory trove = branches[i].troveManager.getLatestTroveData(troveId);
        if (trove.entireDebt == 0) continue;
        uint256 debtRedeemed = Math.min(amount, trove.entireDebt);
        uint256 collRedeemed = (debtRedeemed * (DECIMAL_PRECISION + URGENT_REDEMPTION_BONUS)) / _price[i];
        if (collRedeemed > trove.entireColl) {
            collRedeemed = trove.entireColl;
            debtRedeemed = (trove.entireColl * _price[i]) / (DECIMAL_PRECISION + URGENT_REDEMPTION_BONUS);
        }
        r.redeemed.push(Redeemed({troveId: troveId, coll: collRedeemed, debt: debtRedeemed, becomesZombie: false}));
        address batchManager = _batchManagerOf[i][troveId];
        if (batchManager != address(0)) r.batchManagers.add(batchManager);
        r.totalCollRedeemed += collRedeemed;
        r.totalDebtRedeemed += debtRedeemed;
        amount -= debtRedeemed;
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

### has(struct EnumerableSet,uint256)

- **Kind**: internal
- **Source**: 372:136:288
- **Link**: `test/Utils/EnumerableSet.sol:EnumerableSetMethods:has(struct EnumerableSet,uint256)`

```solidity
function has(EnumerableSet storage set, uint256 element) internal view returns (bool) {
    return set._indexOf[element] != 0;
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

### add(struct EnumerableAddressSet,address)

- **Kind**: internal
- **Source**: 3085:130:288
- **Link**: `test/Utils/EnumerableSet.sol:EnumerableAddressSetMethods:add(struct EnumerableAddressSet,address)`

```solidity
function add(EnumerableAddressSet storage set, address element) internal {
    set._base.add(uint256(uint160(element)));
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

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 1905:115:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    vm.assertFalse(data, err);
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

### assertLtDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 12342:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLtDecimal(uint256,uint256,uint256,string)`

```solidity
function assertLtDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertLtDecimal(left, right, decimals, err);
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

### _resetUrgentRedemption()

- **Kind**: internal
- **Source**: 123793:180:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_resetUrgentRedemption()`

```solidity
function _resetUrgentRedemption() internal {
    _urgentRedemption.redeemedIds.reset();
    _urgentRedemption.batchManagers.reset();
    delete _urgentRedemption;
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
- **ITroveManagerTester::urgentRedemption(uint256,uint256[],uint256)**
- **Vm::assume(bool)**
- **IERC20Metadata::balanceOf(address)**
- **IBoldToken::balanceOf(address)**

## State Variable Reads

- **_handlerBold** (`uint256`)
- **isShutdown** (`mapping(uint256 => bool)`)
- **_troves** (`mapping(uint256 => mapping(uint256 => struct Trove))`)
- **_assumeNoExpectedFailures** (`bool`)
- **UINT256_MAX** (`uint256`)
- **_urgentRedemption** (`struct InvariantsTestHandler.UrgentRedemptionTransientState`)
- **_troveIds** (`mapping(uint256 => struct EnumerableSet)`)
- **_price** (`mapping(uint256 => uint256)`)
- **_batchManagerOf** (`mapping(uint256 => mapping(uint256 => address))`)
- **_troveIndexOf** (`mapping(uint256 => mapping(address => uint256))`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **ONE** (`uint256`)
- **DECIMAL_UNIT** (`string`)
- **DECIMAL_SEPARATOR** (`string`)
- **GROUP_DIGITS** (`uint256`)
- **GROUP_SEPARATOR** (`bytes1`)
- **_batches** (`mapping(uint256 => mapping(address => struct InvariantsTestHandler.Batch))`)

## State Variable Writes

- **_troves** (`mapping(uint256 => mapping(uint256 => struct Trove))`)
- **_handlerBold** (`uint256`)
- **_batches** (`mapping(uint256 => mapping(address => struct InvariantsTestHandler.Batch))`)
- **spBoldYield** (`mapping(uint256 => uint256)`)
- **_pendingInterest** (`mapping(uint256 => uint256)`)
- **_urgentRedemption** (`struct InvariantsTestHandler.UrgentRedemptionTransientState`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.urgentRedemption(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [i, 0, branches.length - 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 2)
  │   💬 Args: [amount, 0, _handlerBold]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._planUrgentRedemption(uint256,uint256) (NodeID: 3)
  │   💬 Args: [i, amount]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._troveIdOf(uint256,address) (NodeID: 4)
  │ │   💬 Args: [i, r.batch[j]]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 5)
  │ │   💬 Args: [_troveIds[i], troveId]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 6)
  │ │   💬 Args: [r.redeemedIds, troveId]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.add(struct EnumerableSet,uint256) (NodeID: 7)
  │ │   💬 Args: [r.redeemedIds, troveId]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 8)
  │ │     💬 Args: [set, element]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 9)
  │ │   💬 Args: [amount, trove.entireDebt]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableAddressSetMethods.add(struct EnumerableAddressSet,address) (NodeID: 10)
  │     💬 Args: [r.batchManagers, batchManager]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.add(struct EnumerableSet,uint256) (NodeID: 11)
  │       💬 Args: [set._base, uint256(uint160(element))]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 12)
  │         💬 Args: [set, element]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLeDecimal(uint256,uint256,uint256,string) (NodeID: 13)
  │   💬 Args: [r.totalDebtRedeemed, amount, 18, "Total redeemed exceeds input amount"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 14)
  │   💬 Args: [r.batchManagers]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 15)
  │     💬 Args: [set._base]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 16)
  │   💬 Args: [r.batchManagers]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 17)
  │     💬 Args: [set._base]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableAddressSetMethods.get(struct EnumerableAddressSet,uint256) (NodeID: 18)
  │   💬 Args: [r.batchManagers, j]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 19)
  │     💬 Args: [set._base, i]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 20)
  │   💬 Args: ["redeemed BOLD: ", r.totalDebtRedeemed.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 25)
  │ │   💬 Args: [r.totalDebtRedeemed]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 26)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 27)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 28)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 29)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 30)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 31)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 32)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 33)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 34)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 35)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 36)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 37)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 38)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 39)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 40)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 41)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 42)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 43)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 44)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 45)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 46)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 47)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 21)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 22)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 23)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 24)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string,string) (NodeID: 48)
  │   💬 Args: ["batch: [", _labelsFrom(r.batch).join(", "), "]"]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._labelsFrom(address[]) (NodeID: 53)
  │ │   💬 Args: [r.batch]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.join(string[],string) (NodeID: 54)
  │ │   💬 Args: [_labelsFrom(r.batch), ", "]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string,string) (NodeID: 49)
  │     💬 Args: ["// ", a, b, c]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 50)
  │       💬 Args: [string.concat(a, b, c, d)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 51)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 52)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseHandler.logCall(string,string,string) (NodeID: 55)
  │   💬 Args: ["urgentRedemption", i.toString(), amount.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 71)
  │ │   💬 Args: [i]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 72)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 73)
  │ │   💬 Args: [amount]
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
  │ ├─ [2] ⚙️ FUNCTION: BaseHandler._logCaller() (NodeID: 56)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 57)
  │ │     💬 Args: ["vm.prank(", vm.getLabel(msg.sender), ");"]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 58)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 59)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 60)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging._log(string,string,string,string,string) (NodeID: 61)
  │ │   💬 Args: [_callPrefix(), functionName, "(", _csv([a, b]), ");"]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseHandler._callPrefix() (NodeID: 65)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Logging._csv(string[2]) (NodeID: 66)
  │ │ │   💬 Args: [[a, b]]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 62)
  │ │     💬 Args: [string.concat(a, b, c, d, e)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 63)
  │ │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 64)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log() (NodeID: 67)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log() (NodeID: 68)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 69)
  │         💬 Args: [abi.encodeWithSignature("log()")]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 70)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._dealBold(address,uint256) (NodeID: 96)
  │   💬 Args: [msg.sender, amount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._troveIdsFrom(uint256,address[]) (NodeID: 97)
  │   💬 Args: [i, r.batch]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._troveIdOf(uint256,address) (NodeID: 98)
  │     💬 Args: [i, owners[j]]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 99)
  │   💬 Args: [isShutdown[i], "Should have failed as branch hadn't been shut down"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGtDecimal(uint256,uint256,uint256,string) (NodeID: 100)
  │   💬 Args: [amount, 0, 18, "Should have failed as amount was zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveMethods.applyPending(struct Trove) (NodeID: 101)
  │   💬 Args: [trove]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingRedist(struct Trove) (NodeID: 102)
  │ │   💬 Args: [trove]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingInterest(struct Trove) (NodeID: 103)
  │ │   💬 Args: [trove]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingBatchManagementFee(struct Trove) (NodeID: 104)
  │     💬 Args: [trove]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Assertions.assertApproxEq(uint256,uint256,uint256,string) (NodeID: 105)
  │   💬 Args: [redeemed.coll, trove.coll, 1e8, "Coll underflow"]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 106)
  │ │   💬 Args: [a, b, maxPercentDelta, 18, err]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 107)
  │     💬 Args: [a, b, maxPercentDelta, 18, err]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Assertions.assertApproxEq(uint256,uint256,uint256,string) (NodeID: 108)
  │   💬 Args: [redeemed.debt, trove.debt, 1e8, "Debt underflow"]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 109)
  │ │   💬 Args: [a, b, maxPercentDelta, 18, err]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 110)
  │     💬 Args: [a, b, maxPercentDelta, 18, err]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 111)
  │   💬 Args: [r.batchManagers]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 112)
  │     💬 Args: [set._base]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._touchBatch(uint256,address) (NodeID: 113)
  │   💬 Args: [i, r.batchManagers.get(j)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableAddressSetMethods.get(struct EnumerableAddressSet,uint256) (NodeID: 118)
  │ │   💬 Args: [r.batchManagers, j]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 119)
  │ │     💬 Args: [set._base, i]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 114)
  │ │   💬 Args: [_batches[i][batchManager].troves]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 115)
  │ │   💬 Args: [_batches[i][batchManager].troves, j]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingInterest(struct Trove) (NodeID: 116)
  │ │   💬 Args: [trove]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingBatchManagementFee(struct Trove) (NodeID: 117)
  │     💬 Args: [trove]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._mintYield(uint256,uint256,uint256) (NodeID: 120)
  │   💬 Args: [i, pendingInterest, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._decodeCustomError(bytes) (NodeID: 121)
  │   💬 Args: [revertData]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 122)
  │ │   💬 Args: [revertData, 4]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 123)
  │ │     💬 Args: [str, start, int256(str.length)]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 124)
  │ │   💬 Args: [uint256(param)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 125)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 126)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 127)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 128)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 129)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 130)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 131)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 132)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 133)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 134)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 135)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 136)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 137)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 138)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 139)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 140)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 141)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 142)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 143)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 144)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 145)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 146)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._revert(bytes) (NodeID: 147)
  │     💬 Args: [revertData]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 148)
  │   💬 Args: [isShutdown[i], "Shouldn't have failed as branch had been shut down"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 149)
  │   💬 Args: [amount, 0, 18, "Shouldn't have failed as amount was greater than zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 150)
  │   💬 Args: [revertData, 4]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 151)
  │     💬 Args: [str, start, int256(str.length)]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLtDecimal(uint256,uint256,uint256,string) (NodeID: 152)
  │   💬 Args: [collReceived, r.totalCollRedeemed, 18, "Shouldn't have failed as min coll was reached"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 153)
  │   💬 Args: [collReceived, r.totalCollRedeemed, 1e5, 18, "Wrong coll amount received"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 154)
  │   💬 Args: ["Expected error: ", errorString]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 155)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 156)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 157)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 158)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging._log() (NodeID: 159)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log() (NodeID: 160)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 161)
  │       💬 Args: [abi.encodeWithSignature("log()")]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 162)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepBold(address,uint256) (NodeID: 163)
  │   💬 Args: [msg.sender, amount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 164)
  │   💬 Args: [collReceived, r.totalCollRedeemed, 1e5, 18, "Wrong coll amount received"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepColl(uint256,address,uint256) (NodeID: 165)
  │   💬 Args: [i, msg.sender, collReceived]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 166)
  │   💬 Args: [r.batchManagers]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 167)
  │     💬 Args: [set._base]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepBold(address,uint256) (NodeID: 168)
  │   💬 Args: [r.batchManagers.get(j), batchManagementFee[j]]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableAddressSetMethods.get(struct EnumerableAddressSet,uint256) (NodeID: 169)
  │     💬 Args: [r.batchManagers, j]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 170)
  │       💬 Args: [set._base, i]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 171)
  │   💬 Args: [remainingAmount, amount - r.totalDebtRedeemed, 1e5, 18, "Wrong remaining BOLD"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._sweepBold(address,uint256) (NodeID: 172)
  │   💬 Args: [msg.sender, remainingAmount]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: InvariantsTestHandler._resetUrgentRedemption() (NodeID: 173)
      💬 Args: [no args]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.reset(struct EnumerableSet) (NodeID: 174)
    │   💬 Args: [_urgentRedemption.redeemedIds]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableAddressSetMethods.reset(struct EnumerableAddressSet) (NodeID: 175)
        💬 Args: [_urgentRedemption.batchManagers]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.reset(struct EnumerableSet) (NodeID: 176)
          💬 Args: [set._base]
          👁️  Def: internal
```
