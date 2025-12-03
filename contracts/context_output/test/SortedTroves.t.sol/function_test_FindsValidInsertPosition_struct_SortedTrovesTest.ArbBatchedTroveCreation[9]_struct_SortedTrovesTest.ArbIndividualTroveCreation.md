# Function: test_FindsValidInsertPosition(struct SortedTrovesTest.ArbBatchedTroveCreation[9],struct SortedTrovesTest.ArbIndividualTroveCreation)

**Contract**: [test/SortedTroves.t.sol/contract_SortedTrovesTest.md]

## Metadata

- **Contract**: SortedTrovesTest
- **Signature**: `test_FindsValidInsertPosition(struct SortedTrovesTest.ArbBatchedTroveCreation[9],struct SortedTrovesTest.ArbIndividualTroveCreation)`
- **Visibility**: public
- **Source Range**: 17096:511:247

## Implementation

```solidity
function test_FindsValidInsertPosition(ArbBatchedTroveCreation[FUZZ_INPUT_LENGTH] calldata troves, ArbIndividualTroveCreation calldata inserted) public {
    _buildBatchedList(troves);
    assertTrue(tm._sortedTroves_validInsertPosition(inserted.annualInterestRate, tm._sortedTroves_findInsertPosition(inserted.annualInterestRate, _pickHints(inserted.hints))), "Invalid insert position found");
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

- **MockTroveManager::_sortedTroves_validInsertPosition(uint256,struct Hints)**
- **MockTroveManager::_sortedTroves_findInsertPosition(uint256,struct Hints)**

## State Variable Reads

- **tm** (`contract MockTroveManager`) [test/SortedTroves.t.sol/contract_MockTroveManager.md]
- **UINT256_MAX** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTrovesTest.test_FindsValidInsertPosition(struct SortedTrovesTest.ArbBatchedTroveCreation[9],struct SortedTrovesTest.ArbIndividualTroveCreation) (NodeID: 0)
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
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 53)
      💬 Args: [tm._sortedTroves_validInsertPosition(inserted.annualInterestRate, tm._sortedTroves_findInsertPosition(inserted.annualInterestRate, _pickHints(inserted.hints))), "Invalid insert position found"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SortedTrovesTest._pickHints(struct SortedTrovesTest.ArbHints) (NodeID: 54)
        💬 Args: [inserted.hints]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SortedTrovesTest._pickHint(uint256,uint256) (NodeID: 55)
      │   💬 Args: [troveCount, hints.prev]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 56)
      │     💬 Args: [i, 0, (troveCount * 2) + 1]
      │     👁️  Def: internal
      │   ├─ [5] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 57)
      │   │   💬 Args: [x, min, max]
      │   │   👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 58)
      │       💬 Args: ["Bound result", result]
      │       👁️  Def: private
      │     └─ [6] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 59)
      │         💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
      │         👁️  Def: internal
      │       └─ [7] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 60)
      │           💬 Args: [_sendLogPayloadView]
      │           👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: SortedTrovesTest._pickHint(uint256,uint256) (NodeID: 61)
          💬 Args: [troveCount, hints.next]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 62)
            💬 Args: [i, 0, (troveCount * 2) + 1]
            👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 63)
          │   💬 Args: [x, min, max]
          │   👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 64)
              💬 Args: ["Bound result", result]
              👁️  Def: private
            └─ [6] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 65)
                💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
                👁️  Def: internal
              └─ [7] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 66)
                  💬 Args: [_sendLogPayloadView]
                  👁️  Def: internal
```
