# Function: testNotEnoughYieldToClaim2()

**Contract**: [test/AnchoredSPInvariantsTest.t.sol/contract_AnchoredSPInvariantsTest.md]

## Metadata

- **Contract**: AnchoredSPInvariantsTest
- **Signature**: `testNotEnoughYieldToClaim2()`
- **Visibility**: external
- **Source Range**: 19921:7032:228

## Implementation

```solidity
function testNotEnoughYieldToClaim2() external {
    vm.prank(barb);
    handler.openTrove(98_000.097604263729236202 ether);
    vm.prank(barb);
    handler.provideToSp(9.397269633285661087 ether, false);
    vm.prank(hope);
    handler.openTrove(39_482.322849092301542185 ether);
    vm.prank(eric);
    handler.openTrove(92_039.79943986671688901 ether);
    vm.prank(fran);
    handler.provideToSp(0.000000000000021173 ether, false);
    vm.prank(carl);
    handler.openTrove(98_000.000000000000003783 ether);
    vm.prank(adam);
    handler.openTrove(68_774.984636098027527957 ether);
    vm.prank(dana);
    handler.openTrove(98_000.006549474022262404 ether);
    vm.prank(eric);
    handler.provideToSp(98_009.397260273972704533 ether, false);
    vm.prank(barb);
    handler.liquidateMe();
    vm.prank(eric);
    handler.provideToSp(98_009.397260273972704533 ether, false);
    vm.prank(carl);
    handler.liquidateMe();
    vm.prank(fran);
    handler.openTrove(58_609.743997806198827208 ether);
    vm.prank(barb);
    handler.provideToSp(68_781.579497638475284021 ether, false);
    vm.prank(gabe);
    handler.provideToSp(39_486.108825255913132743 ether, false);
    vm.prank(fran);
    handler.provideToSp(98_009.403810376026620703 ether, false);
    vm.prank(fran);
    handler.provideToSp(67_852.887887440994776149 ether, false);
    vm.prank(adam);
    handler.provideToSp(78_134.913037086847714575 ether, false);
    vm.prank(hope);
    handler.liquidateMe();
    vm.prank(adam);
    handler.provideToSp(401.55682795488209173 ether, false);
    vm.prank(gabe);
    handler.openTrove(98_000.00000000000001687 ether);
    vm.prank(adam);
    handler.liquidateMe();
    vm.prank(carl);
    handler.openTrove(34_790.372379140532696158 ether);
    vm.prank(dana);
    handler.provideToSp(126_931.523034110680273609 ether, false);
    info("");
    info("             -------------- here it starts!  ----------------");
    info("");
    vm.prank(fran);
    handler.liquidateMe();
    info("");
    info("P ratio:        ", ((5252708102 * DECIMAL_PRECISION) / 6237247764).decimal());
    info("deposits ratio: ", ((312_724.220142735330535195 ether * DECIMAL_PRECISION) / 371339584252979675162290).decimal());
    info("");
    info("");
    info("             -------------- here it goes!  ----------------");
    info("");
    uint256 prevError = (99469643824625821462110 * DECIMAL_PRECISION) / 371339584252979675162290;
    uint256 pWithError = (5252708102 * DECIMAL_PRECISION) + prevError;
    uint256 newP = ((pWithError * 705655592866947642) / DECIMAL_PRECISION) / DECIMAL_PRECISION;
    info("prev error:     ", prevError.decimal());
    info("P w prev error: ", pWithError.decimal());
    info("P * F:          ", ((pWithError * 705655592866947642) / DECIMAL_PRECISION).decimal());
    info("final P:        ", newP.decimal());
    vm.prank(eric);
    handler.liquidateMe();
    info("");
    info("P ratio:        ", ((3706602850 * DECIMAL_PRECISION) / 6237247764).decimal());
    info("deposits ratio: ", ((220_675.594968675749714429 ether * DECIMAL_PRECISION) / 371339584252979675162290).decimal());
    info("P - 1 ratio:    ", ((3706602849 * DECIMAL_PRECISION) / 6237247764).decimal());
    info("");
    vm.prank(hope);
    handler.openTrove(98_000.000000000000004711 ether);
    vm.prank(carl);
    handler.liquidateMe();
    info("");
    info("P ratio:        ", ((3122186351 * DECIMAL_PRECISION) / 6237247764).decimal());
    info("deposits ratio: ", ((185881886526430367926095 * DECIMAL_PRECISION) / 371339584252979675162290).decimal());
    info("");
    invariant_allFundsClaimable();
    vm.prank(adam);
    handler.openTrove(38_118.782104138270981514 ether);
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

- **barb** (`address`)
- **handler** (`contract SPInvariantsTestHandler`) [test/TestContracts/SPInvariantsTestHandler.t.sol/contract_SPInvariantsTestHandler.md]
- **hope** (`address`)
- **eric** (`address`)
- **fran** (`address`)
- **carl** (`address`)
- **adam** (`address`)
- **dana** (`address`)
- **gabe** (`address`)
- **ONE** (`uint256`)
- **DECIMAL_UNIT** (`string`)
- **DECIMAL_SEPARATOR** (`string`)
- **GROUP_DIGITS** (`uint256`)
- **GROUP_SEPARATOR** (`bytes1`)
- **actors** (`struct AnchoredSPInvariantsTest.Actor[]`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AnchoredSPInvariantsTest.testNotEnoughYieldToClaim2() (NodeID: 0)
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
  ├─ [1] ⚙️ FUNCTION: Logging.info(string) (NodeID: 6)
  │   💬 Args: ["             -------------- here it starts!  ----------------"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 7)
  │     💬 Args: ["// ", a]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 8)
  │       💬 Args: [string.concat(a, b)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 9)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 10)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string) (NodeID: 11)
  │   💬 Args: [""]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 12)
  │     💬 Args: ["// ", a]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 13)
  │       💬 Args: [string.concat(a, b)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 14)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 15)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string) (NodeID: 16)
  │   💬 Args: [""]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 17)
  │     💬 Args: ["// ", a]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 18)
  │       💬 Args: [string.concat(a, b)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 19)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 20)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 21)
  │   💬 Args: ["P ratio:        ", ((5252708102 * DECIMAL_PRECISION) / 6237247764).decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 26)
  │ │   💬 Args: [((5252708102 * DECIMAL_PRECISION) / 6237247764)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 27)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 28)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 29)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 30)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 31)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 32)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 33)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 34)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 35)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 36)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 37)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 38)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 39)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 40)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 41)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 42)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 43)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 44)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 45)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 46)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 47)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 48)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 22)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 23)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 24)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 25)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 49)
  │   💬 Args: ["deposits ratio: ", ((312_724.220142735330535195 ether * DECIMAL_PRECISION) / 371339584252979675162290).decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 54)
  │ │   💬 Args: [((312_724.220142735330535195 ether * DECIMAL_PRECISION) / 371339584252979675162290)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 55)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 56)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 57)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 58)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 59)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 60)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 61)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 62)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 63)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 64)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 65)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 66)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 67)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 68)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 69)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 70)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 71)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 72)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 73)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 74)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 75)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 76)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 50)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 51)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 52)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 53)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string) (NodeID: 77)
  │   💬 Args: [""]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 78)
  │     💬 Args: ["// ", a]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 79)
  │       💬 Args: [string.concat(a, b)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 80)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 81)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string) (NodeID: 82)
  │   💬 Args: [""]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 83)
  │     💬 Args: ["// ", a]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 84)
  │       💬 Args: [string.concat(a, b)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 85)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 86)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string) (NodeID: 87)
  │   💬 Args: ["             -------------- here it goes!  ----------------"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 88)
  │     💬 Args: ["// ", a]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 89)
  │       💬 Args: [string.concat(a, b)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 90)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 91)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string) (NodeID: 92)
  │   💬 Args: [""]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 93)
  │     💬 Args: ["// ", a]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 94)
  │       💬 Args: [string.concat(a, b)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 95)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 96)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 97)
  │   💬 Args: ["prev error:     ", prevError.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 102)
  │ │   💬 Args: [prevError]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 103)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 104)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 105)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 106)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 107)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 108)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 109)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 110)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 111)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 112)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 113)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 114)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 115)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 116)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 117)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 118)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 119)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 120)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 121)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 122)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 123)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 124)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 98)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 99)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 100)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 101)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 125)
  │   💬 Args: ["P w prev error: ", pWithError.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 130)
  │ │   💬 Args: [pWithError]
  │ │   👁️  Def: internal
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
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 137)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 138)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 139)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 140)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 141)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 142)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 143)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 144)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 145)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 146)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 147)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 148)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 149)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 150)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 151)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 152)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 126)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 127)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 128)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 129)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 153)
  │   💬 Args: ["P * F:          ", ((pWithError * 705655592866947642) / DECIMAL_PRECISION).decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 158)
  │ │   💬 Args: [((pWithError * 705655592866947642) / DECIMAL_PRECISION)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 159)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 160)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 161)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 162)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 163)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 164)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 165)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 166)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 167)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 168)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 169)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 170)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 171)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 172)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 173)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 174)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 175)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 176)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 177)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 178)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 179)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 180)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 154)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 155)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 156)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 157)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 181)
  │   💬 Args: ["final P:        ", newP.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 186)
  │ │   💬 Args: [newP]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 187)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 188)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 189)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 190)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 191)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 192)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 193)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 194)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 195)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 196)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 197)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 198)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 199)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 200)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 201)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 202)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 203)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 204)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 205)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 206)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 207)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 208)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 182)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 183)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 184)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 185)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string) (NodeID: 209)
  │   💬 Args: [""]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 210)
  │     💬 Args: ["// ", a]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 211)
  │       💬 Args: [string.concat(a, b)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 212)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 213)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 214)
  │   💬 Args: ["P ratio:        ", ((3706602850 * DECIMAL_PRECISION) / 6237247764).decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 219)
  │ │   💬 Args: [((3706602850 * DECIMAL_PRECISION) / 6237247764)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 220)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 221)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 222)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 223)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 224)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 225)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 226)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 227)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 228)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 229)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 230)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 231)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 232)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 233)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 234)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 235)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 236)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 237)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 238)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 239)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 240)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 241)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 215)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 216)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 217)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 218)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 242)
  │   💬 Args: ["deposits ratio: ", ((220_675.594968675749714429 ether * DECIMAL_PRECISION) / 371339584252979675162290).decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 247)
  │ │   💬 Args: [((220_675.594968675749714429 ether * DECIMAL_PRECISION) / 371339584252979675162290)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 248)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 249)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 250)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 251)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 252)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 253)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 254)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 255)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 256)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 257)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 258)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 259)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 260)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 261)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 262)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 263)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 264)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 265)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 266)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 267)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 268)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 269)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 243)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 244)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 245)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 246)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 270)
  │   💬 Args: ["P - 1 ratio:    ", ((3706602849 * DECIMAL_PRECISION) / 6237247764).decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 275)
  │ │   💬 Args: [((3706602849 * DECIMAL_PRECISION) / 6237247764)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 276)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 277)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 278)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 279)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 280)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 281)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 282)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 283)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 284)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 285)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 286)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 287)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 288)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 289)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 290)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 291)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 292)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 293)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 294)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 295)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 296)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 297)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 271)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 272)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 273)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 274)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string) (NodeID: 298)
  │   💬 Args: [""]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 299)
  │     💬 Args: ["// ", a]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 300)
  │       💬 Args: [string.concat(a, b)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 301)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 302)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string) (NodeID: 303)
  │   💬 Args: [""]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 304)
  │     💬 Args: ["// ", a]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 305)
  │       💬 Args: [string.concat(a, b)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 306)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 307)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 308)
  │   💬 Args: ["P ratio:        ", ((3122186351 * DECIMAL_PRECISION) / 6237247764).decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 313)
  │ │   💬 Args: [((3122186351 * DECIMAL_PRECISION) / 6237247764)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 314)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 315)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 316)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 317)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 318)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 319)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 320)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 321)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 322)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 323)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 324)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 325)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 326)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 327)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 328)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 329)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 330)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 331)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 332)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 333)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 334)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 335)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 309)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 310)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 311)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 312)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 336)
  │   💬 Args: ["deposits ratio: ", ((185881886526430367926095 * DECIMAL_PRECISION) / 371339584252979675162290).decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 341)
  │ │   💬 Args: [((185881886526430367926095 * DECIMAL_PRECISION) / 371339584252979675162290)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 342)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 343)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 344)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 345)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 346)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 347)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 348)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 349)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 350)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 351)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 352)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 353)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 354)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 355)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 356)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 357)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 358)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 359)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 360)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 361)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 362)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 363)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 337)
  │     💬 Args: ["// ", a, b]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 338)
  │       💬 Args: [string.concat(a, b, c)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 339)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 340)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging.info(string) (NodeID: 364)
  │   💬 Args: [""]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 365)
  │     💬 Args: ["// ", a]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 366)
  │       💬 Args: [string.concat(a, b)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 367)
  │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 368)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AnchoredSPInvariantsTest.invariant_allFundsClaimable() (NodeID: 369)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 370)
  │ │   💬 Args: ["stabilityPoolColl:          ", stabilityPoolColl.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 375)
  │ │ │   💬 Args: [stabilityPoolColl]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 376)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 377)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 378)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 379)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 380)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 381)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 382)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 383)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 384)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 385)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 386)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 387)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 388)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 389)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 390)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 391)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 392)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 393)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 394)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 395)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 396)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 397)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 371)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 372)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 373)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 374)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 398)
  │ │   💬 Args: ["claimableColl:              ", claimableColl.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 403)
  │ │ │   💬 Args: [claimableColl]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 404)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 405)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 406)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 407)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 408)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 409)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 410)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 411)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 412)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 413)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 414)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 415)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 416)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 417)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 418)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 419)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 420)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 421)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 422)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 423)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 424)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 425)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 399)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 400)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 401)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 402)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 426)
  │ │   💬 Args: ["stabilityPoolBold:          ", stabilityPoolBold.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 431)
  │ │ │   💬 Args: [stabilityPoolBold]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 432)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 433)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 434)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 435)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 436)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 437)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 438)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 439)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 440)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 441)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 442)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 443)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 444)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 445)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 446)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 447)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 448)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 449)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 450)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 451)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 452)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 453)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 427)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 428)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 429)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 430)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 454)
  │ │   💬 Args: ["claimableBold:              ", claimableBold.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 459)
  │ │ │   💬 Args: [claimableBold]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 460)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 461)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 462)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 463)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 464)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 465)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 466)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 467)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 468)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 469)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 470)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 471)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 472)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 473)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 474)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 475)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 476)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 477)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 478)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 479)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 480)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 481)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 455)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 456)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 457)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 458)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 482)
  │ │   💬 Args: ["yieldGainsOwed:             ", yieldGainsOwed.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 487)
  │ │ │   💬 Args: [yieldGainsOwed]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 488)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 489)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 490)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 491)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 492)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 493)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 494)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 495)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 496)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 497)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 498)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 499)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 500)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 501)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 502)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 503)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 504)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 505)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 506)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 507)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 508)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 509)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 483)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 484)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 485)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 486)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 510)
  │ │   💬 Args: ["sumYieldGains:              ", sumYieldGains.decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 515)
  │ │ │   💬 Args: [sumYieldGains]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 516)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 517)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 518)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 519)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 520)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 521)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 522)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 523)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 524)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 525)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 526)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 527)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 528)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 529)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 530)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 531)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 532)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 533)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 534)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 535)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 536)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 537)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 511)
  │ │     💬 Args: ["// ", a, b]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 512)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 513)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 514)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string,string,string) (NodeID: 538)
  │ │   💬 Args: [actors[i].label, ":                       ", stabilityPool.getDepositorYieldGain(actors[i].account).decimal()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 543)
  │ │ │   💬 Args: [stabilityPool.getDepositorYieldGain(actors[i].account)]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 544)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 545)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 546)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 547)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 548)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 549)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 550)
  │ │ │ │   💬 Args: [integerPart]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 551)
  │ │ │ │ │   💬 Args: [n]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 552)
  │ │ │ │ │     💬 Args: [value]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 553)
  │ │ │ │     💬 Args: [n.toString()]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 554)
  │ │ │ │   │   💬 Args: [bytes(str)]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 555)
  │ │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 556)
  │ │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 557)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 558)
  │ │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 559)
  │ │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 560)
  │ │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 561)
  │ │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 562)
  │ │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 563)
  │ │ │   │   💬 Args: [bytes(str), char]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 564)
  │ │ │   │     💬 Args: [str, 0, int256(end)]
  │ │ │   │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 565)
  │ │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string,string) (NodeID: 539)
  │ │     💬 Args: ["// ", a, b, c]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 540)
  │ │       💬 Args: [string.concat(a, b, c, d)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 541)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 542)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging.info(string) (NodeID: 566)
  │ │   💬 Args: [""]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 567)
  │ │     💬 Args: ["// ", a]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 568)
  │ │       💬 Args: [string.concat(a, b)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 569)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 570)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 571)
  │ │   💬 Args: [stabilityPoolColl, claimableColl, 0.00001 ether, 18, "SP Coll !~ claimable Coll"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 572)
  │ │   💬 Args: [stabilityPoolBold, claimableBold, 0.001 ether, 18, "SP BOLD !~ claimable BOLD"]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 573)
  │     💬 Args: [yieldGainsOwed, sumYieldGains, 0.001 ether, 18, "SP yieldGainsOwed !~= sum(yieldGain)"]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: AnchoredSPInvariantsTest.invariant_allFundsClaimable() (NodeID: 574)
      💬 Args: [no args]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 575)
    │   💬 Args: ["stabilityPoolColl:          ", stabilityPoolColl.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 580)
    │ │   💬 Args: [stabilityPoolColl]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 581)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 582)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 583)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 584)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 585)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 586)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 587)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 588)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 589)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 590)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 591)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 592)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 593)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 594)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 595)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 596)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 597)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 598)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 599)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 600)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 601)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 602)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 576)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 577)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 578)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 579)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 603)
    │   💬 Args: ["claimableColl:              ", claimableColl.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 608)
    │ │   💬 Args: [claimableColl]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 609)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 610)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 611)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 612)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 613)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 614)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 615)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 616)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 617)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 618)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 619)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 620)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 621)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 622)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 623)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 624)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 625)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 626)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 627)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 628)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 629)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 630)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 604)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 605)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 606)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 607)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 631)
    │   💬 Args: ["stabilityPoolBold:          ", stabilityPoolBold.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 636)
    │ │   💬 Args: [stabilityPoolBold]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 637)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 638)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 639)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 640)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 641)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 642)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 643)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 644)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 645)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 646)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 647)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 648)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 649)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 650)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 651)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 652)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 653)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 654)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 655)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 656)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 657)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 658)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 632)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 633)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 634)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 635)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 659)
    │   💬 Args: ["claimableBold:              ", claimableBold.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 664)
    │ │   💬 Args: [claimableBold]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 665)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 666)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 667)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 668)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 669)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 670)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 671)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 672)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 673)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 674)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 675)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 676)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 677)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 678)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 679)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 680)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 681)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 682)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 683)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 684)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 685)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 686)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 660)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 661)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 662)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 663)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 687)
    │   💬 Args: ["yieldGainsOwed:             ", yieldGainsOwed.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 692)
    │ │   💬 Args: [yieldGainsOwed]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 693)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 694)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 695)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 696)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 697)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 698)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 699)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 700)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 701)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 702)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 703)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 704)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 705)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 706)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 707)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 708)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 709)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 710)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 711)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 712)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 713)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 714)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 688)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 689)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 690)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 691)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string) (NodeID: 715)
    │   💬 Args: ["sumYieldGains:              ", sumYieldGains.decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 720)
    │ │   💬 Args: [sumYieldGains]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 721)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 722)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 723)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 724)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 725)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 726)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 727)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 728)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 729)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 730)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 731)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 732)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 733)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 734)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 735)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 736)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 737)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 738)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 739)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 740)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 741)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 742)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 716)
    │     💬 Args: ["// ", a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 717)
    │       💬 Args: [string.concat(a, b, c)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 718)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 719)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string,string,string) (NodeID: 743)
    │   💬 Args: [actors[i].label, ":                       ", stabilityPool.getDepositorYieldGain(actors[i].account).decimal()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 748)
    │ │   💬 Args: [stabilityPool.getDepositorYieldGain(actors[i].account)]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 749)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 750)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 751)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 752)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 753)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 754)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 755)
    │ │ │   💬 Args: [integerPart]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 756)
    │ │ │ │   💬 Args: [n]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 757)
    │ │ │ │     💬 Args: [value]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 758)
    │ │ │     💬 Args: [n.toString()]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 759)
    │ │ │   │   💬 Args: [bytes(str)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 760)
    │ │ │       💬 Args: [bytes(str).groupRight()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 761)
    │ │ │   💬 Args: [(ONE + fractionalPart)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 762)
    │ │ │     💬 Args: [value]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 763)
    │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 764)
    │ │ │ │   💬 Args: [bytes(str), start]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 765)
    │ │ │ │     💬 Args: [str, start, int256(str.length)]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 766)
    │ │ │     💬 Args: [bytes(str).slice(start)]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 767)
    │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 768)
    │ │   │   💬 Args: [bytes(str), char]
    │ │   │   👁️  Def: internal
    │ │   │ └─ [6] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 769)
    │ │   │     💬 Args: [str, 0, int256(end)]
    │ │   │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 770)
    │ │       💬 Args: [bytes(str).trimEnd(char)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string,string) (NodeID: 744)
    │     💬 Args: ["// ", a, b, c]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 745)
    │       💬 Args: [string.concat(a, b, c, d)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 746)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 747)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Logging.info(string) (NodeID: 771)
    │   💬 Args: [""]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 772)
    │     💬 Args: ["// ", a]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 773)
    │       💬 Args: [string.concat(a, b)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 774)
    │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 775)
    │           💬 Args: [_sendLogPayloadView]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 776)
    │   💬 Args: [stabilityPoolColl, claimableColl, 0.00001 ether, 18, "SP Coll !~ claimable Coll"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 777)
    │   💬 Args: [stabilityPoolBold, claimableBold, 0.001 ether, 18, "SP BOLD !~ claimable BOLD"]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 778)
        💬 Args: [yieldGainsOwed, sumYieldGains, 0.001 ether, 18, "SP yieldGainsOwed !~= sum(yieldGain)"]
        👁️  Def: internal
```
