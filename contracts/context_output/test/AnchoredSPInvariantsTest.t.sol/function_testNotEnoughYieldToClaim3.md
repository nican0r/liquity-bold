# Function: testNotEnoughYieldToClaim3()

**Contract**: [test/AnchoredSPInvariantsTest.t.sol/contract_AnchoredSPInvariantsTest.md]

## Metadata

- **Contract**: AnchoredSPInvariantsTest
- **Signature**: `testNotEnoughYieldToClaim3()`
- **Visibility**: external
- **Source Range**: 26959:6049:228

## Implementation

```solidity
function testNotEnoughYieldToClaim3() external {
    vm.prank(adam);
    handler.openTrove(66_774.640522357011826983 ether);
    vm.prank(fran);
    handler.openTrove(60_793.906098928902280224 ether);
    vm.prank(barb);
    handler.openTrove(2_000 ether);
    vm.prank(fran);
    handler.provideToSp(0.127035053107027317 ether, false);
    vm.prank(hope);
    handler.openTrove(52_001.424183265718616619 ether);
    vm.prank(dana);
    handler.openTrove(98_214.828404368926759399 ether);
    vm.prank(carl);
    handler.provideToSp(52_006.410621201100260869 ether, false);
    vm.prank(gabe);
    handler.openTrove(98_000.000000000000001558 ether);
    vm.prank(eric);
    handler.provideToSp(98_018.79542165509478359 ether, false);
    vm.prank(gabe);
    handler.liquidateMe();
    vm.prank(hope);
    handler.liquidateMe();
    vm.prank(hope);
    handler.openTrove(39_714.263922160737128486 ether);
    vm.prank(carl);
    handler.provideToSp(45_503.134640909581521244 ether, false);
    vm.prank(dana);
    handler.provideToSp(13_158.641347715694197298 ether, false);
    vm.prank(fran);
    handler.provideToSp(88_720.671803804390427542 ether, false);
    vm.prank(barb);
    handler.provideToSp(98_224.246264626880042381 ether, false);
    vm.prank(fran);
    handler.provideToSp(2_000.191780821917808219 ether, false);
    vm.prank(dana);
    handler.liquidateMe();
    vm.prank(eric);
    handler.openTrove(2_140.638391190677003004 ether);
    vm.prank(fran);
    handler.liquidateMe();
    vm.prank(hope);
    handler.provideToSp(16_730.704105575056759258 ether, false);
    vm.prank(dana);
    handler.provideToSp(2_755.636251036681598567 ether, false);
    vm.prank(carl);
    handler.provideToSp(528.278543964116931444 ether, false);
    vm.prank(eric);
    handler.provideToSp(1_508.113441559160422894 ether, false);
    vm.prank(barb);
    handler.provideToSp(0.000000000000017716 ether, false);
    vm.prank(carl);
    handler.openTrove(52_203.28895912549177853 ether);
    vm.prank(fran);
    handler.openTrove(92_581.05355932642011576 ether);
    vm.prank(fran);
    handler.liquidateMe();
    info("");
    info("P ratio:        ", ((3615289994393 * DECIMAL_PRECISION) / 22715721016141).decimal());
    info("deposits ratio: ", ((17_525.230265653071151161 ether * DECIMAL_PRECISION) / 110_115.161460252303389397 ether).decimal());
    info("");
    vm.prank(eric);
    handler.liquidateMe();
    info("");
    info("P ratio:        ", ((3173654104960 * DECIMAL_PRECISION) / 22715721016141).decimal());
    info("deposits ratio: ", ((15_384.386607767348466801 ether * DECIMAL_PRECISION) / 110_115.161460252303389397 ether).decimal());
    info("");
    vm.prank(fran);
    handler.openTrove(62_950.605425987832560415 ether);
    vm.prank(dana);
    handler.openTrove(98_000.000000000000000445 ether);
    invariant_allFundsClaimable();
}
```

## Related Implementations

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

