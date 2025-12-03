# Function: test_SortsBatchedTrovesByAnnualInterestRate(struct SortedTrovesTest.ArbBatchedTroveCreation[9])

**Contract**: [test/SortedTroves.t.sol/contract_SortedTrovesTest.md]

## Metadata

- **Contract**: SortedTrovesTest
- **Signature**: `test_SortsBatchedTrovesByAnnualInterestRate(struct SortedTrovesTest.ArbBatchedTroveCreation[9])`
- **Visibility**: public
- **Source Range**: 16857:233:247

## Implementation

```solidity
function test_SortsBatchedTrovesByAnnualInterestRate(ArbBatchedTroveCreation[FUZZ_INPUT_LENGTH] calldata troves) public {
    _buildBatchedList(troves);
    _checkOrdering();
    _checkBatchContiguity();
}
```

## Related Implementations

### _buildBatchedList(struct SortedTrovesTest.ArbBatchedTroveCreation[9])

- **Kind**: internal
- **Source**: 14002:1460:247
- **Link**: `test/SortedTroves.t.sol:SortedTrovesTest:_buildBatchedList(struct SortedTrovesTest.ArbBatchedTroveCreation[9])`

```solidity
function _buildBatchedList(ArbBatchedTroveCreation[FUZZ_INPUT_LENGTH] calldata troves) internal {
    for (uint256 i = 0; i < troves.length; ++i) {
        ArbRole role = _pickRole(troves[i].role);
        if ((role == ArbRole.BatchJoiner) && (tm._getBatchCount() == 0)) {
            role = ArbRole.BatchStarter;
        }
        if (role == ArbRole.Individual) {
            tm._sortedTroves_insert(tm._addIndividualTrove(troves[i].annualInterestRate), troves[i].annualInterestRate, _pickHints(troves[i].hints));
        } else if (role == ArbRole.BatchStarter) {
            BatchId batchId = tm._addBatch(troves[i].annualInterestRate);
            tm._sortedTroves_insertIntoBatch(tm._addBatchedTrove(batchId), batchId, troves[i].annualInterestRate, _pickHints(troves[i].hints));
        } else if (role == ArbRole.BatchJoiner) {
            BatchId batchId = _pickBatch(troves[i].batch);
            TroveId troveId = tm._addBatchedTrove(batchId);
            tm._sortedTroves_insertIntoBatch(troveId, batchId, tm.getTroveAnnualInterestRate(troveId), _pickHints(troves[i].hints));
        } else {
            revert("Role not considered");
        }
    }
}
```

### _pickRole(uint256)

- **Kind**: internal
- **Source**: 9238:165:247
- **Link**: `test/SortedTroves.t.sol:SortedTrovesTest:_pickRole(uint256)`

```solidity
function _pickRole(uint256 role) internal pure returns (ArbRole) {
    return ArbRole(bound(role, uint256(type(ArbRole).min), uint256(type(ArbRole).max)));
}
```

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

### _pickBatch(uint256)

- **Kind**: internal
- **Source**: 9085:147:247
- **Link**: `test/SortedTroves.t.sol:SortedTrovesTest:_pickBatch(uint256)`

