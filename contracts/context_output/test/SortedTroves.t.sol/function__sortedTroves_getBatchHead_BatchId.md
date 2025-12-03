# Function: _sortedTroves_getBatchHead(BatchId)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_sortedTroves_getBatchHead(BatchId)`
- **Visibility**: external
- **Source Range**: 4081:175:247

## Implementation

```solidity
function _sortedTroves_getBatchHead(BatchId id) external view returns (TroveId) {
    (uint256 head, ) = _sortedTroves.batches(id);
    return TroveId.wrap(head);
}
```

## External Calls

- **SortedTroves::batches(BatchId)**

## State Variable Reads

- **_sortedTroves** (`contract SortedTroves`) [src/SortedTroves.sol/contract_SortedTroves.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._sortedTroves_getBatchHead(BatchId) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