- **adam** (`address`)
- **handler** (`contract SPInvariantsTestHandler`) [test/TestContracts/SPInvariantsTestHandler.t.sol/contract_SPInvariantsTestHandler.md]
- **fran** (`address`)
- **barb** (`address`)
- **hope** (`address`)
- **dana** (`address`)
- **carl** (`address`)
- **gabe** (`address`)
- **eric** (`address`)
- **ONE** (`uint256`)
- **DECIMAL_UNIT** (`string`)
- **DECIMAL_SEPARATOR** (`string`)
- **GROUP_DIGITS** (`uint256`)
- **GROUP_SEPARATOR** (`bytes1`)
- **actors** (`struct AnchoredSPInvariantsTest.Actor[]`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AnchoredSPInvariantsTest.testNotEnoughYieldToClaim3() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Logging.info(string) (NodeID: 1)
  │   💬 Args: [""]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 2)
  │     💬 Args: ["// ", a]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 3)
  │       💬 Args: [string.concat(a, b)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 4)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 5)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 6)
  │   💬 Args: ["P ratio:        ", ((3615289994393 * DECIMAL_PRECISION) / 22715721016141).decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 11)
  │ │   💬 Args: [((3615289994393 * DECIMAL_PRECISION) / 22715721016141)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 12)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 13)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 14)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 15)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 16)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 17)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 18)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 19)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 20)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 21)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 22)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 23)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 24)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 25)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 26)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 27)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 28)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 29)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 30)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 31)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 32)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 33)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 7)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 8)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 9)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 10)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 34)
  │   💬 Args: ["deposits ratio: ", ((17_525.230265653071151161 ether * DECIMAL_PRECISION) / 110_115.161460252303389397 ether).decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 39)
  │ │   💬 Args: [((17_525.230265653071151161 ether * DECIMAL_PRECISION) / 110_115.161460252303389397 ether)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 40)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 41)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 42)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 43)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 44)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 45)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 46)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 47)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 48)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 49)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 50)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 51)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 52)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 53)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 54)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 55)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 56)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 57)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 58)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 59)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 60)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 61)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 35)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 36)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 37)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 38)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string) (NodeID: 62)
  │   💬 Args: [""]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 63)
  │     💬 Args: ["// ", a]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 64)
  │       💬 Args: [string.concat(a, b)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 65)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 66)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string) (NodeID: 67)
  │   💬 Args: [""]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 68)
  │     💬 Args: ["// ", a]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 69)
  │       💬 Args: [string.concat(a, b)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 70)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 71)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 72)
  │   💬 Args: ["P ratio:        ", ((3173654104960 * DECIMAL_PRECISION) / 22715721016141).decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 77)
  │ │   💬 Args: [((3173654104960 * DECIMAL_PRECISION) / 22715721016141)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 78)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 79)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 80)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 81)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 82)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 83)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 84)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 85)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 86)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 87)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 88)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 89)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 90)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 91)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 92)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 93)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 94)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 95)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 96)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 97)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 98)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 99)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 73)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 74)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 75)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 76)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 100)
  │   💬 Args: ["deposits ratio: ", ((15_384.386607767348466801 ether * DECIMAL_PRECISION) / 110_115.161460252303389397 ether).decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 105)
  │ │   💬 Args: [((15_384.386607767348466801 ether * DECIMAL_PRECISION) / 110_115.161460252303389397 ether)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 106)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 107)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 108)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 109)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 110)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 111)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 112)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 113)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 114)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 115)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 116)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 117)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 118)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 119)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 120)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 121)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 122)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 123)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 124)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 125)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 126)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 127)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 101)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 102)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 103)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 104)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string) (NodeID: 128)
  │   💬 Args: [""]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 129)
  │     💬 Args: ["// ", a]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 130)
  │       💬 Args: [string.concat(a, b)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 131)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 132)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: AnchoredSPInvariantsTest.invariant_allFundsClaimable() (NodeID: 133)
      💬 Args: [no args]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 134)
    │   💬 Args: ["stabilityPoolColl:          ", stabilityPoolColl.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 139)
    │ │   💬 Args: [stabilityPoolColl]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 140)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 141)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 142)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 143)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 144)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 145)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 146)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 147)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 148)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 149)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 150)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 151)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 152)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 153)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 154)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 155)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 156)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 157)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 158)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 159)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 160)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 161)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 135)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 136)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 137)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 138)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 162)
    │   💬 Args: ["claimableColl:              ", claimableColl.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 167)
    │ │   💬 Args: [claimableColl]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 168)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 169)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 170)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 171)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 172)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 173)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 174)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 175)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 176)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 177)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 178)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 179)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 180)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 181)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 182)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 183)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 184)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 185)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 186)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 187)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 188)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 189)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 163)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 164)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 165)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 166)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 190)
    │   💬 Args: ["stabilityPoolBold:          ", stabilityPoolBold.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 195)
    │ │   💬 Args: [stabilityPoolBold]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 196)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 197)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 198)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 199)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 200)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 201)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 202)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 203)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 204)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 205)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 206)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 207)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 208)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 209)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 210)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 211)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 212)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 213)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 214)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 215)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 216)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 217)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 191)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 192)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 193)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 194)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 218)
    │   💬 Args: ["claimableBold:              ", claimableBold.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 223)
    │ │   💬 Args: [claimableBold]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 224)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 225)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 226)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 227)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 228)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 229)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 230)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 231)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 232)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 233)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 234)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 235)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 236)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 237)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 238)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 239)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 240)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 241)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 242)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 243)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 244)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 245)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 219)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 220)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 221)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 222)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 246)
    │   💬 Args: ["yieldGainsOwed:             ", yieldGainsOwed.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 251)
    │ │   💬 Args: [yieldGainsOwed]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 252)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 253)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 254)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 255)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 256)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 257)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 258)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 259)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 260)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 261)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 262)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 263)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 264)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 265)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 266)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 267)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 268)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 269)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 270)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 271)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 272)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 273)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 247)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 248)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 249)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 250)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 274)
    │   💬 Args: ["sumYieldGains:              ", sumYieldGains.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 279)
    │ │   💬 Args: [sumYieldGains]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 280)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 281)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 282)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 283)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 284)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 285)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 286)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 287)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 288)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 289)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 290)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 291)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 292)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 293)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 294)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 295)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 296)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 297)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 298)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 299)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 300)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 301)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 275)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 276)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 277)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 278)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string,string) (NodeID: 302)
    │   💬 Args: [actors[i].label, ":                       ", stabilityPool.getDepositorYieldGain(actors[i].account).decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 307)
    │ │   💬 Args: [stabilityPool.getDepositorYieldGain(actors[i].account)]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 308)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 309)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 310)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 311)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 312)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 313)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 314)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 315)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 316)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 317)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 318)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 319)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 320)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 321)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 322)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 323)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 324)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 325)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 326)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 327)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 328)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 329)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string,string) (NodeID: 303)
    │     💬 Args: ["// ", a, b, c]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 304)
    │       💬 Args: [string.concat(a, b, c, d)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 305)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 306)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string) (NodeID: 330)
    │   💬 Args: [""]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 331)
    │     💬 Args: ["// ", a]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 332)
    │       💬 Args: [string.concat(a, b)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 333)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 334)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 335)
    │   💬 Args: [stabilityPoolColl, claimableColl, 0.00001 ether, 18, "SP Coll !~ claimable Coll"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 336)
    │   💬 Args: [stabilityPoolBold, claimableBold, 0.001 ether, 18, "SP BOLD !~ claimable BOLD"]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 337)
        💬 Args: [yieldGainsOwed, sumYieldGains, 0.001 ether, 18, "SP yieldGainsOwed !~= sum(yieldGain)"]
        👁️  Def: internal
```
