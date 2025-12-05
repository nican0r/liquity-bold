# Function: _sortedTroves_removeFromBatch(TroveId)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_sortedTroves_removeFromBatch(TroveId)`
- **Visibility**: external
- **Source Range**: 6542:126:247

## Implementation

```solidity
function _sortedTroves_removeFromBatch(TroveId id) external {
    _sortedTroves.removeFromBatch(TroveId.unwrap(id));
}
```

## External Calls

- **SortedTroves::removeFromBatch(uint256)**

## State Variable Reads

- **_sortedTroves** (`contract SortedTroves`) [src/SortedTroves.sol/contract_SortedTroves.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._sortedTroves_removeFromBatch(TroveId) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
