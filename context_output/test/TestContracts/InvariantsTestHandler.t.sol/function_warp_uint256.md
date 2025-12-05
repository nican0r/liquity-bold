# Function: warp(uint256)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `warp(uint256)`
- **Visibility**: external
- **Source Range**: 17248:1555:270

## Implementation

```solidity
function warp(uint256 timeDelta) external {
    timeDelta = _bound(timeDelta, TIME_DELTA_MIN, TIME_DELTA_MAX);
    logCall("warp", timeDelta.groupRight());
    vm.warp(block.timestamp + timeDelta);
    _timeSinceLastRedemption += timeDelta;
    for (uint256 j = 0; j < branches.length; ++j) {
        for (uint256 i = 0; i < _troveIds[j].size(); ++i) {
            uint256 troveId = _troveIds[j].get(i);
            address batchManager = _batchManagerOf[j][troveId];
            Trove storage trove = _troves[j][troveId];
            _timeSinceLastTroveInterestRateAdjustment[j][troveId] += timeDelta;
            if (isShutdown[j]) continue;
            uint256 interest = trove.accrueInterest(timeDelta);
            uint256 batchManagementFee = trove.accrueBatchManagementFee(timeDelta);
            if (batchManagementFee > 0) {
                assertNotEq(batchManager, address(0), "Trove accruing batch management fee should have batch manager");
            }
            _pendingInterest[j] += interest;
            _batches[j][batchManager].pendingManagementFee += batchManagementFee;
        }
        for (uint256 i = 0; i < _batchManagers[j].size(); ++i) {
            address batchManager = _batchManagers[j].get(i);
            _timeSinceLastBatchInterestRateAdjustment[j][batchManager] += timeDelta;
        }
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

### accrueInterest(struct Trove,uint256)

- **Kind**: internal
- **Source**: 937:197:293
- **Link**: `test/Utils/Trove.sol:TroveMethods:accrueInterest(struct Trove,uint256)`

```solidity
function accrueInterest(Trove storage trove, uint256 timeDelta) internal returns (uint256 interest) {
    trove._pendingInterest += interest = (trove.debt * trove.interestRate) * timeDelta;
}
```

### accrueBatchManagementFee(struct Trove,uint256)

- **Kind**: internal
- **Source**: 1140:264:293
- **Link**: `test/Utils/Trove.sol:TroveMethods:accrueBatchManagementFee(struct Trove,uint256)`

```solidity
function accrueBatchManagementFee(Trove storage trove, uint256 timeDelta) internal returns (uint256 batchManagementFee) {
    trove._pendingBatchManagementFee += batchManagementFee = (trove.debt * trove.batchManagementRate) * timeDelta;
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

## External Calls

- **Vm::warp(uint256)**

## State Variable Reads

- **_troveIds** (`mapping(uint256 => struct EnumerableSet)`)
- **_batchManagerOf** (`mapping(uint256 => mapping(uint256 => address))`)
- **_troves** (`mapping(uint256 => mapping(uint256 => struct Trove))`)
- **isShutdown** (`mapping(uint256 => bool)`)
- **_batchManagers** (`mapping(uint256 => struct EnumerableAddressSet)`)
- **UINT256_MAX** (`uint256`)
- **GROUP_DIGITS** (`uint256`)
- **GROUP_SEPARATOR** (`bytes1`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## State Variable Writes

- **_timeSinceLastRedemption** (`uint256`)
- **_timeSinceLastTroveInterestRateAdjustment** (`mapping(uint256 => mapping(uint256 => uint256))`)
- **_pendingInterest** (`mapping(uint256 => uint256)`)
- **_batches** (`mapping(uint256 => mapping(address => struct InvariantsTestHandler.Batch))`)
- **_timeSinceLastBatchInterestRateAdjustment** (`mapping(uint256 => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.warp(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [timeDelta, TIME_DELTA_MIN, TIME_DELTA_MAX]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseHandler.logCall(string,string) (NodeID: 2)
  │   💬 Args: ["warp", timeDelta.groupRight()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 17)
  │ │   💬 Args: [timeDelta]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 18)
  │ │ │   💬 Args: [n]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 19)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 20)
  │ │     💬 Args: [n.toString()]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 21)
  │ │   │   💬 Args: [bytes(str)]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 22)
  │ │       💬 Args: [bytes(str).groupRight()]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseHandler._logCaller() (NodeID: 3)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 4)
  │ │     💬 Args: ["vm.prank(", vm.getLabel(msg.sender), ");"]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 5)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 6)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 7)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging._log(string,string,string,string,string) (NodeID: 8)
  │ │   💬 Args: [_callPrefix(), functionName, "(", a, ");"]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseHandler._callPrefix() (NodeID: 12)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 9)
  │ │     💬 Args: [string.concat(a, b, c, d, e)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 10)
  │ │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 11)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log() (NodeID: 13)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log() (NodeID: 14)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 15)
  │         💬 Args: [abi.encodeWithSignature("log()")]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 16)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 23)
  │   💬 Args: [_troveIds[j]]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 24)
  │   💬 Args: [_troveIds[j], i]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveMethods.accrueInterest(struct Trove,uint256) (NodeID: 25)
  │   💬 Args: [trove, timeDelta]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveMethods.accrueBatchManagementFee(struct Trove,uint256) (NodeID: 26)
  │   💬 Args: [trove, timeDelta]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 27)
  │   💬 Args: [batchManager, address(0), "Trove accruing batch management fee should have batch manager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableAddressSetMethods.size(struct EnumerableAddressSet) (NodeID: 28)
  │   💬 Args: [_batchManagers[j]]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 29)
  │     💬 Args: [set._base]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: EnumerableAddressSetMethods.get(struct EnumerableAddressSet,uint256) (NodeID: 30)
      💬 Args: [_batchManagers[j], i]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 31)
        💬 Args: [set._base, i]
        👁️  Def: internal
```
