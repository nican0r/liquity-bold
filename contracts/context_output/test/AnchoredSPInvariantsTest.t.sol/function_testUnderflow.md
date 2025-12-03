# Function: testUnderflow()

**Contract**: [test/AnchoredSPInvariantsTest.t.sol/contract_AnchoredSPInvariantsTest.md]

## Metadata

- **Contract**: AnchoredSPInvariantsTest
- **Signature**: `testUnderflow()`
- **Visibility**: external
- **Source Range**: 13835:5134:228

## Implementation

```solidity
function testUnderflow() external {
    vm.prank(gabe);
    handler.openTrove(98_000.000000000000000021 ether);
    vm.prank(carl);
    handler.provideToSp(9.397260273972700749 ether, false);
    vm.prank(carl);
    handler.provideToSp(0.000000000000019902 ether, false);
    vm.prank(eric);
    handler.provideToSp(12.028493150685049425 ether, false);
    vm.prank(fran);
    handler.provideToSp(24.05698630137009885 ether, false);
    vm.prank(eric);
    handler.provideToSp(48.11397260274029571 ether, false);
    vm.prank(hope);
    handler.provideToSp(22_378.224492402901169486 ether, false);
    vm.prank(adam);
    handler.openTrove(89_347.597397303914417174 ether);
    vm.prank(adam);
    handler.provideToSp(66_119.976516875041256465 ether, false);
    vm.prank(hope);
    handler.openTrove(98_000.000000000000002581 ether);
    vm.prank(carl);
    handler.provideToSp(99_018.369068280498073463 ether, false);
    vm.prank(eric);
    handler.openTrove(96_944.474370263645082632 ether);
    vm.prank(eric);
    handler.liquidateMe();
    vm.prank(adam);
    handler.liquidateMe();
    console2.log("-9");
    invariant_allFundsClaimable();
    vm.prank(fran);
    handler.openTrove(98_000.000000000000023411 ether);
    console2.log("-8");
    invariant_allFundsClaimable();
    vm.prank(dana);
    handler.openTrove(98_000.000000000285840803 ether);
    console2.log("-7");
    invariant_allFundsClaimable();
    vm.prank(adam);
    handler.openTrove(98_000.393692075935773922 ether);
    console2.log("-6");
    invariant_allFundsClaimable();
    vm.prank(adam);
    handler.provideToSp(98_009.39726027397270077 ether, false);
    console2.log("-5");
    invariant_allFundsClaimable();
    vm.prank(fran);
    handler.provideToSp(98_009.39726027397270077 ether, false);
    console2.log("-4");
    invariant_allFundsClaimable();
    vm.prank(fran);
    handler.provideToSp(98_009.790990101203427417 ether, false);
    console2.log("-3");
    invariant_allFundsClaimable();
    vm.prank(eric);
    handler.provideToSp(89_618.132493028108872257 ether, false);
    console2.log("-2");
    invariant_allFundsClaimable();
    vm.prank(carl);
    handler.provideToSp(22_790.979340325274788885 ether, false);
    console2.log("-1");
    invariant_allFundsClaimable();
    vm.prank(hope);
    handler.liquidateMe();
    console2.log("0");
    invariant_allFundsClaimable();
    vm.prank(hope);
    handler.provideToSp(36_648.420465084212639386 ether, false);
}
```

## Related Implementations

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

### invariant_allFundsClaimable()

- **Kind**: internal
- **Source**: 2408:2128:228
- **Link**: `test/AnchoredSPInvariantsTest.t.sol:AnchoredSPInvariantsTest:invariant_allFundsClaimable()`

