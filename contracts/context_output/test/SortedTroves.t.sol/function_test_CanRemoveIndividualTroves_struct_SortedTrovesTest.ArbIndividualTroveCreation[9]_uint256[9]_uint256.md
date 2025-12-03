# Function: test_CanRemoveIndividualTroves(struct SortedTrovesTest.ArbIndividualTroveCreation[9],uint256[9],uint256)

**Contract**: [test/SortedTroves.t.sol/contract_SortedTrovesTest.md]

## Metadata

- **Contract**: SortedTrovesTest
- **Signature**: `test_CanRemoveIndividualTroves(struct SortedTrovesTest.ArbIndividualTroveCreation[9],uint256[9],uint256)`
- **Visibility**: public
- **Source Range**: 17613:693:247

## Implementation

```solidity
function test_CanRemoveIndividualTroves(ArbIndividualTroveCreation[FUZZ_INPUT_LENGTH] calldata troves, uint256[FUZZ_INPUT_LENGTH] calldata removedTroves, uint256 numTrovesToRemove) public {
    numTrovesToRemove = bound(numTrovesToRemove, 1, troves.length);
    _buildList(troves);
    assertEq(tm._sortedTroves_getSize(), troves.length);
    for (uint256 i = 0; i < numTrovesToRemove; ++i) {
        TroveId id = _pickTrove(removedTroves[i]);
        tm._removeTrove(id);
        tm._sortedTroves_remove(id);
    }
    assertEq(tm._sortedTroves_getSize(), troves.length - numTrovesToRemove);
    _checkOrdering();
}
```

## Related Implementations

### bound(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 2915:199:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:bound(uint256,uint256,uint256)`

```solidity
function bound(uint256 x, uint256 min, uint256 max) virtual internal pure returns (uint256 result) {
    result = _bound(x, min, max);
    console2_log_StdUtils("Bound result", result);
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

### console2_log_StdUtils(string,uint256)

- **Kind**: internal
- **Source**: 10318:162:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:console2_log_StdUtils(string,uint256)`

```solidity
function console2_log_StdUtils(string memory p0, uint256 p1) private pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
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

### _buildList(struct SortedTrovesTest.ArbIndividualTroveCreation[9])

- **Kind**: internal
- **Source**: 13621:375:247
- **Link**: `test/SortedTroves.t.sol:SortedTrovesTest:_buildList(struct SortedTrovesTest.ArbIndividualTroveCreation[9])`

```solidity
/// 
///  Helpers for test case setup
function _buildList(ArbIndividualTroveCreation[FUZZ_INPUT_LENGTH] calldata troves) internal {
    for (uint256 i = 0; i < troves.length; ++i) {
        tm._sortedTroves_insert(tm._addIndividualTrove(troves[i].annualInterestRate), troves[i].annualInterestRate, _pickHints(troves[i].hints));
    }
}
```

### _pickHints(struct SortedTrovesTest.ArbHints)

- **Kind**: internal
- **Source**: 8698:230:247
- **Link**: `test/SortedTroves.t.sol:SortedTrovesTest:_pickHints(struct SortedTrovesTest.ArbHints)`

```solidity
function _pickHints(ArbHints calldata hints) internal view returns (Hints memory) {
    uint256 troveCount = tm.getTroveCount();
    return Hints(_pickHint(troveCount, hints.prev), _pickHint(troveCount, hints.next));
}
```

### _pickHint(uint256,uint256)

- **Kind**: internal
- **Source**: 8161:531:247
- **Link**: `test/SortedTroves.t.sol:SortedTrovesTest:_pickHint(uint256,uint256)`

```solidity
/// 
///  Bounding fuzzy inputs
function _pickHint(uint256 troveCount, uint256 i) internal view returns (TroveId) {
    i = bound(i, 0, (troveCount * 2) + 1);
    if (i == 0) {
        return TROVE_ID_ZERO;
    } else if (i <= troveCount) {
        return tm.getTroveId(i - 1);
    } else if (i <= (troveCount * 2)) {
        return TroveId.wrap(((tm._nextTroveId() + i) - 1) - troveCount);
    } else {
        return TROVE_ID_END_OF_LIST;
    }
}
```

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
}
```

### _pickTrove(uint256)

- **Kind**: internal
- **Source**: 8934:145:247
- **Link**: `test/SortedTroves.t.sol:SortedTrovesTest:_pickTrove(uint256)`

```solidity
function _pickTrove(uint256 trove) internal view returns (TroveId) {
    return tm.getTroveId(bound(trove, 0, tm.getTroveCount() - 1));
}
```

### _checkOrdering()

- **Kind**: internal
- **Source**: 9760:2179:247
- **Link**: `test/SortedTroves.t.sol:SortedTrovesTest:_checkOrdering()`

