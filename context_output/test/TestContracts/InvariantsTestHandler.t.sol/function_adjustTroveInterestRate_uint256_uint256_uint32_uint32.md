# Function: adjustTroveInterestRate(uint256,uint256,uint32,uint32)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `adjustTroveInterestRate(uint256,uint256,uint32,uint32)`
- **Visibility**: external
- **Source Range**: 38357:5885:270

## Implementation

```solidity
function adjustTroveInterestRate(uint256 i, uint256 newInterestRate, uint32 upperHintSeed, uint32 lowerHintSeed) external {
    AdjustTroveInterestRateContext memory v;
    i = _bound(i, 0, branches.length - 1);
    newInterestRate = _bound(newInterestRate, INTEREST_RATE_MIN, INTEREST_RATE_MAX);
    v.upperHint = _pickHint(i, upperHintSeed);
    v.lowerHint = _pickHint(i, lowerHintSeed);
    v.c = branches[i];
    v.pendingInterest = v.c.activePool.calcPendingAggInterest();
    v.troveId = _troveIdOf(i, msg.sender);
    v.batchManager = _batchManagerOf[i][v.troveId];
    v.t = v.c.troveManager.getLatestTroveData(v.troveId);
    v.trove = _troves[i][v.troveId];
    v.wasActive = _isActive(i, v.troveId);
    v.premature = (newInterestRate != v.t.annualInterestRate) && (_timeSinceLastTroveInterestRateAdjustment[i][v.troveId] < INTEREST_RATE_ADJ_COOLDOWN);
    if (v.batchManager == address(0)) {
        v.upfrontFee = hintHelpers.predictAdjustInterestRateUpfrontFee(i, v.troveId, newInterestRate);
        if (v.upfrontFee > 0) assertTrue(v.premature, "Only premature adjustment should incur upfront fee");
    }
    info("upper hint: ", _hintToString(i, v.upperHint));
    info("lower hint: ", _hintToString(i, v.lowerHint));
    info("upfront fee: ", v.upfrontFee.decimal());
    logCall("adjustTroveInterestRate", i.toString(), newInterestRate.decimal(), upperHintSeed.toString(), lowerHintSeed.toString());
    vm.prank(msg.sender);
    try v.c.borrowerOperations.adjustTroveInterestRate(v.troveId, newInterestRate, v.upperHint, v.lowerHint, v.upfrontFee) {
        uint256 newICR = _ICR(i, v.troveId);
        uint256 newTCR = _TCR(i);
        assertFalse(isShutdown[i], "Should have failed as branch had been shut down");
        assertTrue(v.wasActive, "Should have failed as Trove wasn't active");
        assertEq(v.batchManager, address(0), "Should have failed as Trove was in a batch");
        assertNotEqDecimal(newInterestRate, v.t.annualInterestRate, 18, "Should have failed as rate == old");
        assertGeDecimal(newInterestRate, MIN_ANNUAL_INTEREST_RATE, 18, "Should have failed as rate < min");
        assertLeDecimal(newInterestRate, MAX_ANNUAL_INTEREST_RATE, 18, "Should have failed as rate > max");
        if (v.premature) {
            assertGeDecimal(newICR, MCR[i], 18, "Should have failed as new ICR < MCR");
            assertGeDecimal(newTCR, CCR[i], 18, "Should have failed as new TCR < CCR");
        }
        v.trove.applyPending();
        v.trove.debt += v.upfrontFee;
        v.trove.interestRate = newInterestRate;
        _troves[i][v.troveId] = v.trove;
        _timeSinceLastTroveInterestRateAdjustment[i][v.troveId] = 0;
        _mintYield(i, v.pendingInterest, v.upfrontFee);
    } catch Error(string memory reason) {
        v.errorString = reason;
        if (reason.equals("ERC721: invalid token ID")) {
            assertFalse(_isOpen(i, v.troveId), "Open Trove should have an NFT");
        } else {
            revert(reason);
        }
    } catch (bytes memory revertData) {
        bytes4 selector;
        (selector, v.errorString) = _decodeCustomError(revertData);
        if (selector == BorrowerOperations.IsShutDown.selector) {
            assertTrue(isShutdown[i], "Shouldn't have failed as branch hadn't been shut down");
        } else if (selector == BorrowerOperations.TroveNotActive.selector) {
            assertFalse(v.wasActive, "Shouldn't have failed as Trove was active");
        } else if (selector == BorrowerOperations.TroveInBatch.selector) {
            assertNotEq(v.batchManager, address(0), "Shouldn't have failed as Trove wasn't in a batch");
        } else if (selector == BorrowerOperations.InterestRateNotNew.selector) {
            assertEqDecimal(newInterestRate, v.t.annualInterestRate, 18, "Shouldn't have failed as rate != old");
        } else if (selector == BorrowerOperations.InterestRateTooLow.selector) {
            assertLtDecimal(newInterestRate, MIN_ANNUAL_INTEREST_RATE, 18, "Shouldn't have failed as rate >= min");
        } else if (selector == BorrowerOperations.InterestRateTooHigh.selector) {
            assertGtDecimal(newInterestRate, MAX_ANNUAL_INTEREST_RATE, 18, "Shouldn't have failed as rate <= max");
        } else if (selector == BorrowerOperations.ICRBelowMCR.selector) {
            uint256 newICR = _ICR(i, 0, 0, v.upfrontFee, v.t);
            assertTrue(v.premature, "Shouldn't have failed as adjustment was not premature");
            assertLtDecimal(newICR, MCR[i], 18, "Shouldn't have failed as new ICR >= MCR");
            info("New ICR would have been: ", newICR.decimal());
        } else if (selector == BorrowerOperations.TCRBelowCCR.selector) {
            uint256 newTCR = _TCR(i, 0, 0, v.upfrontFee);
            assertTrue(v.premature, "Shouldn't have failed as adjustment was not premature");
            assertLtDecimal(newTCR, CCR[i], 18, "Shouldn't have failed as new TCR >= CCR");
            info("New TCR would have been: ", newTCR.decimal());
        } else {
            revert(string.concat("Unexpected error: ", v.errorString));
        }
    }
    if (bytes(v.errorString).length > 0) {
        if (_assumeNoExpectedFailures) vm.assume(false);
        info("Expected error: ", v.errorString);
        _log();
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

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1689:113:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    vm.assertTrue(data, err);
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

### logCall(string,string,string,string,string)

- **Kind**: internal
- **Source**: 1221:266:251
- **Link**: `test/TestContracts/BaseHandler.sol:BaseHandler:logCall(string,string,string,string,string)`

```solidity
function logCall(string memory functionName, string memory a, string memory b, string memory c, string memory d) internal view {
    _logCaller();
    _log(_callPrefix(), functionName, "(", _csv([a, b, c, d]), ");");
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

### _csv(string[4])

- **Kind**: internal
- **Source**: 3880:166:289
- **Link**: `test/Utils/Logging.sol:Logging:_csv(string[4])`

```solidity
function _csv(string[4] memory strs) internal pure returns (string memory) {
    return string.concat(strs[0], ", ", strs[1], ", ", strs[2], ", ", strs[3]);
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

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 1905:115:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    vm.assertFalse(data, err);
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

### assertNotEqDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 7618:210:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertNotEqDecimal(uint256,uint256,uint256,string)`

```solidity
function assertNotEqDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertNotEqDecimal(left, right, decimals, err);
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

### assertLeDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 14710:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLeDecimal(uint256,uint256,uint256,string)`

```solidity
function assertLeDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertLeDecimal(left, right, decimals, err);
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

### assertNotEq(address,address,string)

- **Kind**: internal
- **Source**: 8568:140:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertNotEq(address,address,string)`

```solidity
function assertNotEq(address left, address right, string memory err) virtual internal pure {
    vm.assertNotEq(left, right, err);
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

### assertGtDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 13526:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGtDecimal(uint256,uint256,uint256,string)`

```solidity
function assertGtDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertGtDecimal(left, right, decimals, err);
}
```

## External Calls

- **IActivePool::calcPendingAggInterest()**
- **ITroveManagerTester::getLatestTroveData(uint256)**
- **HintHelpers::predictAdjustInterestRateUpfrontFee(uint256,uint256,uint256)**
- **Vm::prank(address)**
- **IBorrowerOperationsTester::adjustTroveInterestRate(uint256,uint256,uint256,uint256,uint256)**
- **Vm::assume(bool)**

## State Variable Reads

- **_batchManagerOf** (`mapping(uint256 => mapping(uint256 => address))`)
- **_troves** (`mapping(uint256 => mapping(uint256 => struct Trove))`)
- **_timeSinceLastTroveInterestRateAdjustment** (`mapping(uint256 => mapping(uint256 => uint256))`)
- **isShutdown** (`mapping(uint256 => bool)`)
- **MCR** (`mapping(uint256 => uint256)`)
- **CCR** (`mapping(uint256 => uint256)`)
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
- **_price** (`mapping(uint256 => uint256)`)

## State Variable Writes

- **_troves** (`mapping(uint256 => mapping(uint256 => struct Trove))`)
- **_timeSinceLastTroveInterestRateAdjustment** (`mapping(uint256 => mapping(uint256 => uint256))`)
- **spBoldYield** (`mapping(uint256 => uint256)`)
- **_pendingInterest** (`mapping(uint256 => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.adjustTroveInterestRate(uint256,uint256,uint32,uint32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [i, 0, branches.length - 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 2)
  │   💬 Args: [newInterestRate, INTEREST_RATE_MIN, INTEREST_RATE_MAX]
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
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._troveIdOf(uint256,address) (NodeID: 11)
  │   💬 Args: [i, msg.sender]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._isActive(uint256,uint256) (NodeID: 12)
  │   💬 Args: [i, v.troveId]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._isZombie(uint256,uint256) (NodeID: 13)
  │ │   💬 Args: [i, troveId]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 14)
  │ │     💬 Args: [_zombieTroveIds[i], troveId]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._isOpen(uint256,uint256) (NodeID: 15)
  │     💬 Args: [i, troveId]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 16)
  │       💬 Args: [_troveIds[i], troveId]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 17)
  │   💬 Args: [v.premature, "Only premature adjustment should incur upfront fee"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 18)
  │   💬 Args: ["upper hint: ", _hintToString(i, v.upperHint)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._hintToString(uint256,uint256) (NodeID: 23)
  │ │   💬 Args: [i, v.upperHint]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: InvariantsTestHandler._isOpen(uint256,uint256) (NodeID: 24)
  │ │ │   💬 Args: [i, troveId]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 25)
  │ │ │     💬 Args: [_troveIds[i], troveId]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 26)
  │ │     💬 Args: [troveId]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 27)
  │ │       💬 Args: [value]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 19)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 20)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 21)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 22)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 28)
  │   💬 Args: ["lower hint: ", _hintToString(i, v.lowerHint)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._hintToString(uint256,uint256) (NodeID: 33)
  │ │   💬 Args: [i, v.lowerHint]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: InvariantsTestHandler._isOpen(uint256,uint256) (NodeID: 34)
  │ │ │   💬 Args: [i, troveId]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 35)
  │ │ │     💬 Args: [_troveIds[i], troveId]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 36)
  │ │     💬 Args: [troveId]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 37)
  │ │       💬 Args: [value]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 29)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 30)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 31)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 32)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 38)
  │   💬 Args: ["upfront fee: ", v.upfrontFee.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 43)
  │ │   💬 Args: [v.upfrontFee]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 44)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 45)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 46)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 47)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 48)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 49)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 50)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 51)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 52)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 53)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 54)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 55)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 56)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 57)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 58)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 59)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 60)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 61)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 62)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 63)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 64)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 65)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 39)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 40)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 41)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 42)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseHandler.logCall(string,string,string,string,string) (NodeID: 66)
  │   💬 Args: ["adjustTroveInterestRate", i.toString(), newInterestRate.decimal(), upperHintSeed.toString(), lowerHintSeed.toString()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 82)
  │ │   💬 Args: [i]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 83)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 84)
  │ │   💬 Args: [newInterestRate]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 85)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 86)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 87)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 88)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 89)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 90)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 91)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 92)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 93)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 94)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 95)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 96)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 97)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 98)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 99)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 100)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 101)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 102)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 103)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 104)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 105)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 106)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 107)
  │ │   💬 Args: [upperHintSeed]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 108)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 109)
  │ │   💬 Args: [lowerHintSeed]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 110)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseHandler._logCaller() (NodeID: 67)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 68)
  │ │     💬 Args: ["vm.prank(", vm.getLabel(msg.sender), ");"]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 69)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 70)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 71)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging._log(string,string,string,string,string) (NodeID: 72)
  │ │   💬 Args: [_callPrefix(), functionName, "(", _csv([a, b, c, d]), ");"]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseHandler._callPrefix() (NodeID: 76)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Logging._csv(string[4]) (NodeID: 77)
  │ │ │   💬 Args: [[a, b, c, d]]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 73)
  │ │     💬 Args: [string.concat(a, b, c, d, e)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 74)
  │ │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 75)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log() (NodeID: 78)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log() (NodeID: 79)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 80)
  │         💬 Args: [abi.encodeWithSignature("log()")]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 81)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._ICR(uint256,uint256) (NodeID: 111)
  │   💬 Args: [i, v.troveId]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._ICR(uint256,int256,int256,uint256,uint256) (NodeID: 112)
  │     💬 Args: [i, 0, 0, 0, troveId]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: InvariantsTestHandler._ICR(uint256,int256,int256,uint256,struct LatestTroveData) (NodeID: 113)
  │       💬 Args: [i, collDelta, debtDelta, upfrontFee, branches[i].troveManager.getLatestTroveData(troveId)]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 114)
  │     │   💬 Args: [trove.entireColl, collDelta]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 115)
  │     │   💬 Args: [trove.entireDebt, debtDelta]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 116)
  │         💬 Args: [i, coll, debt]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._TCR(uint256) (NodeID: 117)
  │   💬 Args: [i]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._TCR(uint256,int256,int256,uint256) (NodeID: 118)
  │     💬 Args: [i, 0, 0, 0]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 119)
  │   │   💬 Args: [branches[i].troveManager.getEntireBranchColl(), collDelta]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 120)
  │   │   💬 Args: [branches[i].troveManager.getEntireBranchDebt(), debtDelta]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 121)
  │       💬 Args: [i, coll, debt]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 122)
  │   💬 Args: [isShutdown[i], "Should have failed as branch had been shut down"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 123)
  │   💬 Args: [v.wasActive, "Should have failed as Trove wasn't active"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 124)
  │   💬 Args: [v.batchManager, address(0), "Should have failed as Trove was in a batch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEqDecimal(uint256,uint256,uint256,string) (NodeID: 125)
  │   💬 Args: [newInterestRate, v.t.annualInterestRate, 18, "Should have failed as rate == old"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGeDecimal(uint256,uint256,uint256,string) (NodeID: 126)
  │   💬 Args: [newInterestRate, MIN_ANNUAL_INTEREST_RATE, 18, "Should have failed as rate < min"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLeDecimal(uint256,uint256,uint256,string) (NodeID: 127)
  │   💬 Args: [newInterestRate, MAX_ANNUAL_INTEREST_RATE, 18, "Should have failed as rate > max"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGeDecimal(uint256,uint256,uint256,string) (NodeID: 128)
  │   💬 Args: [newICR, MCR[i], 18, "Should have failed as new ICR < MCR"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGeDecimal(uint256,uint256,uint256,string) (NodeID: 129)
  │   💬 Args: [newTCR, CCR[i], 18, "Should have failed as new TCR < CCR"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveMethods.applyPending(struct Trove) (NodeID: 130)
  │   💬 Args: [v.trove]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingRedist(struct Trove) (NodeID: 131)
  │ │   💬 Args: [trove]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingInterest(struct Trove) (NodeID: 132)
  │ │   💬 Args: [trove]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingBatchManagementFee(struct Trove) (NodeID: 133)
  │     💬 Args: [trove]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._mintYield(uint256,uint256,uint256) (NodeID: 134)
  │   💬 Args: [i, v.pendingInterest, v.upfrontFee]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StringFormatting.equals(string,string) (NodeID: 135)
  │   💬 Args: [reason, "ERC721: invalid token ID"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 136)
  │   💬 Args: [_isOpen(i, v.troveId), "Open Trove should have an NFT"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._isOpen(uint256,uint256) (NodeID: 137)
  │     💬 Args: [i, v.troveId]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 138)
  │       💬 Args: [_troveIds[i], troveId]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._decodeCustomError(bytes) (NodeID: 139)
  │   💬 Args: [revertData]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 140)
  │ │   💬 Args: [revertData, 4]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 141)
  │ │     💬 Args: [str, start, int256(str.length)]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 142)
  │ │   💬 Args: [uint256(param)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 143)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 144)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 145)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 146)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 147)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 148)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 149)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 150)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 151)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 152)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 153)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 154)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 155)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 156)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 157)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 158)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 159)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 160)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 161)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 162)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 163)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 164)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._revert(bytes) (NodeID: 165)
  │     💬 Args: [revertData]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 166)
  │   💬 Args: [isShutdown[i], "Shouldn't have failed as branch hadn't been shut down"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 167)
  │   💬 Args: [v.wasActive, "Shouldn't have failed as Trove was active"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 168)
  │   💬 Args: [v.batchManager, address(0), "Shouldn't have failed as Trove wasn't in a batch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 169)
  │   💬 Args: [newInterestRate, v.t.annualInterestRate, 18, "Shouldn't have failed as rate != old"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLtDecimal(uint256,uint256,uint256,string) (NodeID: 170)
  │   💬 Args: [newInterestRate, MIN_ANNUAL_INTEREST_RATE, 18, "Shouldn't have failed as rate >= min"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGtDecimal(uint256,uint256,uint256,string) (NodeID: 171)
  │   💬 Args: [newInterestRate, MAX_ANNUAL_INTEREST_RATE, 18, "Shouldn't have failed as rate <= max"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._ICR(uint256,int256,int256,uint256,struct LatestTroveData) (NodeID: 172)
  │   💬 Args: [i, 0, 0, v.upfrontFee, v.t]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 173)
  │ │   💬 Args: [trove.entireColl, collDelta]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 174)
  │ │   💬 Args: [trove.entireDebt, debtDelta]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 175)
  │     💬 Args: [i, coll, debt]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 176)
  │   💬 Args: [v.premature, "Shouldn't have failed as adjustment was not premature"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLtDecimal(uint256,uint256,uint256,string) (NodeID: 177)
  │   💬 Args: [newICR, MCR[i], 18, "Shouldn't have failed as new ICR >= MCR"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 178)
  │   💬 Args: ["New ICR would have been: ", newICR.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 183)
  │ │   💬 Args: [newICR]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 184)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 185)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 186)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 187)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 188)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 189)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
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
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 196)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 197)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 198)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 199)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 200)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 201)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 202)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 203)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 204)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 205)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 179)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 180)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 181)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 182)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InvariantsTestHandler._TCR(uint256,int256,int256,uint256) (NodeID: 206)
  │   💬 Args: [i, 0, 0, v.upfrontFee]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 207)
  │ │   💬 Args: [branches[i].troveManager.getEntireBranchColl(), collDelta]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 208)
  │ │   💬 Args: [branches[i].troveManager.getEntireBranchDebt(), debtDelta]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 209)
  │     💬 Args: [i, coll, debt]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 210)
  │   💬 Args: [v.premature, "Shouldn't have failed as adjustment was not premature"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLtDecimal(uint256,uint256,uint256,string) (NodeID: 211)
  │   💬 Args: [newTCR, CCR[i], 18, "Shouldn't have failed as new TCR >= CCR"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 212)
  │   💬 Args: ["New TCR would have been: ", newTCR.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 217)
  │ │   💬 Args: [newTCR]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 218)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 219)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 220)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 221)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 222)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 223)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 224)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 225)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 226)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 227)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 228)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 229)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 230)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 231)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 232)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 233)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 234)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 235)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 236)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 237)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 238)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 239)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 213)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 214)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 215)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 216)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 240)
  │   💬 Args: ["Expected error: ", v.errorString]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 241)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 242)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 243)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 244)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Logging._log() (NodeID: 245)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: console.log() (NodeID: 246)
        💬 Args: [no args]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 247)
          💬 Args: [abi.encodeWithSignature("log()")]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 248)
            💬 Args: [_sendLogPayloadView]
            👁️  Def: internal
```
