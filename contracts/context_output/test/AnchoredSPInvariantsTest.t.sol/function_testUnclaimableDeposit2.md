# Function: testUnclaimableDeposit2()

**Contract**: [test/AnchoredSPInvariantsTest.t.sol/contract_AnchoredSPInvariantsTest.md]

## Metadata

- **Contract**: AnchoredSPInvariantsTest
- **Signature**: `testUnclaimableDeposit2()`
- **Visibility**: external
- **Source Range**: 6851:6978:228

## Implementation

```solidity
function testUnclaimableDeposit2() external {
    vm.prank(dana);
    handler.openTrove(98_009.397260273972607992 ether);
    vm.prank(adam);
    handler.provideToSp(9.398161381122161756 ether, false);
    vm.prank(eric);
    handler.openTrove(98_000.000000000000024518 ether);
    vm.prank(gabe);
    handler.provideToSp(98_009.39726027397262726 ether, false);
    vm.prank(hope);
    handler.provideToSp(89_926.427447073294525543 ether, false);
    vm.prank(gabe);
    handler.openTrove(92_744.365295196112729445 ether);
    vm.prank(dana);
    handler.provideToSp(12_389.101939905632219407 ether, false);
    vm.prank(dana);
    handler.provideToSp(9_589.959513437908897281 ether, false);
    vm.prank(hope);
    handler.openTrove(47_825.759168924832445192 ether);
    vm.prank(barb);
    handler.openTrove(51_678.663388906358459579 ether);
    vm.prank(barb);
    handler.liquidateMe();
    vm.prank(barb);
    handler.provideToSp(0.000000000000008548 ether, false);
    vm.prank(carl);
    handler.provideToSp(4_591.158415534017479187 ether, false);
    vm.prank(dana);
    handler.provideToSp(86_019.232581553804992428 ether, false);
    vm.prank(gabe);
    handler.provideToSp(83_736.829497136058174833 ether, false);
    vm.prank(carl);
    handler.openTrove(98_001.569986822121425601 ether);
    vm.prank(gabe);
    handler.liquidateMe();
    vm.prank(barb);
    handler.provideToSp(47_830.345200625962271476 ether, false);
    vm.prank(fran);
    handler.openTrove(98_000.000000000000018381 ether);
    vm.prank(barb);
    handler.openTrove(98_000.000000000000024015 ether);
    vm.prank(barb);
    handler.liquidateMe();
    vm.prank(gabe);
    handler.openTrove(64_306.996647761662542251 ether);
    vm.prank(eric);
    handler.liquidateMe();
    vm.prank(hope);
    handler.liquidateMe();
    vm.prank(adam);
    handler.provideToSp(156_013.932831544173758454 ether, false);
    vm.prank(barb);
    handler.provideToSp(149_177.525713798558063626 ether, false);
    vm.prank(barb);
    handler.openTrove(28_313.989453822345394132 ether);
    vm.prank(fran);
    handler.liquidateMe();
    vm.prank(dana);
    handler.provideToSp(22_796.354529886855570135 ether, false);
    vm.prank(fran);
    handler.provideToSp(3_365.431868318464668052 ether, false);
    vm.prank(eric);
    handler.provideToSp(6_369.148148716152063935 ether, false);
    vm.prank(hope);
    handler.openTrove(7_483.333928457434122145 ether);
    vm.prank(fran);
    handler.openTrove(54_541.180333895186007903 ether);
    vm.prank(adam);
    handler.openTrove(73_256.577394511977944484 ether);
    vm.prank(fran);
    handler.provideToSp(98_010.967397642775601628 ether, false);
    vm.prank(dana);
    handler.provideToSp(13_294.811494145641399612 ether, false);
    vm.prank(adam);
    handler.liquidateMe();
    vm.prank(gabe);
    handler.liquidateMe();
    vm.prank(gabe);
    handler.provideToSp(2_881.242711585620903523 ether, false);
    vm.prank(barb);
    handler.liquidateMe();
    invariant_allFundsClaimable();
}
```

## Related Implementations

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

