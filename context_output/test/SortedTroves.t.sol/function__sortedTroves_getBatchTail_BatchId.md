# Function: _sortedTroves_getBatchTail(BatchId)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_sortedTroves_getBatchTail(BatchId)`
- **Visibility**: external
- **Source Range**: 4262:176:247

## Implementation

```solidity
function _sortedTroves_getBatchTail(BatchId id) external view returns (TroveId) {
    (, uint256 tail) = _sortedTroves.batches(id);
    return TroveId.wrap(tail);
}
```

## External Calls

- **SortedTroves::batches(BatchId)**

## State Variable Reads

- **_sortedTroves** (`contract SortedTroves`) [src/SortedTroves.sol/contract_SortedTroves.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._sortedTroves_getBatchTail(BatchId) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
