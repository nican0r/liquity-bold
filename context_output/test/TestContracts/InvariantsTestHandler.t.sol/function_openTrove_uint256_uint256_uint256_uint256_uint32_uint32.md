# Function: openTrove(uint256,uint256,uint256,uint256,uint32,uint32)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `openTrove(uint256,uint256,uint256,uint256,uint32,uint32)`
- **Visibility**: external
- **Source Range**: 19428:445:270

## Implementation

```solidity
function openTrove(uint256 i, uint256 borrowed, uint256 icr, uint256 interestRate, uint32 upperHintSeed, uint32 lowerHintSeed) external {
    OpenTroveContext memory v;
    v.i = i;
    v.borrowed = borrowed;
    v.icr = icr;
    v.interestRate = interestRate;
    v.upperHintSeed = upperHintSeed;
    v.lowerHintSeed = lowerHintSeed;
    _openTrove(v);
}
```

## Related Implementations

### _openTrove(struct InvariantsTestHandler.OpenTroveContext)

- **Kind**: internal
- **Source**: 20391:7633:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_openTrove(struct InvariantsTestHandler.OpenTroveContext)`

```solidity
function _openTrove(OpenTroveContext memory v) internal {
    v.i = _bound(v.i, 0, branches.length - 1);
    v.borrowed = _bound(v.borrowed, BORROWED_MIN, BORROWED_MAX);
    if (!v.join) v.icr = _bound(v.icr, ICR_MIN, ICR_MAX);
    if (v.join) v.icr = _bound(v.icr, ICR_MIN + BCR[v.i], ICR_MAX);
    if (!v.join) v.interestRate = _bound(v.interestRate, INTEREST_RATE_MIN, INTEREST_RATE_MAX);
    if (v.join) v.batchManager = _pickBatchManager(v.i, v.batchManagerSeed);
    v.upperHint = _pickHint(v.i, v.upperHintSeed);
    v.lowerHint = _pickHint(v.i, v.lowerHintSeed);
    v.c = branches[v.i];
    v.pendingInterest = v.c.activePool.calcPendingAggInterest();
    if (v.join) v.batchManagementFee = v.c.troveManager.getLatestBatchData(v.batchManager).accruedManagementFee;
    if (v.join) v.upfrontFee = hintHelpers.predictOpenTroveAndJoinBatchUpfrontFee(v.i, v.borrowed, v.batchManager);
    if (!v.join) v.upfrontFee = hintHelpers.predictOpenTroveUpfrontFee(v.i, v.borrowed, v.interestRate);
    v.debt = v.borrowed + v.upfrontFee;
    v.coll = (v.debt * v.icr) / _price[v.i];
    v.troveId = _troveIdOf(v.i, msg.sender);
    v.wasOpen = _isOpen(v.i, v.troveId);
    Trove storage trove = _troves[v.i][v.troveId];
    Batch storage batch = _batches[v.i][v.batchManager];
    if (v.join) info("batch manager: ", vm.getLabel(v.batchManager));
    info("upper hint: ", _hintToString(v.i, v.upperHint));
    info("lower hint: ", _hintToString(v.i, v.lowerHint));
    info("upfront fee: ", v.upfrontFee.decimal());
    logCall(v.join ? "openTroveAndJoinInterestBatchManager" : "openTrove", v.i.toString(), v.borrowed.decimal(), v.icr.decimal(), v.join ? v.batchManagerSeed.toString() : v.interestRate.decimal(), v.upperHintSeed.toString(), v.lowerHintSeed.toString());
    _dealCollAndApprove(v.i, msg.sender, v.coll, address(v.c.borrowerOperations));
    _dealWETHAndApprove(msg.sender, ETH_GAS_COMPENSATION, address(v.c.borrowerOperations));
    vm.prank(msg.sender);
    try _functionCaller.call(address(v.c.borrowerOperations), _encodeOpenTrove(v)) {
        uint256 icr_ = _CR(v.i, v.coll, v.debt);
        uint256 newTCR = _TCR(v.i);
        if (v.join) {
            assertTrue(_batchManagers[v.i].has(v.batchManager), "Should have failed as batch manager wasn't valid");
        } else {
            assertGeDecimal(v.interestRate, MIN_ANNUAL_INTEREST_RATE, 18, "Should have failed as rate < min");
            assertLeDecimal(v.interestRate, MAX_ANNUAL_INTEREST_RATE, 18, "Should have failed as rate > max");
        }
        assertFalse(isShutdown[v.i], "Should have failed as branch had been shut down");
        assertFalse(v.wasOpen, "Should have failed as Trove was open");
        assertGeDecimal(v.debt, MIN_DEBT, 18, "Should have failed as debt < min");
        if (!v.join) assertGeDecimal(icr_, MCR[v.i], 18, "Should have failed as ICR < MCR");
        if (v.join) assertGeDecimal(icr_, MCR[v.i] + BCR[v.i], 18, "Should have failed as ICR < MCR + BCR");
        assertGeDecimal(newTCR, CCR[v.i], 18, "Should have failed as new TCR < CCR");
        trove.coll = v.coll;
        trove.debt = v.debt;
        trove.interestRate = v.join ? batch.interestRate : v.interestRate;
        trove.batchManagementRate = v.join ? batch.managementRate : 0;
        _batchManagerOf[v.i][v.troveId] = v.join ? v.batchManager : address(0);
        _troveIds[v.i].add(v.troveId);
        if (v.join) {
            batch.troves.add(v.troveId);
            _touchBatch(v.i, v.batchManager);
        }
        _mintYield(v.i, v.pendingInterest, v.upfrontFee);
    } catch (bytes memory revertData) {
        bytes4 selector;
        (selector, v.errorString) = _decodeCustomError(revertData);
        if (selector == BorrowerOperations.InvalidInterestBatchManager.selector) {
            assertTrue(v.join, "Shouldn't have failed as a batch wasn't joined");
            assertFalse(_batchManagers[v.i].has(v.batchManager), "Shouldn't have failed as batch manager was valid");
        } else if (selector == BorrowerOperations.InterestRateTooLow.selector) {
            assertFalse(v.join, "Shouldn't have failed as a batch was joined");
            assertLtDecimal(v.interestRate, MIN_ANNUAL_INTEREST_RATE, 18, "Shouldn't have failed as rate >= min");
        } else if (selector == BorrowerOperations.InterestRateTooHigh.selector) {
            assertFalse(v.join, "Shouldn't have failed as a batch was joined");
            assertGtDecimal(v.interestRate, MAX_ANNUAL_INTEREST_RATE, 18, "Shouldn't have failed as rate <= max");
        } else if (selector == BorrowerOperations.IsShutDown.selector) {
            assertTrue(isShutdown[v.i], "Shouldn't have failed as branch hadn't been shut down");
        } else if (selector == BorrowerOperations.TroveExists.selector) {
            assertTrue(v.wasOpen, "Shouldn't have failed as Trove didn't exist");
        } else if (selector == BorrowerOperations.DebtBelowMin.selector) {
            assertLtDecimal(v.debt, MIN_DEBT, 18, "Shouldn't have failed as debt >= min");
        } else if (selector == BorrowerOperations.ICRBelowMCR.selector) {
            assertFalse(v.join, "Shouldn't have thrown ICRBelowMCR as a batch was joined");
            uint256 icr_ = _CR(v.i, v.coll, v.debt);
            assertLtDecimal(icr_, MCR[v.i], 18, "Shouldn't have failed as ICR >= MCR");
        } else if (selector == BorrowerOperations.ICRBelowMCRPlusBCR.selector) {
            assertTrue(v.join, "Shouldn't have thrown ICRBelowMCRPlusBCR as a batch wasn't joined");
            uint256 icr_ = _CR(v.i, v.coll, v.debt);
            assertLtDecimal(icr_, MCR[v.i] + BCR[v.i], 18, "Shouldn't have failed as ICR >= MCR + BCR");
        } else if (selector == BorrowerOperations.TCRBelowCCR.selector) {
            uint256 newTCR = _TCR(v.i, int256(v.coll), int256(v.borrowed), v.upfrontFee);
            assertLtDecimal(newTCR, CCR[v.i], 18, "Shouldn't have failed as new TCR >= CCR");
            info("New TCR would have been: ", newTCR.decimal());
        } else {
            revert(string.concat("Unexpected error: ", v.errorString));
        }
    }
    if (bytes(v.errorString).length > 0) {
        if (_assumeNoExpectedFailures) vm.assume(false);
        info("Expected error: ", v.errorString);
        _log();
        _sweepCollAndUnapprove(v.i, msg.sender, v.coll, address(v.c.borrowerOperations));
        _sweepWETHAndUnapprove(msg.sender, ETH_GAS_COMPENSATION, address(v.c.borrowerOperations));
    } else {
        _sweepBold(msg.sender, v.borrowed);
        if (v.join) _sweepBold(v.batchManager, v.batchManagementFee);
    }
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

### _pickBatchManager(uint256,uint256)

- **Kind**: internal
- **Source**: 111409:354:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_pickBatchManager(uint256,uint256)`

```solidity
function _pickBatchManager(uint256 i, uint256 seed) internal view returns (address) {
    uint256 rem = seed % (_batchManagers[i].size() + 1);
    if (rem < _batchManagers[i].size()) {
        return _batchManagers[i].get(rem);
    } else {
        return address(uint160(uint256(keccak256(abi.encodePacked(seed)))));
    }
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

### logCall(string,string,string,string,string,string,string)

- **Kind**: internal
- **Source**: 1819:348:251
- **Link**: `test/TestContracts/BaseHandler.sol:BaseHandler:logCall(string,string,string,string,string,string,string)`

```solidity
function logCall(string memory functionName, string memory a, string memory b, string memory c, string memory d, string memory e, string memory f) internal view {
    _logCaller();
    _log(_callPrefix(), functionName, "(", _csv([a, b, c, d, e, f]), ");");
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

### _csv(string[6])

- **Kind**: internal
- **Source**: 4239:196:289
- **Link**: `test/Utils/Logging.sol:Logging:_csv(string[6])`

```solidity
function _csv(string[6] memory strs) internal pure returns (string memory) {
    return string.concat(strs[0], ", ", strs[1], ", ", strs[2], ", ", strs[3], ", ", strs[4], ", ", strs[5]);
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

### _dealWETHAndApprove(address,uint256,address)

- **Kind**: internal
- **Source**: 113836:318:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_dealWETHAndApprove(address,uint256,address)`

```solidity
function _dealWETHAndApprove(address to, uint256 amount, address spender) internal {
    uint256 balance = weth.balanceOf(to);
    uint256 allowance = weth.allowance(to, spender);
    deal(address(weth), to, balance + amount);
    vm.prank(to);
    weth.approve(spender, allowance + amount);
}
```

### _encodeOpenTrove(struct InvariantsTestHandler.OpenTroveContext)

- **Kind**: internal
- **Source**: 123979:1442:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_encodeOpenTrove(struct InvariantsTestHandler.OpenTroveContext)`

```solidity
function _encodeOpenTrove(OpenTroveContext memory v) internal view returns (bytes memory) {
    return v.join ? abi.encodeCall(IBorrowerOperations.openTroveAndJoinInterestBatchManager, (IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams({owner: msg.sender, ownerIndex: _troveIndexOf[v.i][msg.sender], collAmount: v.coll, boldAmount: v.borrowed, upperHint: v.upperHint, lowerHint: v.lowerHint, interestBatchManager: v.batchManager, maxUpfrontFee: v.upfrontFee, addManager: address(0), removeManager: address(0), receiver: address(0)}))) : abi.encodeCall(IBorrowerOperations.openTrove, (msg.sender, _troveIndexOf[v.i][msg.sender], v.coll, v.borrowed, v.upperHint, v.lowerHint, v.interestRate, v.upfrontFee, address(0), address(0), address(0)));
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

### add(uint256,int256)

- **Kind**: free-function
- **Source**: 3111:103:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:add(uint256,int256)`

```solidity
function add(uint256 x, int256 delta) pure returns (uint256) {
    return uint256(int256(x) + delta);
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

### has(struct EnumerableAddressSet,address)

- **Kind**: internal
- **Source**: 2642:157:288
- **Link**: `test/Utils/EnumerableSet.sol:EnumerableAddressSetMethods:has(struct EnumerableAddressSet,address)`

```solidity
function has(EnumerableAddressSet storage set, address element) internal view returns (bool) {
    return set._base.has(uint256(uint160(element)));
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

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 1905:115:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    vm.assertFalse(data, err);
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

### _sweepWETHAndUnapprove(address,uint256,address)

- **Kind**: internal
- **Source**: 114707:264:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_sweepWETHAndUnapprove(address,uint256,address)`

```solidity
function _sweepWETHAndUnapprove(address from, uint256 amount, address spender) internal {
    _sweepWETH(from, amount);
    uint256 allowance = weth.allowance(from, spender);
    vm.prank(from);
    weth.approve(spender, allowance - amount);
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

## State Variable Reads

- **BCR** (`mapping(uint256 => uint256)`)
- **_price** (`mapping(uint256 => uint256)`)
- **_troves** (`mapping(uint256 => mapping(uint256 => struct Trove))`)
- **_batches** (`mapping(uint256 => mapping(address => struct InvariantsTestHandler.Batch))`)
- **_functionCaller** (`contract FunctionCaller`) [test/TestContracts/InvariantsTestHandler.t.sol/contract_FunctionCaller.md]
- **_batchManagers** (`mapping(uint256 => struct EnumerableAddressSet)`)
- **isShutdown** (`mapping(uint256 => bool)`)
- **MCR** (`mapping(uint256 => uint256)`)
- **CCR** (`mapping(uint256 => uint256)`)
- **_assumeNoExpectedFailures** (`bool`)
- **UINT256_MAX** (`uint256`)
- **_troveIds** (`mapping(uint256 => struct EnumerableSet)`)
- **_troveIndexOf** (`mapping(uint256 => mapping(address => uint256))`)
- **ONE** (`uint256`)
- **DECIMAL_UNIT** (`string`)
- **DECIMAL_SEPARATOR** (`string`)
- **GROUP_DIGITS** (`uint256`)
- **GROUP_SEPARATOR** (`bytes1`)
- **stdstore** (`struct StdStorage`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## State Variable Writes

- **_batchManagerOf** (`mapping(uint256 => mapping(uint256 => address))`)
- **_troveIds** (`mapping(uint256 => struct EnumerableSet)`)
- **_troves** (`mapping(uint256 => mapping(uint256 => struct Trove))`)
- **_batches** (`mapping(uint256 => mapping(address => struct InvariantsTestHandler.Batch))`)
- **spBoldYield** (`mapping(uint256 => uint256)`)
- **_pendingInterest** (`mapping(uint256 => uint256)`)
- **_handlerBold** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.openTrove(uint256,uint256,uint256,uint256,uint32,uint32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: InvariantsTestHandler._openTrove(struct InvariantsTestHandler.OpenTroveContext) (NodeID: 1)
      💬 Args: [v]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 2)
    │   💬 Args: [v.i, 0, branches.length - 1]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 3)
    │   💬 Args: [v.borrowed, BORROWED_MIN, BORROWED_MAX]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 4)
    │   💬 Args: [v.icr, ICR_MIN, ICR_MAX]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 5)
    │   💬 Args: [v.icr, ICR_MIN + BCR[v.i], ICR_MAX]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 6)
    │   💬 Args: [v.interestRate, INTEREST_RATE_MIN, INTEREST_RATE_MAX]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._pickBatchManager(uint256,uint256) (NodeID: 7)
    │   💬 Args: [v.i, v.batchManagerSeed]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 8)
    │ │   💬 Args: [_batchManagers[i]]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 9)
    │ │     💬 Args: [set._base]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 10)
    │ │   💬 Args: [_batchManagers[i]]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 11)
    │ │     💬 Args: [set._base]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: EnumerableAddressSetMethods.get(struct EnumerableAddressSet,uint256) (NodeID: 12)
    │     💬 Args: [_batchManagers[i], rem]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 13)
    │       💬 Args: [set._base, i]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._pickHint(uint256,uint256) (NodeID: 14)
    │   💬 Args: [v.i, v.upperHintSeed]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 15)
    │ │   💬 Args: [_troveIds[i]]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 16)
    │ │   💬 Args: [_troveIds[i]]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 17)
    │     💬 Args: [_troveIds[i], rem - 1]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._pickHint(uint256,uint256) (NodeID: 18)
    │   💬 Args: [v.i, v.lowerHintSeed]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 19)
    │ │   💬 Args: [_troveIds[i]]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 20)
    │ │   💬 Args: [_troveIds[i]]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 21)
    │     💬 Args: [_troveIds[i], rem - 1]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._troveIdOf(uint256,address) (NodeID: 22)
    │   💬 Args: [v.i, msg.sender]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._isOpen(uint256,uint256) (NodeID: 23)
    │   💬 Args: [v.i, v.troveId]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 24)
    │     💬 Args: [_troveIds[i], troveId]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 25)
    │   💬 Args: ["batch manager: ", vm.getLabel(v.batchManager)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 26)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 27)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 28)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 29)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 30)
    │   💬 Args: ["upper hint: ", _hintToString(v.i, v.upperHint)]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: InvariantsTestHandler._hintToString(uint256,uint256) (NodeID: 35)
    │ │   💬 Args: [v.i, v.upperHint]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: InvariantsTestHandler._isOpen(uint256,uint256) (NodeID: 36)
    │ │ │   💬 Args: [i, troveId]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 37)
    │ │ │     💬 Args: [_troveIds[i], troveId]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 38)
    │ │     💬 Args: [troveId]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 39)
    │ │       💬 Args: [value]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 31)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 32)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 33)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 34)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 40)
    │   💬 Args: ["lower hint: ", _hintToString(v.i, v.lowerHint)]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: InvariantsTestHandler._hintToString(uint256,uint256) (NodeID: 45)
    │ │   💬 Args: [v.i, v.lowerHint]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: InvariantsTestHandler._isOpen(uint256,uint256) (NodeID: 46)
    │ │ │   💬 Args: [i, troveId]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 47)
    │ │ │     💬 Args: [_troveIds[i], troveId]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 48)
    │ │     💬 Args: [troveId]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 49)
    │ │       💬 Args: [value]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 41)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 42)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 43)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 44)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 50)
    │   💬 Args: ["upfront fee: ", v.upfrontFee.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 55)
    │ │   💬 Args: [v.upfrontFee]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 56)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 57)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 58)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 59)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 60)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 61)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 62)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 63)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 64)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 65)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 66)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 67)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 68)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 69)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 70)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 71)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 72)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 73)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 74)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 75)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 76)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 77)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 51)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 52)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 53)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 54)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseHandler.logCall(string,string,string,string,string,string,string) (NodeID: 78)
    │   💬 Args: [v.join ? "openTroveAndJoinInterestBatchManager" : "openTrove", v.i.toString(), v.borrowed.decimal(), v.icr.decimal(), v.join ? v.batchManagerSeed.toString() : v.interestRate.decimal(), v.upperHintSeed.toString(), v.lowerHintSeed.toString()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 94)
    │ │   💬 Args: [v.i]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 95)
    │ │     💬 Args: [value]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 96)
    │ │   💬 Args: [v.borrowed]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 97)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 98)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 99)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 100)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 101)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 102)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 103)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 104)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 105)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 106)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 107)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 108)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 109)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 110)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 111)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 112)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 113)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 114)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 115)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 116)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 117)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 118)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 119)
    │ │   💬 Args: [v.icr]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 120)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 121)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 122)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 123)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 124)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 125)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 126)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 127)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 128)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 129)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 130)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 131)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 132)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 133)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 134)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 135)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 136)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 137)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 138)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 139)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 140)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 141)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 142)
    │ │   💬 Args: [v.batchManagerSeed]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 143)
    │ │     💬 Args: [value]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 144)
    │ │   💬 Args: [v.interestRate]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 145)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 146)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 147)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 148)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 149)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 150)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 151)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 152)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 153)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 154)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 155)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 156)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 157)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 158)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 159)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 160)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 161)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 162)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 163)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 164)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 165)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 166)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 167)
    │ │   💬 Args: [v.upperHintSeed]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 168)
    │ │     💬 Args: [value]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 169)
    │ │   💬 Args: [v.lowerHintSeed]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 170)
    │ │     💬 Args: [value]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BaseHandler._logCaller() (NodeID: 79)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 80)
    │ │     💬 Args: ["vm.prank(", vm.getLabel(msg.sender), ");"]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: console.log(string) (NodeID: 81)
    │ │       💬 Args: [string.concat(a, b, c)]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 82)
    │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │ │         👁️  Def: internal
    │ │       └─ [7] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 83)
    │ │           💬 Args: [_sendLogPayloadView]
    │ │           👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Logging._log(string,string,string,string,string) (NodeID: 84)
    │ │   💬 Args: [_callPrefix(), functionName, "(", _csv([a, b, c, d, e, f]), ");"]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: BaseHandler._callPrefix() (NodeID: 88)
    │ │ │   💬 Args: [no args]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Logging._csv(string[6]) (NodeID: 89)
    │ │ │   💬 Args: [[a, b, c, d, e, f]]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 85)
    │ │     💬 Args: [string.concat(a, b, c, d, e)]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 86)
    │ │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 87)
    │ │         💬 Args: [_sendLogPayloadView]
    │ │         👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log() (NodeID: 90)
    │     💬 Args: [no args]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log() (NodeID: 91)
    │       💬 Args: [no args]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 92)
    │         💬 Args: [abi.encodeWithSignature("log()")]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 93)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._dealCollAndApprove(uint256,address,uint256,address) (NodeID: 171)
    │   💬 Args: [v.i, msg.sender, v.coll, address(v.c.borrowerOperations)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 172)
    │     💬 Args: [address(collToken), to, balance + amount]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 173)
    │       💬 Args: [token, to, give, false]
    │       👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 174)
    │     │   💬 Args: [stdstore, token]
    │     │   👁️  Def: internal
    │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 175)
    │     │     💬 Args: [self, _target]
    │     │     👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 176)
    │     │   💬 Args: [stdstore.target(token), 0x70a08231]
    │     │   👁️  Def: internal
    │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 177)
    │     │     💬 Args: [self, _sig]
    │     │     👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 178)
    │     │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
    │     │   👁️  Def: internal
    │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 179)
    │     │     💬 Args: [self, who]
    │     │     👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 180)
    │     │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
    │     │   👁️  Def: internal
    │     │ └─ [6] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 181)
    │     │     💬 Args: [self, bytes32(amt)]
    │     │     👁️  Def: internal
    │     │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 182)
    │     │   │   💬 Args: [self]
    │     │   │   👁️  Def: internal
    │     │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 183)
    │     │   │     💬 Args: [self._keys]
    │     │   │     👁️  Def: private
    │     │   ├─ [7] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 184)
    │     │   │   💬 Args: [self, false]
    │     │   │   👁️  Def: internal
    │     │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 185)
    │     │   │     💬 Args: [self, _clear]
    │     │   │     👁️  Def: internal
    │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 186)
    │     │   │   │   💬 Args: [self]
    │     │   │   │   👁️  Def: internal
    │     │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 187)
    │     │   │   │     💬 Args: [self._keys]
    │     │   │   │     👁️  Def: private
    │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 188)
    │     │   │   │   💬 Args: [self]
    │     │   │   │   👁️  Def: internal
    │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 189)
    │     │   │   │   💬 Args: [self]
    │     │   │   │   👁️  Def: internal
    │     │   │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 190)
    │     │   │   │ │   💬 Args: [self]
    │     │   │   │ │   👁️  Def: internal
    │     │   │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 191)
    │     │   │   │ │     💬 Args: [self._keys]
    │     │   │   │ │     👁️  Def: private
    │     │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 192)
    │     │   │   │     💬 Args: [rdat, 32 * self._depth]
    │     │   │   │     👁️  Def: private
    │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 193)
    │     │   │   │   💬 Args: [self, reads[i]]
    │     │   │   │   👁️  Def: internal
    │     │   │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 194)
    │     │   │   │ │   💬 Args: [self]
    │     │   │   │ │   👁️  Def: internal
    │     │   │   │ │ ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 195)
    │     │   │   │ │ │   💬 Args: [self]
    │     │   │   │ │ │   👁️  Def: internal
    │     │   │   │ │ │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 196)
    │     │   │   │ │ │     💬 Args: [self._keys]
    │     │   │   │ │ │     👁️  Def: private
    │     │   │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 197)
    │     │   │   │ │     💬 Args: [rdat, 32 * self._depth]
    │     │   │   │ │     👁️  Def: private
    │     │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 198)
    │     │   │   │     💬 Args: [self]
    │     │   │   │     👁️  Def: internal
    │     │   │   │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 199)
    │     │   │   │   │   💬 Args: [self]
    │     │   │   │   │   👁️  Def: internal
    │     │   │   │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 200)
    │     │   │   │   │     💬 Args: [self._keys]
    │     │   │   │   │     👁️  Def: private
    │     │   │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 201)
    │     │   │   │       💬 Args: [rdat, 32 * self._depth]
    │     │   │   │       👁️  Def: private
    │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 202)
    │     │   │   │   💬 Args: [self, reads[i]]
    │     │   │   │   👁️  Def: internal
    │     │   │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 203)
    │     │   │   │ │   💬 Args: [self, slot, true]
    │     │   │   │ │   👁️  Def: internal
    │     │   │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 204)
    │     │   │   │ │     💬 Args: [self]
    │     │   │   │ │     👁️  Def: internal
    │     │   │   │ │   ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 205)
    │     │   │   │ │   │   💬 Args: [self]
    │     │   │   │ │   │   👁️  Def: internal
    │     │   │   │ │   │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 206)
    │     │   │   │ │   │     💬 Args: [self._keys]
    │     │   │   │ │   │     👁️  Def: private
    │     │   │   │ │   └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 207)
    │     │   │   │ │       💬 Args: [rdat, 32 * self._depth]
    │     │   │   │ │       👁️  Def: private
    │     │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 208)
    │     │   │   │     💬 Args: [self, slot, false]
    │     │   │   │     👁️  Def: internal
    │     │   │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 209)
    │     │   │   │       💬 Args: [self]
    │     │   │   │       👁️  Def: internal
    │     │   │   │     ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 210)
    │     │   │   │     │   💬 Args: [self]
    │     │   │   │     │   👁️  Def: internal
    │     │   │   │     │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 211)
    │     │   │   │     │     💬 Args: [self._keys]
    │     │   │   │     │     👁️  Def: private
    │     │   │   │     └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 212)
    │     │   │   │         💬 Args: [rdat, 32 * self._depth]
    │     │   │   │         👁️  Def: private
    │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 213)
    │     │   │   │   💬 Args: [offsetLeft, offsetRight]
    │     │   │   │   👁️  Def: internal
    │     │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 214)
    │     │   │       💬 Args: [self]
    │     │   │       👁️  Def: internal
    │     │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 215)
    │     │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
    │     │   │   👁️  Def: internal
    │     │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 216)
    │     │   │     💬 Args: [offsetLeft, offsetRight]
    │     │   │     👁️  Def: internal
    │     │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 217)
    │     │   │   💬 Args: [self]
    │     │   │   👁️  Def: internal
    │     │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 218)
    │     │   │ │   💬 Args: [self]
    │     │   │ │   👁️  Def: internal
    │     │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 219)
    │     │   │ │     💬 Args: [self._keys]
    │     │   │ │     👁️  Def: private
    │     │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 220)
    │     │   │     💬 Args: [rdat, 32 * self._depth]
    │     │   │     👁️  Def: private
    │     │   └─ [7] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 221)
    │     │       💬 Args: [self]
    │     │       👁️  Def: internal
    │     │     └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 222)
    │     │         💬 Args: [self]
    │     │         👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 223)
    │     │   💬 Args: [stdstore, token]
    │     │   👁️  Def: internal
    │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 224)
    │     │     💬 Args: [self, _target]
    │     │     👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 225)
    │     │   💬 Args: [stdstore.target(token), 0x18160ddd]
    │     │   👁️  Def: internal
    │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 226)
    │     │     💬 Args: [self, _sig]
    │     │     👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 227)
    │         💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 228)
    │           💬 Args: [self, bytes32(amt)]
    │           👁️  Def: internal
    │         ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 229)
    │         │   💬 Args: [self]
    │         │   👁️  Def: internal
    │         │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 230)
    │         │     💬 Args: [self._keys]
    │         │     👁️  Def: private
    │         ├─ [7] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 231)
    │         │   💬 Args: [self, false]
    │         │   👁️  Def: internal
    │         │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 232)
    │         │     💬 Args: [self, _clear]
    │         │     👁️  Def: internal
    │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 233)
    │         │   │   💬 Args: [self]
    │         │   │   👁️  Def: internal
    │         │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 234)
    │         │   │     💬 Args: [self._keys]
    │         │   │     👁️  Def: private
    │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 235)
    │         │   │   💬 Args: [self]
    │         │   │   👁️  Def: internal
    │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 236)
    │         │   │   💬 Args: [self]
    │         │   │   👁️  Def: internal
    │         │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 237)
    │         │   │ │   💬 Args: [self]
    │         │   │ │   👁️  Def: internal
    │         │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 238)
    │         │   │ │     💬 Args: [self._keys]
    │         │   │ │     👁️  Def: private
    │         │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 239)
    │         │   │     💬 Args: [rdat, 32 * self._depth]
    │         │   │     👁️  Def: private
    │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 240)
    │         │   │   💬 Args: [self, reads[i]]
    │         │   │   👁️  Def: internal
    │         │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 241)
    │         │   │ │   💬 Args: [self]
    │         │   │ │   👁️  Def: internal
    │         │   │ │ ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 242)
    │         │   │ │ │   💬 Args: [self]
    │         │   │ │ │   👁️  Def: internal
    │         │   │ │ │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 243)
    │         │   │ │ │     💬 Args: [self._keys]
    │         │   │ │ │     👁️  Def: private
    │         │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 244)
    │         │   │ │     💬 Args: [rdat, 32 * self._depth]
    │         │   │ │     👁️  Def: private
    │         │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 245)
    │         │   │     💬 Args: [self]
    │         │   │     👁️  Def: internal
    │         │   │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 246)
    │         │   │   │   💬 Args: [self]
    │         │   │   │   👁️  Def: internal
    │         │   │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 247)
    │         │   │   │     💬 Args: [self._keys]
    │         │   │   │     👁️  Def: private
    │         │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 248)
    │         │   │       💬 Args: [rdat, 32 * self._depth]
    │         │   │       👁️  Def: private
    │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 249)
    │         │   │   💬 Args: [self, reads[i]]
    │         │   │   👁️  Def: internal
    │         │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 250)
    │         │   │ │   💬 Args: [self, slot, true]
    │         │   │ │   👁️  Def: internal
    │         │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 251)
    │         │   │ │     💬 Args: [self]
    │         │   │ │     👁️  Def: internal
    │         │   │ │   ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 252)
    │         │   │ │   │   💬 Args: [self]
    │         │   │ │   │   👁️  Def: internal
    │         │   │ │   │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 253)
    │         │   │ │   │     💬 Args: [self._keys]
    │         │   │ │   │     👁️  Def: private
    │         │   │ │   └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 254)
    │         │   │ │       💬 Args: [rdat, 32 * self._depth]
    │         │   │ │       👁️  Def: private
    │         │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 255)
    │         │   │     💬 Args: [self, slot, false]
    │         │   │     👁️  Def: internal
    │         │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 256)
    │         │   │       💬 Args: [self]
    │         │   │       👁️  Def: internal
    │         │   │     ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 257)
    │         │   │     │   💬 Args: [self]
    │         │   │     │   👁️  Def: internal
    │         │   │     │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 258)
    │         │   │     │     💬 Args: [self._keys]
    │         │   │     │     👁️  Def: private
    │         │   │     └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 259)
    │         │   │         💬 Args: [rdat, 32 * self._depth]
    │         │   │         👁️  Def: private
    │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 260)
    │         │   │   💬 Args: [offsetLeft, offsetRight]
    │         │   │   👁️  Def: internal
    │         │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 261)
    │         │       💬 Args: [self]
    │         │       👁️  Def: internal
    │         ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 262)
    │         │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
    │         │   👁️  Def: internal
    │         │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 263)
    │         │     💬 Args: [offsetLeft, offsetRight]
    │         │     👁️  Def: internal
    │         ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 264)
    │         │   💬 Args: [self]
    │         │   👁️  Def: internal
    │         │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 265)
    │         │ │   💬 Args: [self]
    │         │ │   👁️  Def: internal
    │         │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 266)
    │         │ │     💬 Args: [self._keys]
    │         │ │     👁️  Def: private
    │         │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 267)
    │         │     💬 Args: [rdat, 32 * self._depth]
    │         │     👁️  Def: private
    │         └─ [7] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 268)
    │             💬 Args: [self]
    │             👁️  Def: internal
    │           └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 269)
    │               💬 Args: [self]
    │               👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._dealWETHAndApprove(address,uint256,address) (NodeID: 270)
    │   💬 Args: [msg.sender, ETH_GAS_COMPENSATION, address(v.c.borrowerOperations)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 271)
    │     💬 Args: [address(weth), to, balance + amount]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 272)
    │       💬 Args: [token, to, give, false]
    │       👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 273)
    │     │   💬 Args: [stdstore, token]
    │     │   👁️  Def: internal
    │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 274)
    │     │     💬 Args: [self, _target]
    │     │     👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 275)
    │     │   💬 Args: [stdstore.target(token), 0x70a08231]
    │     │   👁️  Def: internal
    │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 276)
    │     │     💬 Args: [self, _sig]
    │     │     👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 277)
    │     │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
    │     │   👁️  Def: internal
    │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 278)
    │     │     💬 Args: [self, who]
    │     │     👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 279)
    │     │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
    │     │   👁️  Def: internal
    │     │ └─ [6] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 280)
    │     │     💬 Args: [self, bytes32(amt)]
    │     │     👁️  Def: internal
    │     │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 281)
    │     │   │   💬 Args: [self]
    │     │   │   👁️  Def: internal
    │     │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 282)
    │     │   │     💬 Args: [self._keys]
    │     │   │     👁️  Def: private
    │     │   ├─ [7] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 283)
    │     │   │   💬 Args: [self, false]
    │     │   │   👁️  Def: internal
    │     │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 284)
    │     │   │     💬 Args: [self, _clear]
    │     │   │     👁️  Def: internal
    │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 285)
    │     │   │   │   💬 Args: [self]
    │     │   │   │   👁️  Def: internal
    │     │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 286)
    │     │   │   │     💬 Args: [self._keys]
    │     │   │   │     👁️  Def: private
    │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 287)
    │     │   │   │   💬 Args: [self]
    │     │   │   │   👁️  Def: internal
    │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 288)
    │     │   │   │   💬 Args: [self]
    │     │   │   │   👁️  Def: internal
    │     │   │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 289)
    │     │   │   │ │   💬 Args: [self]
    │     │   │   │ │   👁️  Def: internal
    │     │   │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 290)
    │     │   │   │ │     💬 Args: [self._keys]
    │     │   │   │ │     👁️  Def: private
    │     │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 291)
    │     │   │   │     💬 Args: [rdat, 32 * self._depth]
    │     │   │   │     👁️  Def: private
    │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 292)
    │     │   │   │   💬 Args: [self, reads[i]]
    │     │   │   │   👁️  Def: internal
    │     │   │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 293)
    │     │   │   │ │   💬 Args: [self]
    │     │   │   │ │   👁️  Def: internal
    │     │   │   │ │ ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 294)
    │     │   │   │ │ │   💬 Args: [self]
    │     │   │   │ │ │   👁️  Def: internal
    │     │   │   │ │ │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 295)
    │     │   │   │ │ │     💬 Args: [self._keys]
    │     │   │   │ │ │     👁️  Def: private
    │     │   │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 296)
    │     │   │   │ │     💬 Args: [rdat, 32 * self._depth]
    │     │   │   │ │     👁️  Def: private
    │     │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 297)
    │     │   │   │     💬 Args: [self]
    │     │   │   │     👁️  Def: internal
    │     │   │   │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 298)
    │     │   │   │   │   💬 Args: [self]
    │     │   │   │   │   👁️  Def: internal
    │     │   │   │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 299)
    │     │   │   │   │     💬 Args: [self._keys]
    │     │   │   │   │     👁️  Def: private
    │     │   │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 300)
    │     │   │   │       💬 Args: [rdat, 32 * self._depth]
    │     │   │   │       👁️  Def: private
    │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 301)
    │     │   │   │   💬 Args: [self, reads[i]]
    │     │   │   │   👁️  Def: internal
    │     │   │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 302)
    │     │   │   │ │   💬 Args: [self, slot, true]
    │     │   │   │ │   👁️  Def: internal
    │     │   │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 303)
    │     │   │   │ │     💬 Args: [self]
    │     │   │   │ │     👁️  Def: internal
    │     │   │   │ │   ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 304)
    │     │   │   │ │   │   💬 Args: [self]
    │     │   │   │ │   │   👁️  Def: internal
    │     │   │   │ │   │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 305)
    │     │   │   │ │   │     💬 Args: [self._keys]
    │     │   │   │ │   │     👁️  Def: private
    │     │   │   │ │   └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 306)
    │     │   │   │ │       💬 Args: [rdat, 32 * self._depth]
    │     │   │   │ │       👁️  Def: private
    │     │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 307)
    │     │   │   │     💬 Args: [self, slot, false]
    │     │   │   │     👁️  Def: internal
    │     │   │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 308)
    │     │   │   │       💬 Args: [self]
    │     │   │   │       👁️  Def: internal
    │     │   │   │     ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 309)
    │     │   │   │     │   💬 Args: [self]
    │     │   │   │     │   👁️  Def: internal
    │     │   │   │     │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 310)
    │     │   │   │     │     💬 Args: [self._keys]
    │     │   │   │     │     👁️  Def: private
    │     │   │   │     └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 311)
    │     │   │   │         💬 Args: [rdat, 32 * self._depth]
    │     │   │   │         👁️  Def: private
    │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 312)
    │     │   │   │   💬 Args: [offsetLeft, offsetRight]
    │     │   │   │   👁️  Def: internal
    │     │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 313)
    │     │   │       💬 Args: [self]
    │     │   │       👁️  Def: internal
    │     │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 314)
    │     │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
    │     │   │   👁️  Def: internal
    │     │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 315)
    │     │   │     💬 Args: [offsetLeft, offsetRight]
    │     │   │     👁️  Def: internal
    │     │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 316)
    │     │   │   💬 Args: [self]
    │     │   │   👁️  Def: internal
    │     │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 317)
    │     │   │ │   💬 Args: [self]
    │     │   │ │   👁️  Def: internal
    │     │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 318)
    │     │   │ │     💬 Args: [self._keys]
    │     │   │ │     👁️  Def: private
    │     │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 319)
    │     │   │     💬 Args: [rdat, 32 * self._depth]
    │     │   │     👁️  Def: private
    │     │   └─ [7] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 320)
    │     │       💬 Args: [self]
    │     │       👁️  Def: internal
    │     │     └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 321)
    │     │         💬 Args: [self]
    │     │         👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 322)
    │     │   💬 Args: [stdstore, token]
    │     │   👁️  Def: internal
    │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 323)
    │     │     💬 Args: [self, _target]
    │     │     👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 324)
    │     │   💬 Args: [stdstore.target(token), 0x18160ddd]
    │     │   👁️  Def: internal
    │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 325)
    │     │     💬 Args: [self, _sig]
    │     │     👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 326)
    │         💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 327)
    │           💬 Args: [self, bytes32(amt)]
    │           👁️  Def: internal
    │         ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 328)
    │         │   💬 Args: [self]
    │         │   👁️  Def: internal
    │         │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 329)
    │         │     💬 Args: [self._keys]
    │         │     👁️  Def: private
    │         ├─ [7] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 330)
    │         │   💬 Args: [self, false]
    │         │   👁️  Def: internal
    │         │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 331)
    │         │     💬 Args: [self, _clear]
    │         │     👁️  Def: internal
    │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 332)
    │         │   │   💬 Args: [self]
    │         │   │   👁️  Def: internal
    │         │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 333)
    │         │   │     💬 Args: [self._keys]
    │         │   │     👁️  Def: private
    │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 334)
    │         │   │   💬 Args: [self]
    │         │   │   👁️  Def: internal
    │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 335)
    │         │   │   💬 Args: [self]
    │         │   │   👁️  Def: internal
    │         │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 336)
    │         │   │ │   💬 Args: [self]
    │         │   │ │   👁️  Def: internal
    │         │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 337)
    │         │   │ │     💬 Args: [self._keys]
    │         │   │ │     👁️  Def: private
    │         │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 338)
    │         │   │     💬 Args: [rdat, 32 * self._depth]
    │         │   │     👁️  Def: private
    │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 339)
    │         │   │   💬 Args: [self, reads[i]]
    │         │   │   👁️  Def: internal
    │         │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 340)
    │         │   │ │   💬 Args: [self]
    │         │   │ │   👁️  Def: internal
    │         │   │ │ ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 341)
    │         │   │ │ │   💬 Args: [self]
    │         │   │ │ │   👁️  Def: internal
    │         │   │ │ │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 342)
    │         │   │ │ │     💬 Args: [self._keys]
    │         │   │ │ │     👁️  Def: private
    │         │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 343)
    │         │   │ │     💬 Args: [rdat, 32 * self._depth]
    │         │   │ │     👁️  Def: private
    │         │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 344)
    │         │   │     💬 Args: [self]
    │         │   │     👁️  Def: internal
    │         │   │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 345)
    │         │   │   │   💬 Args: [self]
    │         │   │   │   👁️  Def: internal
    │         │   │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 346)
    │         │   │   │     💬 Args: [self._keys]
    │         │   │   │     👁️  Def: private
    │         │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 347)
    │         │   │       💬 Args: [rdat, 32 * self._depth]
    │         │   │       👁️  Def: private
    │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 348)
    │         │   │   💬 Args: [self, reads[i]]
    │         │   │   👁️  Def: internal
    │         │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 349)
    │         │   │ │   💬 Args: [self, slot, true]
    │         │   │ │   👁️  Def: internal
    │         │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 350)
    │         │   │ │     💬 Args: [self]
    │         │   │ │     👁️  Def: internal
    │         │   │ │   ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 351)
    │         │   │ │   │   💬 Args: [self]
    │         │   │ │   │   👁️  Def: internal
    │         │   │ │   │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 352)
    │         │   │ │   │     💬 Args: [self._keys]
    │         │   │ │   │     👁️  Def: private
    │         │   │ │   └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 353)
    │         │   │ │       💬 Args: [rdat, 32 * self._depth]
    │         │   │ │       👁️  Def: private
    │         │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 354)
    │         │   │     💬 Args: [self, slot, false]
    │         │   │     👁️  Def: internal
    │         │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 355)
    │         │   │       💬 Args: [self]
    │         │   │       👁️  Def: internal
    │         │   │     ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 356)
    │         │   │     │   💬 Args: [self]
    │         │   │     │   👁️  Def: internal
    │         │   │     │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 357)
    │         │   │     │     💬 Args: [self._keys]
    │         │   │     │     👁️  Def: private
    │         │   │     └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 358)
    │         │   │         💬 Args: [rdat, 32 * self._depth]
    │         │   │         👁️  Def: private
    │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 359)
    │         │   │   💬 Args: [offsetLeft, offsetRight]
    │         │   │   👁️  Def: internal
    │         │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 360)
    │         │       💬 Args: [self]
    │         │       👁️  Def: internal
    │         ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 361)
    │         │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
    │         │   👁️  Def: internal
    │         │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 362)
    │         │     💬 Args: [offsetLeft, offsetRight]
    │         │     👁️  Def: internal
    │         ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 363)
    │         │   💬 Args: [self]
    │         │   👁️  Def: internal
    │         │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 364)
    │         │ │   💬 Args: [self]
    │         │ │   👁️  Def: internal
    │         │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 365)
    │         │ │     💬 Args: [self._keys]
    │         │ │     👁️  Def: private
    │         │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 366)
    │         │     💬 Args: [rdat, 32 * self._depth]
    │         │     👁️  Def: private
    │         └─ [7] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 367)
    │             💬 Args: [self]
    │             👁️  Def: internal
    │           └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 368)
    │               💬 Args: [self]
    │               👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._encodeOpenTrove(struct InvariantsTestHandler.OpenTroveContext) (NodeID: 369)
    │   💬 Args: [v]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 370)
    │   💬 Args: [v.i, v.coll, v.debt]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._TCR(uint256) (NodeID: 371)
    │   💬 Args: [v.i]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: InvariantsTestHandler._TCR(uint256,int256,int256,uint256) (NodeID: 372)
    │     💬 Args: [i, 0, 0, 0]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 373)
    │   │   💬 Args: [branches[i].troveManager.getEntireBranchColl(), collDelta]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 374)
    │   │   💬 Args: [branches[i].troveManager.getEntireBranchDebt(), debtDelta]
    │   │   👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 375)
    │       💬 Args: [i, coll, debt]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 376)
    │   💬 Args: [_batchManagers[v.i].has(v.batchManager), "Should have failed as batch manager wasn't valid"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: EnumerableAddressSetMethods.has(struct EnumerableAddressSet,address) (NodeID: 377)
    │     💬 Args: [_batchManagers[v.i], v.batchManager]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 378)
    │       💬 Args: [set._base, uint256(uint160(element))]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGeDecimal(uint256,uint256,uint256,string) (NodeID: 379)
    │   💬 Args: [v.interestRate, MIN_ANNUAL_INTEREST_RATE, 18, "Should have failed as rate < min"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertLeDecimal(uint256,uint256,uint256,string) (NodeID: 380)
    │   💬 Args: [v.interestRate, MAX_ANNUAL_INTEREST_RATE, 18, "Should have failed as rate > max"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 381)
    │   💬 Args: [isShutdown[v.i], "Should have failed as branch had been shut down"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 382)
    │   💬 Args: [v.wasOpen, "Should have failed as Trove was open"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGeDecimal(uint256,uint256,uint256,string) (NodeID: 383)
    │   💬 Args: [v.debt, MIN_DEBT, 18, "Should have failed as debt < min"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGeDecimal(uint256,uint256,uint256,string) (NodeID: 384)
    │   💬 Args: [icr_, MCR[v.i], 18, "Should have failed as ICR < MCR"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGeDecimal(uint256,uint256,uint256,string) (NodeID: 385)
    │   💬 Args: [icr_, MCR[v.i] + BCR[v.i], 18, "Should have failed as ICR < MCR + BCR"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGeDecimal(uint256,uint256,uint256,string) (NodeID: 386)
    │   💬 Args: [newTCR, CCR[v.i], 18, "Should have failed as new TCR < CCR"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.add(struct EnumerableSet,uint256) (NodeID: 387)
    │   💬 Args: [_troveIds[v.i], v.troveId]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 388)
    │     💬 Args: [set, element]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: EnumerableSetMethods.add(struct EnumerableSet,uint256) (NodeID: 389)
    │   💬 Args: [batch.troves, v.troveId]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 390)
    │     💬 Args: [set, element]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._touchBatch(uint256,address) (NodeID: 391)
    │   💬 Args: [v.i, v.batchManager]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 392)
    │ │   💬 Args: [_batches[i][batchManager].troves]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 393)
    │ │   💬 Args: [_batches[i][batchManager].troves, j]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: TroveMethods.applyPendingInterest(struct Trove) (NodeID: 394)
    │ │   💬 Args: [trove]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: TroveMethods.applyPendingBatchManagementFee(struct Trove) (NodeID: 395)
    │     💬 Args: [trove]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._mintYield(uint256,uint256,uint256) (NodeID: 396)
    │   💬 Args: [v.i, v.pendingInterest, v.upfrontFee]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._decodeCustomError(bytes) (NodeID: 397)
    │   💬 Args: [revertData]
    │   👁️  Def: public
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 398)
    │ │   💬 Args: [revertData, 4]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 399)
    │ │     💬 Args: [str, start, int256(str.length)]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 400)
    │ │   💬 Args: [uint256(param)]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 401)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 402)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 403)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 404)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 405)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 406)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 407)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 408)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 409)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 410)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 411)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 412)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 413)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 414)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 415)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 416)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 417)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 418)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 419)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 420)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 421)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 422)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: InvariantsTestHandler._revert(bytes) (NodeID: 423)
    │     💬 Args: [revertData]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 424)
    │   💬 Args: [v.join, "Shouldn't have failed as a batch wasn't joined"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 425)
    │   💬 Args: [_batchManagers[v.i].has(v.batchManager), "Shouldn't have failed as batch manager was valid"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: EnumerableAddressSetMethods.has(struct EnumerableAddressSet,address) (NodeID: 426)
    │     💬 Args: [_batchManagers[v.i], v.batchManager]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 427)
    │       💬 Args: [set._base, uint256(uint160(element))]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 428)
    │   💬 Args: [v.join, "Shouldn't have failed as a batch was joined"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertLtDecimal(uint256,uint256,uint256,string) (NodeID: 429)
    │   💬 Args: [v.interestRate, MIN_ANNUAL_INTEREST_RATE, 18, "Shouldn't have failed as rate >= min"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 430)
    │   💬 Args: [v.join, "Shouldn't have failed as a batch was joined"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGtDecimal(uint256,uint256,uint256,string) (NodeID: 431)
    │   💬 Args: [v.interestRate, MAX_ANNUAL_INTEREST_RATE, 18, "Shouldn't have failed as rate <= max"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 432)
    │   💬 Args: [isShutdown[v.i], "Shouldn't have failed as branch hadn't been shut down"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 433)
    │   💬 Args: [v.wasOpen, "Shouldn't have failed as Trove didn't exist"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertLtDecimal(uint256,uint256,uint256,string) (NodeID: 434)
    │   💬 Args: [v.debt, MIN_DEBT, 18, "Shouldn't have failed as debt >= min"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 435)
    │   💬 Args: [v.join, "Shouldn't have thrown ICRBelowMCR as a batch was joined"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 436)
    │   💬 Args: [v.i, v.coll, v.debt]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertLtDecimal(uint256,uint256,uint256,string) (NodeID: 437)
    │   💬 Args: [icr_, MCR[v.i], 18, "Shouldn't have failed as ICR >= MCR"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 438)
    │   💬 Args: [v.join, "Shouldn't have thrown ICRBelowMCRPlusBCR as a batch wasn't joined"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 439)
    │   💬 Args: [v.i, v.coll, v.debt]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertLtDecimal(uint256,uint256,uint256,string) (NodeID: 440)
    │   💬 Args: [icr_, MCR[v.i] + BCR[v.i], 18, "Shouldn't have failed as ICR >= MCR + BCR"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._TCR(uint256,int256,int256,uint256) (NodeID: 441)
    │   💬 Args: [v.i, int256(v.coll), int256(v.borrowed), v.upfrontFee]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 442)
    │ │   💬 Args: [branches[i].troveManager.getEntireBranchColl(), collDelta]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 443)
    │ │   💬 Args: [branches[i].troveManager.getEntireBranchDebt(), debtDelta]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: InvariantsTestHandler._CR(uint256,uint256,uint256) (NodeID: 444)
    │     💬 Args: [i, coll, debt]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertLtDecimal(uint256,uint256,uint256,string) (NodeID: 445)
    │   💬 Args: [newTCR, CCR[v.i], 18, "Shouldn't have failed as new TCR >= CCR"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 446)
    │   💬 Args: ["New TCR would have been: ", newTCR.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 451)
    │ │   💬 Args: [newTCR]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 452)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 453)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 454)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 455)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 456)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 457)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 458)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 459)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 460)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 461)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 462)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 463)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 464)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 465)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 466)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 467)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 468)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 469)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 470)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 471)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 472)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 473)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 447)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 448)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 449)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 450)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 474)
    │   💬 Args: ["Expected error: ", v.errorString]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 475)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 476)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 477)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 478)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging._log() (NodeID: 479)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: console.log() (NodeID: 480)
    │     💬 Args: [no args]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 481)
    │       💬 Args: [abi.encodeWithSignature("log()")]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 482)
    │         💬 Args: [_sendLogPayloadView]
    │         👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._sweepCollAndUnapprove(uint256,address,uint256,address) (NodeID: 483)
    │   💬 Args: [v.i, msg.sender, v.coll, address(v.c.borrowerOperations)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: InvariantsTestHandler._sweepColl(uint256,address,uint256) (NodeID: 484)
    │     💬 Args: [i, from, amount]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._sweepWETHAndUnapprove(address,uint256,address) (NodeID: 485)
    │   💬 Args: [msg.sender, ETH_GAS_COMPENSATION, address(v.c.borrowerOperations)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: InvariantsTestHandler._sweepWETH(address,uint256) (NodeID: 486)
    │     💬 Args: [from, amount]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._sweepBold(address,uint256) (NodeID: 487)
    │   💬 Args: [msg.sender, v.borrowed]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: InvariantsTestHandler._sweepBold(address,uint256) (NodeID: 488)
        💬 Args: [v.batchManager, v.batchManagementFee]
        👁️  Def: internal
```