- **dana** (`address`)
- **handler** (`contract SPInvariantsTestHandler`) [test/TestContracts/SPInvariantsTestHandler.t.sol/contract_SPInvariantsTestHandler.md]
- **adam** (`address`)
- **eric** (`address`)
- **gabe** (`address`)
- **hope** (`address`)
- **barb** (`address`)
- **carl** (`address`)
- **fran** (`address`)
- **actors** (`struct AnchoredSPInvariantsTest.Actor[]`)
- **ONE** (`uint256`)
- **DECIMAL_UNIT** (`string`)
- **DECIMAL_SEPARATOR** (`string`)
- **GROUP_DIGITS** (`uint256`)
- **GROUP_SEPARATOR** (`bytes1`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AnchoredSPInvariantsTest.testUnclaimableDeposit2() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: AnchoredSPInvariantsTest.invariant_allFundsClaimable() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 2)
    │   💬 Args: ["stabilityPoolColl:          ", stabilityPoolColl.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 7)
    │ │   💬 Args: [stabilityPoolColl]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 8)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 9)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 10)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 11)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 12)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 13)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 14)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 15)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 16)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 17)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 18)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 19)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 20)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 21)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 22)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 23)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 24)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 25)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 26)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 27)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 28)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 29)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 3)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 4)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 5)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 6)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 30)
    │   💬 Args: ["claimableColl:              ", claimableColl.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 35)
    │ │   💬 Args: [claimableColl]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 36)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 37)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 38)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 39)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 40)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 41)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 42)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 43)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 44)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 45)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 46)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 47)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 48)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 49)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 50)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 51)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 52)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 53)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 54)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 55)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 56)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 57)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
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
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 58)
    │   💬 Args: ["stabilityPoolBold:          ", stabilityPoolBold.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 63)
    │ │   💬 Args: [stabilityPoolBold]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 64)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 65)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 66)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 67)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 68)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 69)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 70)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 71)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 72)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 73)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 74)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 75)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 76)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 77)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 78)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 79)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 80)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 81)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 82)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 83)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 84)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 85)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 59)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 60)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 61)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 62)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 86)
    │   💬 Args: ["claimableBold:              ", claimableBold.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 91)
    │ │   💬 Args: [claimableBold]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 92)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 93)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 94)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 95)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 96)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 97)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 98)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 99)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 100)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 101)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 102)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 103)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 104)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 105)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 106)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 107)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 108)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 109)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 110)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 111)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 112)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 113)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 87)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 88)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 89)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 90)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 114)
    │   💬 Args: ["yieldGainsOwed:             ", yieldGainsOwed.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 119)
    │ │   💬 Args: [yieldGainsOwed]
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
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 115)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 116)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 117)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 118)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 142)
    │   💬 Args: ["sumYieldGains:              ", sumYieldGains.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 147)
    │ │   💬 Args: [sumYieldGains]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 148)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 149)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 150)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 151)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 152)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 153)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 154)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 155)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 156)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 157)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 158)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 159)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 160)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 161)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 162)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 163)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 164)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 165)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 166)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 167)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 168)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 169)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 143)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 144)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 145)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 146)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string,string) (NodeID: 170)
    │   💬 Args: [actors[i].label, ":                       ", stabilityPool.getDepositorYieldGain(actors[i].account).decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 175)
    │ │   💬 Args: [stabilityPool.getDepositorYieldGain(actors[i].account)]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 176)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 177)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 178)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 179)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 180)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 181)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 182)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 183)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 184)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 185)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 186)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 187)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 188)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 189)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 190)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 191)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 192)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 193)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 194)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 195)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 196)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 197)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string,string) (NodeID: 171)
    │     💬 Args: ["// ", a, b, c]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 172)
    │       💬 Args: [string.concat(a, b, c, d)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 173)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 174)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string) (NodeID: 198)
    │   💬 Args: [""]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 199)
    │     💬 Args: ["// ", a]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 200)
    │       💬 Args: [string.concat(a, b)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 201)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 202)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 203)
    │   💬 Args: [stabilityPoolColl, claimableColl, 0.00001 ether, 18, "SP Coll !~ claimable Coll"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 204)
    │   💬 Args: [stabilityPoolBold, claimableBold, 0.001 ether, 18, "SP BOLD !~ claimable BOLD"]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 205)
        💬 Args: [yieldGainsOwed, sumYieldGains, 0.001 ether, 18, "SP yieldGainsOwed !~= sum(yieldGain)"]
        👁️  Def: internal
```
