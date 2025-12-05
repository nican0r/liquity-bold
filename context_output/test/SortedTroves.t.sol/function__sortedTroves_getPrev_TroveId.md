# Function: _sortedTroves_getPrev(TroveId)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_sortedTroves_getPrev(TroveId)`
- **Visibility**: external
- **Source Range**: 3921:154:247

## Implementation

```solidity
function _sortedTroves_getPrev(TroveId id) external view returns (TroveId) {
    return TroveId.wrap(_sortedTroves.getPrev(TroveId.unwrap(id)));
}
```

## External Calls

- **SortedTroves::getPrev(uint256)**

## State Variable Reads

- **_sortedTroves** (`contract SortedTroves`) [src/SortedTroves.sol/contract_SortedTroves.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._sortedTroves_getPrev(TroveId) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