```solidity
/// 
///  Invariant checks
function _checkOrdering() internal view {
    uint256 i = 0;
    uint256 troveCount = tm.getTroveCount();
    TroveId[] memory troveIds = new TroveId[](troveCount);
    TroveId curr = tm._sortedTroves_getFirst();
    if (curr.isEndOfList()) {
        assertEq(tm.getTroveCount(), 0, "SortedTroves forward node count doesn't match TroveManager");
        assertEq(tm._sortedTroves_getLast(), TROVE_ID_END_OF_LIST, "SortedTroves reverse node count doesn't match TroveManager");
        return;
    }
    troveIds[i++] = curr;
    uint256 prevAnnualInterestRate = tm.getTroveAnnualInterestRate(curr);
    console.log();
    console.log("Forward list:");
    console.log("  Trove", TroveId.unwrap(curr), "annualInterestRate", prevAnnualInterestRate);
    curr = tm._sortedTroves_getNext(curr);
    while (curr.isNotEndOfList()) {
        uint256 currAnnualInterestRate = tm.getTroveAnnualInterestRate(curr);
        console.log("  Trove", TroveId.unwrap(curr), "annualInterestRate", currAnnualInterestRate);
        assertLe(currAnnualInterestRate, prevAnnualInterestRate, "SortedTroves ordering is broken");
        troveIds[i++] = curr;
        prevAnnualInterestRate = currAnnualInterestRate;
        curr = tm._sortedTroves_getNext(curr);
    }
    assertEq(i, tm.getTroveCount(), "SortedTroves forward node count doesn't match TroveManager");
    console.log();
    console.log("Reverse list:");
    curr = tm._sortedTroves_getLast();
    while (i > 0) {
        console.log("  Trove", TroveId.unwrap(curr));
        assertNe(curr, TROVE_ID_END_OF_LIST, "SortedTroves reverse node count doesn't match TroveManager");
        assertEq(curr, troveIds[--i], "SortedTroves reverse ordering is broken");
        curr = tm._sortedTroves_getPrev(curr);
    }
    console.log();
    assertEq(curr, TROVE_ID_END_OF_LIST, "SortedTroves reverse node count doesn't match TroveManager");
}
```

### isEndOfList(TroveId)

- **Kind**: free-function
- **Source**: 425:93:194
- **Link**: `src/Types/TroveId.sol:isEndOfList(TroveId)`

```solidity
function isEndOfList(TroveId x) pure returns (bool) {
    return x == TROVE_ID_END_OF_LIST;
}
```

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### assertEq(TroveId,TroveId,string)

- **Kind**: internal
- **Source**: 9452:141:247
- **Link**: `test/SortedTroves.t.sol:SortedTrovesTest:assertEq(TroveId,TroveId,string)`

```solidity
/// 
///  Custom assertions
function assertEq(TroveId a, TroveId b, string memory err) internal pure {
    assertEq(TroveId.unwrap(a), TroveId.unwrap(b), err);
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

### log(string)

- **Kind**: internal
- **Source**: 6191:121:61
- **Link**: `lib/forge-std/src/console.sol:console:log(string)`

```solidity
function log(string memory p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
}
```

### log(string,uint256,string,uint256)

- **Kind**: internal
- **Source**: 33028:198:61
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256,string,uint256)`

```solidity
function log(string memory p0, uint256 p1, string memory p2, uint256 p3) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256,string,uint256)", p0, p1, p2, p3));
}
```

### isNotEndOfList(TroveId)

- **Kind**: free-function
- **Source**: 520:87:194
- **Link**: `src/Types/TroveId.sol:isNotEndOfList(TroveId)`

```solidity
function isNotEndOfList(TroveId x) pure returns (bool) {
    return !x.isEndOfList();
}
```

### assertLe(uint256,uint256,string)