```solidity
function _pickBatch(uint256 batch) internal view returns (BatchId) {
    return tm._getBatchId(bound(batch, 0, tm._getBatchCount() - 1));
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

### _checkBatchContiguity()

- **Kind**: internal
- **Source**: 11945:1617:247
- **Link**: `test/SortedTroves.t.sol:SortedTrovesTest:_checkBatchContiguity()`

```solidity
function _checkBatchContiguity() internal {
    BatchIdSet seenBatches = new BatchIdSet();
    TroveId prev = tm._sortedTroves_getFirst();
    if (prev.isEndOfList()) {
        return;
    }
    BatchId prevBatch = tm._getBatchOf(prev);
    console.log("Batch IDs:");
    console.log("  ", BatchId.unwrap(prevBatch));
    if (prevBatch.isNotZero()) {
        assertEq(prev, tm._sortedTroves_getBatchHead(prevBatch), "Wrong batch head");
    }
    TroveId curr = tm._sortedTroves_getNext(prev);
    BatchId currBatch = tm._getBatchOf(curr);
    while (curr.isNotEndOfList()) {
        console.log("  ", BatchId.unwrap(currBatch));
        if (currBatch != prevBatch) {
            if (prevBatch.isNotZero()) {
                assertFalse(seenBatches.has(prevBatch), "Batch already seen");
                seenBatches.add(prevBatch);
                assertEq(prev, tm._sortedTroves_getBatchTail(prevBatch), "Wrong batch tail");
            }
            if (currBatch.isNotZero()) {
                assertEq(curr, tm._sortedTroves_getBatchHead(currBatch), "Wrong batch head");
            }
        }
        prev = curr;
        prevBatch = currBatch;
        curr = tm._sortedTroves_getNext(prev);
        currBatch = tm._getBatchOf(curr);
    }
    if (prevBatch.isNotZero()) {
        assertFalse(seenBatches.has(prevBatch), "Batch already seen");
        assertEq(prev, tm._sortedTroves_getBatchTail(prevBatch), "Wrong batch tail");
    }
    console.log();
}
```

### log(string,address)

- **Kind**: internal
- **Source**: 7740:145:61
- **Link**: `lib/forge-std/src/console.sol:console:log(string,address)`

```solidity
function log(string memory p0, address p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,address)", p0, p1));
}
```

### isNotZero(BatchId)

- **Kind**: free-function
- **Source**: 447:77:190
- **Link**: `src/Types/BatchId.sol:isNotZero(BatchId)`

```solidity
function isNotZero(BatchId x) pure returns (bool) {
    return !x.isZero();
}
```

### isZero(BatchId)

- **Kind**: free-function
- **Source**: 364:81:190
- **Link**: `src/Types/BatchId.sol:isZero(BatchId)`

```solidity
function isZero(BatchId x) pure returns (bool) {
    return x == BATCH_ID_ZERO;
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

## State Variable Reads

- **tm** (`contract MockTroveManager`) [test/SortedTroves.t.sol/contract_MockTroveManager.md]
- **UINT256_MAX** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTrovesTest.test_SortsBatchedTrovesByAnnualInterestRate(struct SortedTrovesTest.ArbBatchedTroveCreation[9]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SortedTrovesTest._buildBatchedList(struct SortedTrovesTest.ArbBatchedTroveCreation[9]) (NodeID: 1)
  │   💬 Args: [troves]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SortedTrovesTest._pickRole(uint256) (NodeID: 2)
  │ │   💬 Args: [troves[i].role]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 3)
  │ │     💬 Args: [role, uint256(type(ArbRole).min), uint256(type(ArbRole).max)]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 4)
  │ │   │   💬 Args: [x, min, max]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 5)
  │ │       💬 Args: ["Bound result", result]
  │ │       👁️  Def: private
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 6)
  │ │         💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 7)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SortedTrovesTest._pickHints(struct SortedTrovesTest.ArbHints) (NodeID: 8)
  │ │   💬 Args: [troves[i].hints]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SortedTrovesTest._pickHint(uint256,uint256) (NodeID: 9)
  │ │ │   💬 Args: [troveCount, hints.prev]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 10)
  │ │ │     💬 Args: [i, 0, (troveCount * 2) + 1]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 11)
  │ │ │   │   💬 Args: [x, min, max]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 12)
  │ │ │       💬 Args: ["Bound result", result]
  │ │ │       👁️  Def: private
  │ │ │     └─ [6] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 13)
  │ │ │         💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 14)
  │ │ │           💬 Args: [_sendLogPayloadView]
  │ │ │           👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: SortedTrovesTest._pickHint(uint256,uint256) (NodeID: 15)
  │ │     💬 Args: [troveCount, hints.next]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 16)
  │ │       💬 Args: [i, 0, (troveCount * 2) + 1]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 17)
  │ │     │   💬 Args: [x, min, max]
  │ │     │   👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 18)
  │ │         💬 Args: ["Bound result", result]
  │ │         👁️  Def: private
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 19)
  │ │           💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 20)
  │ │             💬 Args: [_sendLogPayloadView]
  │ │             👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SortedTrovesTest._pickHints(struct SortedTrovesTest.ArbHints) (NodeID: 21)
  │ │   💬 Args: [troves[i].hints]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SortedTrovesTest._pickHint(uint256,uint256) (NodeID: 22)
  │ │ │   💬 Args: [troveCount, hints.prev]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 23)
  │ │ │     💬 Args: [i, 0, (troveCount * 2) + 1]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 24)
  │ │ │   │   💬 Args: [x, min, max]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 25)
  │ │ │       💬 Args: ["Bound result", result]
  │ │ │       👁️  Def: private
  │ │ │     └─ [6] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 26)
  │ │ │         💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 27)
  │ │ │           💬 Args: [_sendLogPayloadView]
  │ │ │           👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: SortedTrovesTest._pickHint(uint256,uint256) (NodeID: 28)
  │ │     💬 Args: [troveCount, hints.next]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 29)
  │ │       💬 Args: [i, 0, (troveCount * 2) + 1]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 30)
  │ │     │   💬 Args: [x, min, max]
  │ │     │   👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 31)
  │ │         💬 Args: ["Bound result", result]
  │ │         👁️  Def: private
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 32)
  │ │           💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 33)
  │ │             💬 Args: [_sendLogPayloadView]
  │ │             👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SortedTrovesTest._pickBatch(uint256) (NodeID: 34)
  │ │   💬 Args: [troves[i].batch]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 35)
  │ │     💬 Args: [batch, 0, tm._getBatchCount() - 1]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 36)
  │ │   │   💬 Args: [x, min, max]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 37)
  │ │       💬 Args: ["Bound result", result]
  │ │       👁️  Def: private
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 38)
  │ │         💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 39)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SortedTrovesTest._pickHints(struct SortedTrovesTest.ArbHints) (NodeID: 40)
  │     💬 Args: [troves[i].hints]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: SortedTrovesTest._pickHint(uint256,uint256) (NodeID: 41)
  │   │   💬 Args: [troveCount, hints.prev]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 42)
  │   │     💬 Args: [i, 0, (troveCount * 2) + 1]
  │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 43)
  │   │   │   💬 Args: [x, min, max]
  │   │   │   👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 44)
  │   │       💬 Args: ["Bound result", result]
  │   │       👁️  Def: private
  │   │     └─ [6] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 45)
  │   │         💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │   │         👁️  Def: internal
  │   │       └─ [7] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 46)
  │   │           💬 Args: [_sendLogPayloadView]
  │   │           👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: SortedTrovesTest._pickHint(uint256,uint256) (NodeID: 47)
  │       💬 Args: [troveCount, hints.next]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 48)
  │         💬 Args: [i, 0, (troveCount * 2) + 1]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 49)
  │       │   💬 Args: [x, min, max]
  │       │   👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 50)
  │           💬 Args: ["Bound result", result]
  │           👁️  Def: private
  │         └─ [6] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 51)
  │             💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │             👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 52)
  │               💬 Args: [_sendLogPayloadView]
  │               👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SortedTrovesTest._checkOrdering() (NodeID: 53)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Unknown.isEndOfList(TroveId) (NodeID: 54)
  │ │   💬 Args: [curr]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 55)
  │ │   💬 Args: [tm.getTroveCount(), 0, "SortedTroves forward node count doesn't match TroveManager"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SortedTrovesTest.assertEq(TroveId,TroveId,string) (NodeID: 56)
  │ │   💬 Args: [tm._sortedTroves_getLast(), TROVE_ID_END_OF_LIST, "SortedTroves reverse node count doesn't match TroveManager"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 57)
  │ │     💬 Args: [TroveId.unwrap(a), TroveId.unwrap(b), err]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log() (NodeID: 58)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 59)
  │ │     💬 Args: [abi.encodeWithSignature("log()")]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 60)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 61)
  │ │   💬 Args: ["Forward list:"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 62)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 63)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256,string,uint256) (NodeID: 64)
  │ │   💬 Args: ["  Trove", TroveId.unwrap(curr), "annualInterestRate", prevAnnualInterestRate]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 65)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256,string,uint256)", p0, p1, p2, p3)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 66)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Unknown.isNotEndOfList(TroveId) (NodeID: 67)
  │ │   💬 Args: [curr]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Unknown.isEndOfList(TroveId) (NodeID: 68)
  │ │     💬 Args: [x]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256,string,uint256) (NodeID: 69)
  │ │   💬 Args: ["  Trove", TroveId.unwrap(curr), "annualInterestRate", currAnnualInterestRate]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 70)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256,string,uint256)", p0, p1, p2, p3)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 71)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256,string) (NodeID: 72)
  │ │   💬 Args: [currAnnualInterestRate, prevAnnualInterestRate, "SortedTroves ordering is broken"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 73)
  │ │   💬 Args: [i, tm.getTroveCount(), "SortedTroves forward node count doesn't match TroveManager"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log() (NodeID: 74)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 75)
  │ │     💬 Args: [abi.encodeWithSignature("log()")]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 76)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 77)
  │ │   💬 Args: ["Reverse list:"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 78)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 79)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 80)
  │ │   💬 Args: ["  Trove", TroveId.unwrap(curr)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 81)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 82)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SortedTrovesTest.assertNe(TroveId,TroveId,string) (NodeID: 83)
  │ │   💬 Args: [curr, TROVE_ID_END_OF_LIST, "SortedTroves reverse node count doesn't match TroveManager"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 84)
  │ │     💬 Args: [a != b, err]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SortedTrovesTest.assertEq(TroveId,TroveId,string) (NodeID: 85)
  │ │   💬 Args: [curr, troveIds[--i], "SortedTroves reverse ordering is broken"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 86)
  │ │     💬 Args: [TroveId.unwrap(a), TroveId.unwrap(b), err]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log() (NodeID: 87)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 88)
  │ │     💬 Args: [abi.encodeWithSignature("log()")]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 89)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SortedTrovesTest.assertEq(TroveId,TroveId,string) (NodeID: 90)
  │     💬 Args: [curr, TROVE_ID_END_OF_LIST, "SortedTroves reverse node count doesn't match TroveManager"]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 91)
  │       💬 Args: [TroveId.unwrap(a), TroveId.unwrap(b), err]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SortedTrovesTest._checkBatchContiguity() (NodeID: 92)
      💬 Args: [no args]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Unknown.isEndOfList(TroveId) (NodeID: 93)
    │   💬 Args: [prev]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 94)
    │   💬 Args: ["Batch IDs:"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 95)
    │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 96)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string,address) (NodeID: 97)
    │   💬 Args: ["  ", BatchId.unwrap(prevBatch)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 98)
    │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 99)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 100)
    │   💬 Args: [prevBatch]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 101)
    │     💬 Args: [x]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SortedTrovesTest.assertEq(TroveId,TroveId,string) (NodeID: 102)
    │   💬 Args: [prev, tm._sortedTroves_getBatchHead(prevBatch), "Wrong batch head"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 103)
    │     💬 Args: [TroveId.unwrap(a), TroveId.unwrap(b), err]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Unknown.isNotEndOfList(TroveId) (NodeID: 104)
    │   💬 Args: [curr]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Unknown.isEndOfList(TroveId) (NodeID: 105)
    │     💬 Args: [x]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string,address) (NodeID: 106)
    │   💬 Args: ["  ", BatchId.unwrap(currBatch)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 107)
    │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 108)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 109)
    │   💬 Args: [prevBatch]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 110)
    │     💬 Args: [x]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 111)
    │   💬 Args: [seenBatches.has(prevBatch), "Batch already seen"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SortedTrovesTest.assertEq(TroveId,TroveId,string) (NodeID: 112)
    │   💬 Args: [prev, tm._sortedTroves_getBatchTail(prevBatch), "Wrong batch tail"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 113)
    │     💬 Args: [TroveId.unwrap(a), TroveId.unwrap(b), err]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 114)
    │   💬 Args: [currBatch]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 115)
    │     💬 Args: [x]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SortedTrovesTest.assertEq(TroveId,TroveId,string) (NodeID: 116)
    │   💬 Args: [curr, tm._sortedTroves_getBatchHead(currBatch), "Wrong batch head"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 117)
    │     💬 Args: [TroveId.unwrap(a), TroveId.unwrap(b), err]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 118)
    │   💬 Args: [prevBatch]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 119)
    │     💬 Args: [x]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 120)
    │   💬 Args: [seenBatches.has(prevBatch), "Batch already seen"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SortedTrovesTest.assertEq(TroveId,TroveId,string) (NodeID: 121)
    │   💬 Args: [prev, tm._sortedTroves_getBatchTail(prevBatch), "Wrong batch tail"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 122)
    │     💬 Args: [TroveId.unwrap(a), TroveId.unwrap(b), err]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: console.log() (NodeID: 123)
        💬 Args: [no args]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 124)
          💬 Args: [abi.encodeWithSignature("log()")]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 125)
            💬 Args: [_sendLogPayloadView]
            👁️  Def: internal
```
