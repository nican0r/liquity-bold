# Function: _sortedTroves_remove(TroveId)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_sortedTroves_remove(TroveId)`
- **Visibility**: external
- **Source Range**: 5802:108:247

## Implementation

```solidity
function _sortedTroves_remove(TroveId id) external {
    _sortedTroves.remove(TroveId.unwrap(id));
}
```

## External Calls

- **SortedTroves::remove(uint256)**

## State Variable Writes

- **_sortedTroves** (`contract SortedTroves`) [src/SortedTroves.sol/contract_SortedTroves.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._sortedTroves_remove(TroveId) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
