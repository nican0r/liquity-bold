# Function: setPrice(uint256,uint256)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `setPrice(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 18809:613:270

## Implementation

```solidity
function setPrice(uint256 i, uint256 tcr) external {
    i = _bound(i, 0, branches.length - 1);
    tcr = _bound(tcr, TCR_MIN, TCR_MAX);
    uint256 totalColl = branches[i].troveManager.getEntireBranchColl();
    uint256 totalDebt = branches[i].troveManager.getEntireBranchDebt();
    vm.assume(totalColl > 0);
    uint256 price = (totalDebt * tcr) / totalColl;
    vm.assume(price > DECIMAL_PRECISION);
    info("price: ", price.decimal());
    logCall("setPrice", i.toString(), tcr.decimal());
    branches[i].priceFeed.setPrice(price);
    _price[i] = price;
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

## External Calls

- **ITroveManagerTester::getEntireBranchColl()**
- **ITroveManagerTester::getEntireBranchDebt()**
- **Vm::assume(bool)**
- **IPriceFeedTestnet::setPrice(uint256)**

## State Variable Reads

- **UINT256_MAX** (`uint256`)
- **ONE** (`uint256`)
- **DECIMAL_UNIT** (`string`)
- **DECIMAL_SEPARATOR** (`string`)
- **GROUP_DIGITS** (`uint256`)
- **GROUP_SEPARATOR** (`bytes1`)

## State Variable Writes

- **_price** (`mapping(uint256 => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.setPrice(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [i, 0, branches.length - 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 2)
  │   💬 Args: [tcr, TCR_MIN, TCR_MAX]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 3)
  │   💬 Args: ["price: ", price.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 8)
  │ │   💬 Args: [price]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 9)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 10)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 11)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 12)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 13)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 14)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 15)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 16)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 17)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 18)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 19)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 20)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 21)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 22)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 23)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 24)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 25)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 26)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 27)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 28)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 29)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 30)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 4)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 5)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 6)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 7)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseHandler.logCall(string,string,string) (NodeID: 31)
      💬 Args: ["setPrice", i.toString(), tcr.decimal()]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 47)
    │   💬 Args: [i]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 48)
    │     💬 Args: [value]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 49)
    │   💬 Args: [tcr]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 50)
    │ │   💬 Args: [integerPart]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 51)
    │ │ │   💬 Args: [n]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 52)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 53)
    │ │     💬 Args: [n.toString()]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 54)
    │ │   │   💬 Args: [bytes(str)]
    │ │   │   👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 55)
    │ │       💬 Args: [bytes(str).groupRight()]
    │ │       👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 56)
    │ │   💬 Args: [integerPart]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 57)
    │ │ │   💬 Args: [n]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 58)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 59)
    │ │     💬 Args: [n.toString()]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 60)
    │ │   │   💬 Args: [bytes(str)]
    │ │   │   👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 61)
    │ │       💬 Args: [bytes(str).groupRight()]
    │ │       👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 62)
    │ │   💬 Args: [(ONE + fractionalPart)]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 63)
    │ │     💬 Args: [value]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 64)
    │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 65)
    │ │ │   💬 Args: [bytes(str), start]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 66)
    │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 67)
    │ │     💬 Args: [bytes(str).slice(start)]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 68)
    │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 69)
    │   │   💬 Args: [bytes(str), char]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 70)
    │   │     💬 Args: [str, 0, int256(end)]
    │   │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 71)
    │       💬 Args: [bytes(str).trimEnd(char)]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseHandler._logCaller() (NodeID: 32)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 33)
    │     💬 Args: ["vm.prank(", vm.getLabel(msg.sender), ");"]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 34)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 35)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 36)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging._log(string,string,string,string,string) (NodeID: 37)
    │   💬 Args: [_callPrefix(), functionName, "(", _csv([a, b]), ");"]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BaseHandler._callPrefix() (NodeID: 41)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Logging._csv(string[2]) (NodeID: 42)
    │ │   💬 Args: [[a, b]]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 38)
    │     💬 Args: [string.concat(a, b, c, d, e)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 39)
    │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 40)
    │         💬 Args: [_sendLogPayloadView]
    │         👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Logging._log() (NodeID: 43)
        💬 Args: [no args]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: console.log() (NodeID: 44)
          💬 Args: [no args]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 45)
            💬 Args: [abi.encodeWithSignature("log()")]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 46)
              💬 Args: [_sendLogPayloadView]
              👁️  Def: internal
```