```solidity
function invariant_allFundsClaimable() internal view {
    uint256 stabilityPoolColl = stabilityPool.getCollBalance();
    uint256 stabilityPoolBold = stabilityPool.getTotalBoldDeposits();
    uint256 yieldGainsOwed = stabilityPool.getYieldGainsOwed();
    uint256 claimableColl = 0;
    uint256 claimableBold = 0;
    uint256 sumYieldGains = 0;
    for (uint256 i = 0; i < actors.length; ++i) {
        claimableColl += stabilityPool.getDepositorCollGain(actors[i].account);
        claimableBold += stabilityPool.getCompoundedBoldDeposit(actors[i].account);
        sumYieldGains += stabilityPool.getDepositorYieldGain(actors[i].account);
    }
    info("stabilityPoolColl:          ", stabilityPoolColl.decimal());
    info("claimableColl:              ", claimableColl.decimal());
    info("stabilityPoolBold:          ", stabilityPoolBold.decimal());
    info("claimableBold:              ", claimableBold.decimal());
    info("yieldGainsOwed:             ", yieldGainsOwed.decimal());
    info("sumYieldGains:              ", sumYieldGains.decimal());
    for (uint256 i = 0; i < actors.length; ++i) {
        info(actors[i].label, ":                       ", stabilityPool.getDepositorYieldGain(actors[i].account).decimal());
    }
    info("");
    assertApproxEqAbsDecimal(stabilityPoolColl, claimableColl, 0.00001 ether, 18, "SP Coll !~ claimable Coll");
    assertApproxEqAbsDecimal(stabilityPoolBold, claimableBold, 0.001 ether, 18, "SP BOLD !~ claimable BOLD");
    assertApproxEqAbsDecimal(yieldGainsOwed, sumYieldGains, 0.001 ether, 18, "SP yieldGainsOwed !~= sum(yieldGain)");
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

### info(string,string,string)

- **Kind**: internal
- **Source**: 2953:116:289
- **Link**: `test/Utils/Logging.sol:Logging:info(string,string,string)`

```solidity
function info(string memory a, string memory b, string memory c) internal pure {
    _log("// ", a, b, c);
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

### assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 17272:268:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)`

```solidity
function assertApproxEqAbsDecimal(uint256 left, uint256 right, uint256 maxDelta, uint256 decimals, string memory err) virtual internal pure {
    vm.assertApproxEqAbsDecimal(left, right, maxDelta, decimals, err);
}
```

## External Calls

- **Vm::prank(address)**
- **SPInvariantsTestHandler::openTrove(uint256)**
- **SPInvariantsTestHandler::provideToSp(uint256,bool)**
- **SPInvariantsTestHandler::liquidateMe()**

## State Variable Reads

- **gabe** (`address`)
- **handler** (`contract SPInvariantsTestHandler`) [test/TestContracts/SPInvariantsTestHandler.t.sol/contract_SPInvariantsTestHandler.md]
- **carl** (`address`)
- **eric** (`address`)
- **fran** (`address`)
- **hope** (`address`)
- **adam** (`address`)
- **dana** (`address`)
- **actors** (`struct AnchoredSPInvariantsTest.Actor[]`)
- **ONE** (`uint256`)
- **DECIMAL_UNIT** (`string`)
- **DECIMAL_SEPARATOR** (`string`)
- **GROUP_DIGITS** (`uint256`)
- **GROUP_SEPARATOR** (`bytes1`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AnchoredSPInvariantsTest.testUnderflow() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1)
  │   💬 Args: ["-9"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AnchoredSPInvariantsTest.invariant_allFundsClaimable() (NodeID: 4)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 5)
  │ │   💬 Args: ["stabilityPoolColl:          ", stabilityPoolColl.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 10)
  │ │ │   💬 Args: [stabilityPoolColl]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 11)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 12)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 13)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 14)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 15)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 16)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 17)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 18)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 19)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 20)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 21)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 22)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 23)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 24)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 25)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 26)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 27)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 28)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 29)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 30)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 31)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 32)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 6)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 7)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 8)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 9)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 33)
  │ │   💬 Args: ["claimableColl:              ", claimableColl.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 38)
  │ │ │   💬 Args: [claimableColl]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 39)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 40)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 41)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 42)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 43)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 44)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 45)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 46)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 47)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 48)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 49)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 50)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 51)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 52)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 53)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 54)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 55)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 56)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 57)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 58)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 59)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 60)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 34)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 35)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 36)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 37)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 61)
  │ │   💬 Args: ["stabilityPoolBold:          ", stabilityPoolBold.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 66)
  │ │ │   💬 Args: [stabilityPoolBold]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 67)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 68)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 69)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 70)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 71)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 72)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 73)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 74)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 75)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 76)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 77)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 78)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 79)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 80)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 81)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 82)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 83)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 84)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 85)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 86)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 87)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 88)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 62)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 63)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 64)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 65)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 89)
  │ │   💬 Args: ["claimableBold:              ", claimableBold.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 94)
  │ │ │   💬 Args: [claimableBold]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 95)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 96)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 97)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 98)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 99)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 100)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 101)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 102)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 103)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 104)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 105)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 106)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 107)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 108)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 109)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 110)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 111)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 112)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 113)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 114)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 115)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 116)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 90)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 91)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 92)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 93)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 117)
  │ │   💬 Args: ["yieldGainsOwed:             ", yieldGainsOwed.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 122)
  │ │ │   💬 Args: [yieldGainsOwed]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 123)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 124)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 125)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 126)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 127)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 128)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 129)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 130)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 131)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 132)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 133)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 134)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 135)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 136)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 137)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 138)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 139)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 140)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 141)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 142)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 143)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 144)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 118)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 119)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 120)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 121)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 145)
  │ │   💬 Args: ["sumYieldGains:              ", sumYieldGains.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 150)
  │ │ │   💬 Args: [sumYieldGains]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 151)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 152)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 153)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 154)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 155)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 156)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 157)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 158)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 159)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 160)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 161)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 162)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 163)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 164)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 165)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 166)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 167)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 168)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 169)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 170)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 171)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 172)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 146)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 147)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 148)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 149)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string,string) (NodeID: 173)
  │ │   💬 Args: [actors[i].label, ":                       ", stabilityPool.getDepositorYieldGain(actors[i].account).decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 178)
  │ │ │   💬 Args: [stabilityPool.getDepositorYieldGain(actors[i].account)]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 179)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 180)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 181)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 182)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 183)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 184)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 185)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 186)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 187)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 188)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 189)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 190)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 191)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 192)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 193)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 194)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 195)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 196)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 197)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 198)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 199)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 200)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string,string) (NodeID: 174)
  │ │     💬 Args: ["// ", a, b, c]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 175)
  │ │       💬 Args: [string.concat(a, b, c, d)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 176)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 177)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string) (NodeID: 201)
  │ │   💬 Args: [""]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 202)
  │ │     💬 Args: ["// ", a]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 203)
  │ │       💬 Args: [string.concat(a, b)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 204)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 205)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 206)
  │ │   💬 Args: [stabilityPoolColl, claimableColl, 0.00001 ether, 18, "SP Coll !~ claimable Coll"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 207)
  │ │   💬 Args: [stabilityPoolBold, claimableBold, 0.001 ether, 18, "SP BOLD !~ claimable BOLD"]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 208)
  │     💬 Args: [yieldGainsOwed, sumYieldGains, 0.001 ether, 18, "SP yieldGainsOwed !~= sum(yieldGain)"]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 209)
  │   💬 Args: ["-8"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 210)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 211)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AnchoredSPInvariantsTest.invariant_allFundsClaimable() (NodeID: 212)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 213)
  │ │   💬 Args: ["stabilityPoolColl:          ", stabilityPoolColl.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 218)
  │ │ │   💬 Args: [stabilityPoolColl]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 219)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 220)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 221)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 222)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 223)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 224)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 225)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 226)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 227)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 228)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 229)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 230)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 231)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 232)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 233)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 234)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 235)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 236)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 237)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 238)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 239)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 240)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 214)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 215)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 216)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 217)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 241)
  │ │   💬 Args: ["claimableColl:              ", claimableColl.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 246)
  │ │ │   💬 Args: [claimableColl]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 247)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 248)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 249)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 250)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 251)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 252)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 253)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 254)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 255)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 256)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 257)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 258)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 259)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 260)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 261)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 262)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 263)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 264)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 265)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 266)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 267)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 268)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 242)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 243)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 244)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 245)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 269)
  │ │   💬 Args: ["stabilityPoolBold:          ", stabilityPoolBold.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 274)
  │ │ │   💬 Args: [stabilityPoolBold]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 275)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 276)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 277)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 278)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 279)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 280)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 281)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 282)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 283)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 284)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 285)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 286)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 287)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 288)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 289)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 290)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 291)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 292)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 293)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 294)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 295)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 296)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 270)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 271)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 272)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 273)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 297)
  │ │   💬 Args: ["claimableBold:              ", claimableBold.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 302)
  │ │ │   💬 Args: [claimableBold]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 303)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 304)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 305)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 306)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 307)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 308)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 309)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 310)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 311)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 312)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 313)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 314)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 315)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 316)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 317)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 318)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 319)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 320)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 321)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 322)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 323)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 324)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 298)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 299)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 300)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 301)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 325)
  │ │   💬 Args: ["yieldGainsOwed:             ", yieldGainsOwed.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 330)
  │ │ │   💬 Args: [yieldGainsOwed]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 331)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 332)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 333)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 334)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 335)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 336)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 337)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 338)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 339)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 340)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 341)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 342)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 343)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 344)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 345)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 346)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 347)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 348)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 349)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 350)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 351)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 352)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 326)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 327)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 328)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 329)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 353)
  │ │   💬 Args: ["sumYieldGains:              ", sumYieldGains.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 358)
  │ │ │   💬 Args: [sumYieldGains]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 359)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 360)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 361)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 362)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 363)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 364)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 365)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 366)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 367)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 368)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 369)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 370)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 371)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 372)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 373)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 374)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 375)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 376)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 377)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 378)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 379)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 380)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 354)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 355)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 356)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 357)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string,string) (NodeID: 381)
  │ │   💬 Args: [actors[i].label, ":                       ", stabilityPool.getDepositorYieldGain(actors[i].account).decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 386)
  │ │ │   💬 Args: [stabilityPool.getDepositorYieldGain(actors[i].account)]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 387)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 388)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 389)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 390)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 391)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 392)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 393)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 394)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 395)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 396)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 397)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 398)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 399)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 400)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 401)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 402)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 403)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 404)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 405)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 406)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 407)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 408)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string,string) (NodeID: 382)
  │ │     💬 Args: ["// ", a, b, c]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 383)
  │ │       💬 Args: [string.concat(a, b, c, d)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 384)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 385)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string) (NodeID: 409)
  │ │   💬 Args: [""]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 410)
  │ │     💬 Args: ["// ", a]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 411)
  │ │       💬 Args: [string.concat(a, b)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 412)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 413)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 414)
  │ │   💬 Args: [stabilityPoolColl, claimableColl, 0.00001 ether, 18, "SP Coll !~ claimable Coll"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 415)
  │ │   💬 Args: [stabilityPoolBold, claimableBold, 0.001 ether, 18, "SP BOLD !~ claimable BOLD"]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 416)
  │     💬 Args: [yieldGainsOwed, sumYieldGains, 0.001 ether, 18, "SP yieldGainsOwed !~= sum(yieldGain)"]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 417)
  │   💬 Args: ["-7"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 418)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 419)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AnchoredSPInvariantsTest.invariant_allFundsClaimable() (NodeID: 420)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 421)
  │ │   💬 Args: ["stabilityPoolColl:          ", stabilityPoolColl.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 426)
  │ │ │   💬 Args: [stabilityPoolColl]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 427)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 428)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 429)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 430)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 431)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 432)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 433)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 434)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 435)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 436)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 437)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 438)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 439)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 440)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 441)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 442)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 443)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 444)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 445)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 446)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 447)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 448)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 422)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 423)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 424)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 425)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 449)
  │ │   💬 Args: ["claimableColl:              ", claimableColl.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 454)
  │ │ │   💬 Args: [claimableColl]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 455)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 456)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 457)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 458)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 459)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 460)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 461)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 462)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 463)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 464)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 465)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 466)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 467)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 468)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 469)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 470)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 471)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 472)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 473)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 474)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 475)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 476)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 450)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 451)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 452)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 453)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 477)
  │ │   💬 Args: ["stabilityPoolBold:          ", stabilityPoolBold.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 482)
  │ │ │   💬 Args: [stabilityPoolBold]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 483)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 484)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 485)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 486)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 487)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 488)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 489)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 490)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 491)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 492)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 493)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 494)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 495)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 496)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 497)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 498)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 499)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 500)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 501)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 502)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 503)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 504)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 478)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 479)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 480)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 481)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 505)
  │ │   💬 Args: ["claimableBold:              ", claimableBold.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 510)
  │ │ │   💬 Args: [claimableBold]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 511)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 512)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 513)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 514)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 515)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 516)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 517)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 518)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 519)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 520)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 521)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 522)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 523)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 524)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 525)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 526)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 527)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 528)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 529)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 530)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 531)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 532)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 506)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 507)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 508)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 509)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 533)
  │ │   💬 Args: ["yieldGainsOwed:             ", yieldGainsOwed.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 538)
  │ │ │   💬 Args: [yieldGainsOwed]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 539)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 540)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 541)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 542)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 543)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 544)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 545)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 546)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 547)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 548)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 549)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 550)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 551)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 552)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 553)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 554)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 555)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 556)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 557)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 558)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 559)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 560)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 534)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 535)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 536)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 537)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 561)
  │ │   💬 Args: ["sumYieldGains:              ", sumYieldGains.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 566)
  │ │ │   💬 Args: [sumYieldGains]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 567)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 568)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 569)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 570)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 571)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 572)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 573)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 574)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 575)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 576)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 577)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 578)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 579)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 580)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 581)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 582)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 583)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 584)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 585)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 586)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 587)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 588)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 562)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 563)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 564)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 565)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string,string) (NodeID: 589)
  │ │   💬 Args: [actors[i].label, ":                       ", stabilityPool.getDepositorYieldGain(actors[i].account).decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 594)
  │ │ │   💬 Args: [stabilityPool.getDepositorYieldGain(actors[i].account)]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 595)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 596)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 597)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 598)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 599)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 600)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 601)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 602)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 603)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 604)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 605)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 606)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 607)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 608)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 609)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 610)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 611)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 612)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 613)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 614)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 615)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 616)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string,string) (NodeID: 590)
  │ │     💬 Args: ["// ", a, b, c]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 591)
  │ │       💬 Args: [string.concat(a, b, c, d)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 592)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 593)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string) (NodeID: 617)
  │ │   💬 Args: [""]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 618)
  │ │     💬 Args: ["// ", a]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 619)
  │ │       💬 Args: [string.concat(a, b)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 620)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 621)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 622)
  │ │   💬 Args: [stabilityPoolColl, claimableColl, 0.00001 ether, 18, "SP Coll !~ claimable Coll"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 623)
  │ │   💬 Args: [stabilityPoolBold, claimableBold, 0.001 ether, 18, "SP BOLD !~ claimable BOLD"]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 624)
  │     💬 Args: [yieldGainsOwed, sumYieldGains, 0.001 ether, 18, "SP yieldGainsOwed !~= sum(yieldGain)"]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 625)
  │   💬 Args: ["-6"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 626)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 627)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AnchoredSPInvariantsTest.invariant_allFundsClaimable() (NodeID: 628)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 629)
  │ │   💬 Args: ["stabilityPoolColl:          ", stabilityPoolColl.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 634)
  │ │ │   💬 Args: [stabilityPoolColl]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 635)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 636)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 637)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 638)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 639)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 640)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 641)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 642)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 643)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 644)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 645)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 646)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 647)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 648)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 649)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 650)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 651)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 652)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 653)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 654)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 655)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 656)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 630)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 631)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 632)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 633)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 657)
  │ │   💬 Args: ["claimableColl:              ", claimableColl.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 662)
  │ │ │   💬 Args: [claimableColl]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 663)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 664)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 665)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 666)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 667)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 668)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 669)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 670)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 671)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 672)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 673)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 674)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 675)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 676)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 677)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 678)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 679)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 680)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 681)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 682)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 683)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 684)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 658)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 659)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 660)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 661)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 685)
  │ │   💬 Args: ["stabilityPoolBold:          ", stabilityPoolBold.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 690)
  │ │ │   💬 Args: [stabilityPoolBold]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 691)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 692)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 693)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 694)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 695)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 696)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 697)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 698)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 699)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 700)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 701)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 702)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 703)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 704)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 705)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 706)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 707)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 708)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 709)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 710)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 711)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 712)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 686)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 687)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 688)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 689)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 713)
  │ │   💬 Args: ["claimableBold:              ", claimableBold.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 718)
  │ │ │   💬 Args: [claimableBold]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 719)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 720)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 721)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 722)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 723)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 724)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 725)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 726)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 727)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 728)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 729)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 730)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 731)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 732)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 733)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 734)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 735)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 736)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 737)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 738)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 739)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 740)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 714)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 715)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 716)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 717)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 741)
  │ │   💬 Args: ["yieldGainsOwed:             ", yieldGainsOwed.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 746)
  │ │ │   💬 Args: [yieldGainsOwed]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 747)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 748)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 749)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 750)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 751)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 752)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 753)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 754)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 755)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 756)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 757)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 758)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 759)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 760)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 761)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 762)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 763)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 764)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 765)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 766)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 767)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 768)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 742)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 743)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 744)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 745)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 769)
  │ │   💬 Args: ["sumYieldGains:              ", sumYieldGains.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 774)
  │ │ │   💬 Args: [sumYieldGains]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 775)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 776)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 777)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 778)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 779)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 780)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 781)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 782)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 783)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 784)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 785)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 786)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 787)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 788)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 789)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 790)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 791)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 792)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 793)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 794)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 795)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 796)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 770)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 771)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 772)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 773)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string,string) (NodeID: 797)
  │ │   💬 Args: [actors[i].label, ":                       ", stabilityPool.getDepositorYieldGain(actors[i].account).decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 802)
  │ │ │   💬 Args: [stabilityPool.getDepositorYieldGain(actors[i].account)]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 803)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 804)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 805)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 806)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 807)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 808)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 809)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 810)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 811)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 812)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 813)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 814)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 815)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 816)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 817)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 818)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 819)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 820)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 821)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 822)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 823)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 824)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string,string) (NodeID: 798)
  │ │     💬 Args: ["// ", a, b, c]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 799)
  │ │       💬 Args: [string.concat(a, b, c, d)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 800)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 801)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string) (NodeID: 825)
  │ │   💬 Args: [""]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 826)
  │ │     💬 Args: ["// ", a]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 827)
  │ │       💬 Args: [string.concat(a, b)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 828)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 829)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 830)
  │ │   💬 Args: [stabilityPoolColl, claimableColl, 0.00001 ether, 18, "SP Coll !~ claimable Coll"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 831)
  │ │   💬 Args: [stabilityPoolBold, claimableBold, 0.001 ether, 18, "SP BOLD !~ claimable BOLD"]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 832)
  │     💬 Args: [yieldGainsOwed, sumYieldGains, 0.001 ether, 18, "SP yieldGainsOwed !~= sum(yieldGain)"]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 833)
  │   💬 Args: ["-5"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 834)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 835)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AnchoredSPInvariantsTest.invariant_allFundsClaimable() (NodeID: 836)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 837)
  │ │   💬 Args: ["stabilityPoolColl:          ", stabilityPoolColl.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 842)
  │ │ │   💬 Args: [stabilityPoolColl]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 843)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 844)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 845)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 846)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 847)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 848)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 849)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 850)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 851)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 852)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 853)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 854)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 855)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 856)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 857)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 858)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 859)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 860)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 861)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 862)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 863)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 864)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 838)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 839)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 840)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 841)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 865)
  │ │   💬 Args: ["claimableColl:              ", claimableColl.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 870)
  │ │ │   💬 Args: [claimableColl]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 871)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 872)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 873)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 874)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 875)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 876)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 877)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 878)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 879)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 880)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 881)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 882)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 883)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 884)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 885)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 886)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 887)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 888)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 889)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 890)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 891)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 892)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 866)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 867)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 868)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 869)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 893)
  │ │   💬 Args: ["stabilityPoolBold:          ", stabilityPoolBold.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 898)
  │ │ │   💬 Args: [stabilityPoolBold]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 899)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 900)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 901)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 902)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 903)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 904)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 905)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 906)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 907)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 908)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 909)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 910)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 911)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 912)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 913)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 914)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 915)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 916)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 917)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 918)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 919)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 920)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 894)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 895)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 896)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 897)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 921)
  │ │   💬 Args: ["claimableBold:              ", claimableBold.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 926)
  │ │ │   💬 Args: [claimableBold]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 927)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 928)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 929)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 930)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 931)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 932)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 933)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 934)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 935)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 936)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 937)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 938)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 939)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 940)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 941)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 942)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 943)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 944)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 945)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 946)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 947)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 948)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 922)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 923)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 924)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 925)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 949)
  │ │   💬 Args: ["yieldGainsOwed:             ", yieldGainsOwed.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 954)
  │ │ │   💬 Args: [yieldGainsOwed]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 955)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 956)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 957)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 958)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 959)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 960)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 961)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 962)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 963)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 964)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 965)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 966)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 967)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 968)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 969)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 970)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 971)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 972)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 973)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 974)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 975)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 976)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 950)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 951)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 952)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 953)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 977)
  │ │   💬 Args: ["sumYieldGains:              ", sumYieldGains.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 982)
  │ │ │   💬 Args: [sumYieldGains]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 983)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 984)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 985)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 986)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 987)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 988)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 989)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 990)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 991)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 992)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 993)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 994)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 995)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 996)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 997)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 998)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 999)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1000)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1001)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1002)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1003)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1004)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 978)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 979)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 980)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 981)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string,string) (NodeID: 1005)
  │ │   💬 Args: [actors[i].label, ":                       ", stabilityPool.getDepositorYieldGain(actors[i].account).decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1010)
  │ │ │   💬 Args: [stabilityPool.getDepositorYieldGain(actors[i].account)]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1011)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1012)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1013)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1014)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1015)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1016)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1017)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1018)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1019)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1020)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1021)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1022)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1023)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1024)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1025)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1026)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1027)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1028)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1029)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1030)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1031)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1032)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string,string) (NodeID: 1006)
  │ │     💬 Args: ["// ", a, b, c]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1007)
  │ │       💬 Args: [string.concat(a, b, c, d)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1008)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1009)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string) (NodeID: 1033)
  │ │   💬 Args: [""]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 1034)
  │ │     💬 Args: ["// ", a]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1035)
  │ │       💬 Args: [string.concat(a, b)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1036)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1037)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 1038)
  │ │   💬 Args: [stabilityPoolColl, claimableColl, 0.00001 ether, 18, "SP Coll !~ claimable Coll"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 1039)
  │ │   💬 Args: [stabilityPoolBold, claimableBold, 0.001 ether, 18, "SP BOLD !~ claimable BOLD"]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 1040)
  │     💬 Args: [yieldGainsOwed, sumYieldGains, 0.001 ether, 18, "SP yieldGainsOwed !~= sum(yieldGain)"]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1041)
  │   💬 Args: ["-4"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1042)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1043)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AnchoredSPInvariantsTest.invariant_allFundsClaimable() (NodeID: 1044)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1045)
  │ │   💬 Args: ["stabilityPoolColl:          ", stabilityPoolColl.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1050)
  │ │ │   💬 Args: [stabilityPoolColl]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1051)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1052)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1053)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1054)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1055)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1056)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1057)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1058)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1059)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1060)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1061)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1062)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1063)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1064)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1065)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1066)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1067)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1068)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1069)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1070)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1071)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1072)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1046)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1047)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1048)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1049)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1073)
  │ │   💬 Args: ["claimableColl:              ", claimableColl.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1078)
  │ │ │   💬 Args: [claimableColl]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1079)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1080)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1081)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1082)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1083)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1084)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1085)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1086)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1087)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1088)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1089)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1090)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1091)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1092)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1093)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1094)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1095)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1096)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1097)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1098)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1099)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1100)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1074)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1075)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1076)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1077)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1101)
  │ │   💬 Args: ["stabilityPoolBold:          ", stabilityPoolBold.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1106)
  │ │ │   💬 Args: [stabilityPoolBold]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1107)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1108)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1109)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1110)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1111)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1112)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1113)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1114)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1115)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1116)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1117)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1118)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1119)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1120)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1121)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1122)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1123)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1124)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1125)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1126)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1127)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1128)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1102)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1103)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1104)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1105)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1129)
  │ │   💬 Args: ["claimableBold:              ", claimableBold.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1134)
  │ │ │   💬 Args: [claimableBold]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1135)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1136)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1137)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1138)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1139)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1140)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1141)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1142)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1143)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1144)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1145)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1146)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1147)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1148)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1149)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1150)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1151)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1152)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1153)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1154)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1155)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1156)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1130)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1131)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1132)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1133)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1157)
  │ │   💬 Args: ["yieldGainsOwed:             ", yieldGainsOwed.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1162)
  │ │ │   💬 Args: [yieldGainsOwed]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1163)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1164)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1165)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1166)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1167)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1168)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1169)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1170)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1171)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1172)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1173)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1174)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1175)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1176)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1177)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1178)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1179)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1180)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1181)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1182)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1183)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1184)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1158)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1159)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1160)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1161)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1185)
  │ │   💬 Args: ["sumYieldGains:              ", sumYieldGains.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1190)
  │ │ │   💬 Args: [sumYieldGains]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1191)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1192)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1193)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1194)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1195)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1196)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1197)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1198)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1199)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1200)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1201)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1202)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1203)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1204)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1205)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1206)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1207)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1208)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1209)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1210)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1211)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1212)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1186)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1187)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1188)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1189)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string,string) (NodeID: 1213)
  │ │   💬 Args: [actors[i].label, ":                       ", stabilityPool.getDepositorYieldGain(actors[i].account).decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1218)
  │ │ │   💬 Args: [stabilityPool.getDepositorYieldGain(actors[i].account)]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1219)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1220)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1221)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1222)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1223)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1224)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1225)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1226)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1227)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1228)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1229)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1230)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1231)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1232)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1233)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1234)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1235)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1236)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1237)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1238)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1239)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1240)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string,string) (NodeID: 1214)
  │ │     💬 Args: ["// ", a, b, c]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1215)
  │ │       💬 Args: [string.concat(a, b, c, d)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1216)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1217)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string) (NodeID: 1241)
  │ │   💬 Args: [""]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 1242)
  │ │     💬 Args: ["// ", a]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1243)
  │ │       💬 Args: [string.concat(a, b)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1244)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1245)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 1246)
  │ │   💬 Args: [stabilityPoolColl, claimableColl, 0.00001 ether, 18, "SP Coll !~ claimable Coll"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 1247)
  │ │   💬 Args: [stabilityPoolBold, claimableBold, 0.001 ether, 18, "SP BOLD !~ claimable BOLD"]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 1248)
  │     💬 Args: [yieldGainsOwed, sumYieldGains, 0.001 ether, 18, "SP yieldGainsOwed !~= sum(yieldGain)"]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1249)
  │   💬 Args: ["-3"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1250)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1251)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AnchoredSPInvariantsTest.invariant_allFundsClaimable() (NodeID: 1252)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1253)
  │ │   💬 Args: ["stabilityPoolColl:          ", stabilityPoolColl.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1258)
  │ │ │   💬 Args: [stabilityPoolColl]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1259)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1260)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1261)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1262)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1263)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1264)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1265)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1266)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1267)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1268)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1269)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1270)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1271)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1272)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1273)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1274)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1275)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1276)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1277)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1278)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1279)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1280)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1254)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1255)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1256)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1257)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1281)
  │ │   💬 Args: ["claimableColl:              ", claimableColl.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1286)
  │ │ │   💬 Args: [claimableColl]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1287)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1288)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1289)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1290)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1291)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1292)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1293)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1294)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1295)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1296)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1297)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1298)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1299)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1300)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1301)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1302)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1303)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1304)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1305)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1306)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1307)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1308)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1282)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1283)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1284)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1285)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1309)
  │ │   💬 Args: ["stabilityPoolBold:          ", stabilityPoolBold.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1314)
  │ │ │   💬 Args: [stabilityPoolBold]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1315)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1316)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1317)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1318)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1319)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1320)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1321)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1322)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1323)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1324)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1325)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1326)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1327)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1328)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1329)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1330)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1331)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1332)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1333)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1334)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1335)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1336)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1310)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1311)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1312)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1313)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1337)
  │ │   💬 Args: ["claimableBold:              ", claimableBold.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1342)
  │ │ │   💬 Args: [claimableBold]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1343)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1344)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1345)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1346)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1347)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1348)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1349)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1350)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1351)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1352)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1353)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1354)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1355)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1356)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1357)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1358)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1359)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1360)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1361)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1362)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1363)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1364)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1338)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1339)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1340)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1341)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1365)
  │ │   💬 Args: ["yieldGainsOwed:             ", yieldGainsOwed.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1370)
  │ │ │   💬 Args: [yieldGainsOwed]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1371)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1372)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1373)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1374)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1375)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1376)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1377)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1378)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1379)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1380)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1381)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1382)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1383)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1384)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1385)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1386)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1387)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1388)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1389)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1390)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1391)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1392)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1366)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1367)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1368)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1369)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1393)
  │ │   💬 Args: ["sumYieldGains:              ", sumYieldGains.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1398)
  │ │ │   💬 Args: [sumYieldGains]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1399)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1400)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1401)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1402)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1403)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1404)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1405)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1406)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1407)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1408)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1409)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1410)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1411)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1412)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1413)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1414)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1415)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1416)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1417)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1418)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1419)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1420)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1394)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1395)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1396)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1397)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string,string) (NodeID: 1421)
  │ │   💬 Args: [actors[i].label, ":                       ", stabilityPool.getDepositorYieldGain(actors[i].account).decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1426)
  │ │ │   💬 Args: [stabilityPool.getDepositorYieldGain(actors[i].account)]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1427)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1428)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1429)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1430)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1431)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1432)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1433)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1434)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1435)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1436)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1437)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1438)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1439)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1440)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1441)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1442)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1443)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1444)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1445)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1446)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1447)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1448)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string,string) (NodeID: 1422)
  │ │     💬 Args: ["// ", a, b, c]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1423)
  │ │       💬 Args: [string.concat(a, b, c, d)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1424)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1425)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string) (NodeID: 1449)
  │ │   💬 Args: [""]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 1450)
  │ │     💬 Args: ["// ", a]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1451)
  │ │       💬 Args: [string.concat(a, b)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1452)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1453)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 1454)
  │ │   💬 Args: [stabilityPoolColl, claimableColl, 0.00001 ether, 18, "SP Coll !~ claimable Coll"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 1455)
  │ │   💬 Args: [stabilityPoolBold, claimableBold, 0.001 ether, 18, "SP BOLD !~ claimable BOLD"]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 1456)
  │     💬 Args: [yieldGainsOwed, sumYieldGains, 0.001 ether, 18, "SP yieldGainsOwed !~= sum(yieldGain)"]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1457)
  │   💬 Args: ["-2"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1458)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1459)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AnchoredSPInvariantsTest.invariant_allFundsClaimable() (NodeID: 1460)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1461)
  │ │   💬 Args: ["stabilityPoolColl:          ", stabilityPoolColl.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1466)
  │ │ │   💬 Args: [stabilityPoolColl]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1467)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1468)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1469)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1470)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1471)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1472)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1473)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1474)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1475)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1476)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1477)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1478)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1479)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1480)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1481)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1482)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1483)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1484)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1485)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1486)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1487)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1488)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1462)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1463)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1464)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1465)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1489)
  │ │   💬 Args: ["claimableColl:              ", claimableColl.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1494)
  │ │ │   💬 Args: [claimableColl]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1495)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1496)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1497)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1498)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1499)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1500)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1501)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1502)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1503)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1504)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1505)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1506)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1507)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1508)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1509)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1510)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1511)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1512)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1513)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1514)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1515)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1516)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1490)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1491)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1492)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1493)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1517)
  │ │   💬 Args: ["stabilityPoolBold:          ", stabilityPoolBold.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1522)
  │ │ │   💬 Args: [stabilityPoolBold]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1523)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1524)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1525)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1526)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1527)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1528)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1529)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1530)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1531)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1532)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1533)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1534)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1535)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1536)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1537)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1538)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1539)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1540)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1541)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1542)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1543)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1544)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1518)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1519)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1520)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1521)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1545)
  │ │   💬 Args: ["claimableBold:              ", claimableBold.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1550)
  │ │ │   💬 Args: [claimableBold]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1551)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1552)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1553)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1554)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1555)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1556)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1557)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1558)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1559)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1560)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1561)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1562)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1563)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1564)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1565)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1566)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1567)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1568)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1569)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1570)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1571)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1572)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1546)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1547)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1548)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1549)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1573)
  │ │   💬 Args: ["yieldGainsOwed:             ", yieldGainsOwed.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1578)
  │ │ │   💬 Args: [yieldGainsOwed]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1579)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1580)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1581)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1582)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1583)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1584)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1585)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1586)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1587)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1588)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1589)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1590)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1591)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1592)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1593)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1594)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1595)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1596)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1597)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1598)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1599)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1600)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1574)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1575)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1576)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1577)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1601)
  │ │   💬 Args: ["sumYieldGains:              ", sumYieldGains.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1606)
  │ │ │   💬 Args: [sumYieldGains]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1607)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1608)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1609)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1610)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1611)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1612)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1613)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1614)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1615)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1616)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1617)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1618)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1619)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1620)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1621)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1622)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1623)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1624)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1625)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1626)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1627)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1628)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1602)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1603)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1604)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1605)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string,string) (NodeID: 1629)
  │ │   💬 Args: [actors[i].label, ":                       ", stabilityPool.getDepositorYieldGain(actors[i].account).decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1634)
  │ │ │   💬 Args: [stabilityPool.getDepositorYieldGain(actors[i].account)]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1635)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1636)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1637)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1638)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1639)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1640)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1641)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1642)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1643)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1644)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1645)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1646)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1647)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1648)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1649)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1650)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1651)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1652)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1653)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1654)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1655)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1656)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string,string) (NodeID: 1630)
  │ │     💬 Args: ["// ", a, b, c]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1631)
  │ │       💬 Args: [string.concat(a, b, c, d)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1632)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1633)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string) (NodeID: 1657)
  │ │   💬 Args: [""]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 1658)
  │ │     💬 Args: ["// ", a]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1659)
  │ │       💬 Args: [string.concat(a, b)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1660)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1661)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 1662)
  │ │   💬 Args: [stabilityPoolColl, claimableColl, 0.00001 ether, 18, "SP Coll !~ claimable Coll"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 1663)
  │ │   💬 Args: [stabilityPoolBold, claimableBold, 0.001 ether, 18, "SP BOLD !~ claimable BOLD"]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 1664)
  │     💬 Args: [yieldGainsOwed, sumYieldGains, 0.001 ether, 18, "SP yieldGainsOwed !~= sum(yieldGain)"]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1665)
  │   💬 Args: ["-1"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1666)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1667)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AnchoredSPInvariantsTest.invariant_allFundsClaimable() (NodeID: 1668)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1669)
  │ │   💬 Args: ["stabilityPoolColl:          ", stabilityPoolColl.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1674)
  │ │ │   💬 Args: [stabilityPoolColl]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1675)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1676)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1677)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1678)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1679)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1680)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1681)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1682)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1683)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1684)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1685)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1686)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1687)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1688)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1689)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1690)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1691)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1692)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1693)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1694)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1695)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1696)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1670)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1671)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1672)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1673)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1697)
  │ │   💬 Args: ["claimableColl:              ", claimableColl.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1702)
  │ │ │   💬 Args: [claimableColl]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1703)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1704)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1705)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1706)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1707)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1708)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1709)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1710)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1711)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1712)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1713)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1714)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1715)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1716)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1717)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1718)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1719)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1720)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1721)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1722)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1723)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1724)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1698)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1699)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1700)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1701)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1725)
  │ │   💬 Args: ["stabilityPoolBold:          ", stabilityPoolBold.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1730)
  │ │ │   💬 Args: [stabilityPoolBold]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1731)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1732)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1733)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1734)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1735)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1736)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1737)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1738)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1739)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1740)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1741)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1742)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1743)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1744)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1745)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1746)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1747)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1748)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1749)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1750)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1751)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1752)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1726)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1727)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1728)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1729)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1753)
  │ │   💬 Args: ["claimableBold:              ", claimableBold.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1758)
  │ │ │   💬 Args: [claimableBold]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1759)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1760)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1761)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1762)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1763)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1764)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1765)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1766)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1767)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1768)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1769)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1770)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1771)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1772)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1773)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1774)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1775)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1776)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1777)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1778)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1779)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1780)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1754)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1755)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1756)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1757)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1781)
  │ │   💬 Args: ["yieldGainsOwed:             ", yieldGainsOwed.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1786)
  │ │ │   💬 Args: [yieldGainsOwed]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1787)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1788)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1789)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1790)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1791)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1792)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1793)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1794)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1795)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1796)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1797)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1798)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1799)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1800)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1801)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1802)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1803)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1804)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1805)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1806)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1807)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1808)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1782)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1783)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1784)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1785)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1809)
  │ │   💬 Args: ["sumYieldGains:              ", sumYieldGains.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1814)
  │ │ │   💬 Args: [sumYieldGains]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1815)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1816)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1817)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1818)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1819)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1820)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1821)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1822)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1823)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1824)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1825)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1826)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1827)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1828)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1829)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1830)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1831)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1832)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1833)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1834)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1835)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1836)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1810)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1811)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1812)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1813)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string,string) (NodeID: 1837)
  │ │   💬 Args: [actors[i].label, ":                       ", stabilityPool.getDepositorYieldGain(actors[i].account).decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1842)
  │ │ │   💬 Args: [stabilityPool.getDepositorYieldGain(actors[i].account)]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1843)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1844)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1845)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1846)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1847)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1848)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1849)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1850)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1851)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1852)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1853)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1854)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1855)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1856)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1857)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1858)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1859)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1860)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1861)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1862)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1863)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1864)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string,string) (NodeID: 1838)
  │ │     💬 Args: ["// ", a, b, c]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1839)
  │ │       💬 Args: [string.concat(a, b, c, d)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1840)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1841)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string) (NodeID: 1865)
  │ │   💬 Args: [""]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 1866)
  │ │     💬 Args: ["// ", a]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1867)
  │ │       💬 Args: [string.concat(a, b)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1868)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1869)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 1870)
  │ │   💬 Args: [stabilityPoolColl, claimableColl, 0.00001 ether, 18, "SP Coll !~ claimable Coll"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 1871)
  │ │   💬 Args: [stabilityPoolBold, claimableBold, 0.001 ether, 18, "SP BOLD !~ claimable BOLD"]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 1872)
  │     💬 Args: [yieldGainsOwed, sumYieldGains, 0.001 ether, 18, "SP yieldGainsOwed !~= sum(yieldGain)"]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1873)
  │   💬 Args: ["0"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1874)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1875)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: AnchoredSPInvariantsTest.invariant_allFundsClaimable() (NodeID: 1876)
      💬 Args: [no args]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1877)
    │   💬 Args: ["stabilityPoolColl:          ", stabilityPoolColl.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1882)
    │ │   💬 Args: [stabilityPoolColl]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1883)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1884)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1885)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1886)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1887)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1888)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1889)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1890)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1891)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1892)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1893)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1894)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1895)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1896)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1897)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1898)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1899)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1900)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1901)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1902)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1903)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1904)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1878)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1879)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1880)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1881)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1905)
    │   💬 Args: ["claimableColl:              ", claimableColl.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1910)
    │ │   💬 Args: [claimableColl]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1911)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1912)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1913)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1914)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1915)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1916)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1917)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1918)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1919)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1920)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1921)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1922)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1923)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1924)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1925)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1926)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1927)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1928)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1929)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1930)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1931)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1932)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1906)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1907)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1908)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1909)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1933)
    │   💬 Args: ["stabilityPoolBold:          ", stabilityPoolBold.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1938)
    │ │   💬 Args: [stabilityPoolBold]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1939)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1940)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1941)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1942)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1943)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1944)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1945)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1946)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1947)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1948)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1949)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1950)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1951)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1952)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1953)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1954)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1955)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1956)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1957)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1958)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1959)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1960)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1934)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1935)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1936)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1937)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1961)
    │   💬 Args: ["claimableBold:              ", claimableBold.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1966)
    │ │   💬 Args: [claimableBold]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1967)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1968)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1969)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1970)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1971)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1972)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1973)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1974)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1975)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1976)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1977)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1978)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1979)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1980)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 1981)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 1982)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1983)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1984)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 1985)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 1986)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 1987)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 1988)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1962)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1963)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1964)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1965)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 1989)
    │   💬 Args: ["yieldGainsOwed:             ", yieldGainsOwed.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 1994)
    │ │   💬 Args: [yieldGainsOwed]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 1995)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1996)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 1997)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 1998)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 1999)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 2000)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 2001)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 2002)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 2003)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 2004)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 2005)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 2006)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 2007)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 2008)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 2009)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 2010)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 2011)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 2012)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 2013)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 2014)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 2015)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 2016)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 1990)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 1991)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1992)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1993)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 2017)
    │   💬 Args: ["sumYieldGains:              ", sumYieldGains.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 2022)
    │ │   💬 Args: [sumYieldGains]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 2023)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 2024)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 2025)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 2026)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 2027)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 2028)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 2029)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 2030)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 2031)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 2032)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 2033)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 2034)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 2035)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 2036)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 2037)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 2038)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 2039)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 2040)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 2041)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 2042)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 2043)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 2044)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 2018)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 2019)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2020)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 2021)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string,string) (NodeID: 2045)
    │   💬 Args: [actors[i].label, ":                       ", stabilityPool.getDepositorYieldGain(actors[i].account).decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 2050)
    │ │   💬 Args: [stabilityPool.getDepositorYieldGain(actors[i].account)]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 2051)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 2052)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 2053)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 2054)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 2055)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 2056)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 2057)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 2058)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 2059)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 2060)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 2061)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 2062)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 2063)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 2064)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 2065)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 2066)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 2067)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 2068)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 2069)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 2070)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 2071)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 2072)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string,string) (NodeID: 2046)
    │     💬 Args: ["// ", a, b, c]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 2047)
    │       💬 Args: [string.concat(a, b, c, d)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2048)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 2049)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string) (NodeID: 2073)
    │   💬 Args: [""]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 2074)
    │     💬 Args: ["// ", a]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 2075)
    │       💬 Args: [string.concat(a, b)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2076)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 2077)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 2078)
    │   💬 Args: [stabilityPoolColl, claimableColl, 0.00001 ether, 18, "SP Coll !~ claimable Coll"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 2079)
    │   💬 Args: [stabilityPoolBold, claimableBold, 0.001 ether, 18, "SP BOLD !~ claimable BOLD"]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 2080)
        💬 Args: [yieldGainsOwed, sumYieldGains, 0.001 ether, 18, "SP yieldGainsOwed !~= sum(yieldGain)"]
        👁️  Def: internal
```