- **Kind**: internal
- **Source**: 14412:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLe(uint256,uint256,string)`

```solidity
function assertLe(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertLe(left, right, err);
}
```

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:61
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

### assertNe(TroveId,TroveId,string)

- **Kind**: internal
- **Source**: 9599:113:247
- **Link**: `test/SortedTroves.t.sol:SortedTrovesTest:assertNe(TroveId,TroveId,string)`

```solidity
function assertNe(TroveId a, TroveId b, string memory err) internal pure {
    assertTrue(a != b, err);
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

## External Calls

- **MockTroveManager::_sortedTroves_getSize()**
- **MockTroveManager::_removeTrove(TroveId)**
- **MockTroveManager::_sortedTroves_remove(TroveId)**

## State Variable Reads

- **tm** (`contract MockTroveManager`) [test/SortedTroves.t.sol/contract_MockTroveManager.md]
- **UINT256_MAX** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTrovesTest.test_CanRemoveIndividualTroves(struct SortedTrovesTest.ArbIndividualTroveCreation[9],uint256[9],uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [numTrovesToRemove, 1, troves.length]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 2)
  │ │   💬 Args: [x, min, max]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 3)
  │     💬 Args: ["Bound result", result]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 4)
  │       💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 5)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SortedTrovesTest._buildList(struct SortedTrovesTest.ArbIndividualTroveCreation[9]) (NodeID: 6)
  │   💬 Args: [troves]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SortedTrovesTest._pickHints(struct SortedTrovesTest.ArbHints) (NodeID: 7)
  │     💬 Args: [troves[i].hints]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: SortedTrovesTest._pickHint(uint256,uint256) (NodeID: 8)
  │   │   💬 Args: [troveCount, hints.prev]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 9)
  │   │     💬 Args: [i, 0, (troveCount * 2) + 1]
  │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 10)
  │   │   │   💬 Args: [x, min, max]
  │   │   │   👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 11)
  │   │       💬 Args: ["Bound result", result]
  │   │       👁️  Def: private
  │   │     └─ [6] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 12)
  │   │         💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │   │         👁️  Def: internal
  │   │       └─ [7] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 13)
  │   │           💬 Args: [_sendLogPayloadView]
  │   │           👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: SortedTrovesTest._pickHint(uint256,uint256) (NodeID: 14)
  │       💬 Args: [troveCount, hints.next]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 15)
  │         💬 Args: [i, 0, (troveCount * 2) + 1]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 16)
  │       │   💬 Args: [x, min, max]
  │       │   👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 17)
  │           💬 Args: ["Bound result", result]
  │           👁️  Def: private
  │         └─ [6] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 18)
  │             💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │             👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 19)
  │               💬 Args: [_sendLogPayloadView]
  │               👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 20)
  │   💬 Args: [tm._sortedTroves_getSize(), troves.length]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SortedTrovesTest._pickTrove(uint256) (NodeID: 21)
  │   💬 Args: [removedTroves[i]]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 22)
  │     💬 Args: [trove, 0, tm.getTroveCount() - 1]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 23)
  │   │   💬 Args: [x, min, max]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 24)
  │       💬 Args: ["Bound result", result]
  │       👁️  Def: private
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 25)
  │         💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 26)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 27)
  │   💬 Args: [tm._sortedTroves_getSize(), troves.length - numTrovesToRemove]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SortedTrovesTest._checkOrdering() (NodeID: 28)
      💬 Args: [no args]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Unknown.isEndOfList(TroveId) (NodeID: 29)
    │   💬 Args: [curr]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 30)
    │   💬 Args: [tm.getTroveCount(), 0, "SortedTroves forward node count doesn't match TroveManager"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SortedTrovesTest.assertEq(TroveId,TroveId,string) (NodeID: 31)
    │   💬 Args: [tm._sortedTroves_getLast(), TROVE_ID_END_OF_LIST, "SortedTroves reverse node count doesn't match TroveManager"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 32)
    │     💬 Args: [TroveId.unwrap(a), TroveId.unwrap(b), err]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log() (NodeID: 33)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 34)
    │     💬 Args: [abi.encodeWithSignature("log()")]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 35)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 36)
    │   💬 Args: ["Forward list:"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 37)
    │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 38)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string,uint256,string,uint256) (NodeID: 39)
    │   💬 Args: ["  Trove", TroveId.unwrap(curr), "annualInterestRate", prevAnnualInterestRate]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 40)
    │     💬 Args: [abi.encodeWithSignature("log(string,uint256,string,uint256)", p0, p1, p2, p3)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 41)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Unknown.isNotEndOfList(TroveId) (NodeID: 42)
    │   💬 Args: [curr]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Unknown.isEndOfList(TroveId) (NodeID: 43)
    │     💬 Args: [x]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string,uint256,string,uint256) (NodeID: 44)
    │   💬 Args: ["  Trove", TroveId.unwrap(curr), "annualInterestRate", currAnnualInterestRate]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 45)
    │     💬 Args: [abi.encodeWithSignature("log(string,uint256,string,uint256)", p0, p1, p2, p3)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 46)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256,string) (NodeID: 47)
    │   💬 Args: [currAnnualInterestRate, prevAnnualInterestRate, "SortedTroves ordering is broken"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 48)
    │   💬 Args: [i, tm.getTroveCount(), "SortedTroves forward node count doesn't match TroveManager"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log() (NodeID: 49)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 50)
    │     💬 Args: [abi.encodeWithSignature("log()")]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 51)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 52)
    │   💬 Args: ["Reverse list:"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 53)
    │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 54)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 55)
    │   💬 Args: ["  Trove", TroveId.unwrap(curr)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 56)
    │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 57)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SortedTrovesTest.assertNe(TroveId,TroveId,string) (NodeID: 58)
    │   💬 Args: [curr, TROVE_ID_END_OF_LIST, "SortedTroves reverse node count doesn't match TroveManager"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 59)
    │     💬 Args: [a != b, err]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SortedTrovesTest.assertEq(TroveId,TroveId,string) (NodeID: 60)
    │   💬 Args: [curr, troveIds[--i], "SortedTroves reverse ordering is broken"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 61)
    │     💬 Args: [TroveId.unwrap(a), TroveId.unwrap(b), err]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log() (NodeID: 62)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 63)
    │     💬 Args: [abi.encodeWithSignature("log()")]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 64)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SortedTrovesTest.assertEq(TroveId,TroveId,string) (NodeID: 65)
        💬 Args: [curr, TROVE_ID_END_OF_LIST, "SortedTroves reverse node count doesn't match TroveManager"]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 66)
          💬 Args: [TroveId.unwrap(a), TroveId.unwrap(b), err]
          👁️  Def: internal
```
