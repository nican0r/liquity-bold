# Function: _sortedTroves_getNext(TroveId)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_sortedTroves_getNext(TroveId)`
- **Visibility**: external
- **Source Range**: 3761:154:247

## Implementation

```solidity
function _sortedTroves_getNext(TroveId id) external view returns (TroveId) {
    return TroveId.wrap(_sortedTroves.getNext(TroveId.unwrap(id)));
}
```

## External Calls

- **SortedTroves::getNext(uint256)**

## State Variable Reads

- **_sortedTroves** (`contract SortedTroves`) [src/SortedTroves.sol/contract_SortedTroves.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._sortedTroves_getNext(TroveId) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
