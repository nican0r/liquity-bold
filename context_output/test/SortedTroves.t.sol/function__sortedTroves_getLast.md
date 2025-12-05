# Function: _sortedTroves_getLast()

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_sortedTroves_getLast()`
- **Visibility**: external
- **Source Range**: 3629:126:247

## Implementation

```solidity
function _sortedTroves_getLast() external view returns (TroveId) {
    return TroveId.wrap(_sortedTroves.getLast());
}
```

## External Calls

- **SortedTroves::getLast()**

## State Variable Reads

- **_sortedTroves** (`contract SortedTroves`) [src/SortedTroves.sol/contract_SortedTroves.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._sortedTroves_getLast() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
