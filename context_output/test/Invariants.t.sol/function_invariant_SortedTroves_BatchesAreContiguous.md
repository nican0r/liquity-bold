# Function: invariant_SortedTroves_BatchesAreContiguous()

**Contract**: [test/Invariants.t.sol/contract_InvariantsTest.md]

## Metadata

- **Contract**: InvariantsTest
- **Signature**: `invariant_SortedTroves_BatchesAreContiguous()`
- **Visibility**: external
- **Source Range**: 17040:1684:243

## Implementation

```solidity
function invariant_SortedTroves_BatchesAreContiguous() external {
    for (uint256 j = 0; j < branches.length; ++j) {
        ISortedTroves sortedTroves = branches[j].sortedTroves;
        uint256 prev = sortedTroves.getFirst();
        if (prev == 0) {
            continue;
        }
        BatchId prevBatch = sortedTroves.getBatchOf(prev);
        if (prevBatch.isNotZero()) {
            assertEq(prev, sortedTroves.getBatchHead(prevBatch), "Wrong batch head");
        }
        uint256 curr = sortedTroves.getNext(prev);
        BatchId currBatch = sortedTroves.getBatchOf(curr);
        while (curr != 0) {
            if (currBatch != prevBatch) {
                if (prevBatch.isNotZero()) {
                    assertFalse(seenBatches.has(prevBatch), "Batch already seen");
                    assertEq(prev, sortedTroves.getBatchTail(prevBatch), "Wrong batch tail");
                    seenBatches.add(prevBatch);
                }
                if (currBatch.isNotZero()) {
                    assertEq(curr, sortedTroves.getBatchHead(currBatch), "Wrong batch head");
                }
            }
            prev = curr;
            prevBatch = currBatch;
            curr = sortedTroves.getNext(prev);
            currBatch = sortedTroves.getBatchOf(curr);
        }
        if (prevBatch.isNotZero()) {
            assertFalse(seenBatches.has(prevBatch), "Batch already seen");
            assertEq(prev, sortedTroves.getBatchTail(prevBatch), "Wrong batch tail");
        }
        seenBatches.clear();
    }
}
```

## Related Implementations

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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
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

### has(struct BatchIdSet,BatchId)

- **Kind**: internal
- **Source**: 676:124:286
- **Link**: `test/Utils/BatchIdSet.sol:BatchIdSetMethods:has(struct BatchIdSet,BatchId)`

```solidity
function has(BatchIdSet storage set, BatchId batchId) internal view returns (bool) {
    return set._has[batchId];
}
```

### add(struct BatchIdSet,BatchId)

- **Kind**: internal
- **Source**: 268:193:286
- **Link**: `test/Utils/BatchIdSet.sol:BatchIdSetMethods:add(struct BatchIdSet,BatchId)`

```solidity
function add(BatchIdSet storage set, BatchId batchId) internal {
    if (!set._has[batchId]) {
        set._has[batchId] = true;
        set._batchIds.push(batchId);
    }
}
```

### clear(struct BatchIdSet)

- **Kind**: internal
- **Source**: 467:203:286
- **Link**: `test/Utils/BatchIdSet.sol:BatchIdSetMethods:clear(struct BatchIdSet)`

```solidity
function clear(BatchIdSet storage set) internal {
    for (uint256 i = 0; i < set._batchIds.length; ++i) {
        delete set._has[set._batchIds[i]];
    }
    delete set._batchIds;
}
```

## External Calls

- **ISortedTroves::getFirst()**
- **ISortedTroves::getBatchOf(contract ISortedTroves,uint256)**
- **ISortedTroves::getBatchHead(contract ISortedTroves,BatchId)**
- **ISortedTroves::getNext(uint256)**
- **ISortedTroves::getBatchTail(contract ISortedTroves,BatchId)**

## State Variable Reads

- **seenBatches** (`struct BatchIdSet`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## State Variable Writes

- **seenBatches** (`struct BatchIdSet`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTest.invariant_SortedTroves_BatchesAreContiguous() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 1)
  │   💬 Args: [prevBatch]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 2)
  │     💬 Args: [x]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [prev, sortedTroves.getBatchHead(prevBatch), "Wrong batch head"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 4)
  │   💬 Args: [prevBatch]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 5)
  │     💬 Args: [x]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 6)
  │   💬 Args: [seenBatches.has(prevBatch), "Batch already seen"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BatchIdSetMethods.has(struct BatchIdSet,BatchId) (NodeID: 7)
  │     💬 Args: [seenBatches, prevBatch]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 8)
  │   💬 Args: [prev, sortedTroves.getBatchTail(prevBatch), "Wrong batch tail"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BatchIdSetMethods.add(struct BatchIdSet,BatchId) (NodeID: 9)
  │   💬 Args: [seenBatches, prevBatch]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 10)
  │   💬 Args: [currBatch]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 11)
  │     💬 Args: [x]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 12)
  │   💬 Args: [curr, sortedTroves.getBatchHead(currBatch), "Wrong batch head"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 13)
  │   💬 Args: [prevBatch]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 14)
  │     💬 Args: [x]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 15)
  │   💬 Args: [seenBatches.has(prevBatch), "Batch already seen"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BatchIdSetMethods.has(struct BatchIdSet,BatchId) (NodeID: 16)
  │     💬 Args: [seenBatches, prevBatch]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 17)
  │   💬 Args: [prev, sortedTroves.getBatchTail(prevBatch), "Wrong batch tail"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BatchIdSetMethods.clear(struct BatchIdSet) (NodeID: 18)
      💬 Args: [seenBatches]
      👁️  Def: internal
```
