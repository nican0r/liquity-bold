# Function: _sortedTroves_getSize()

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_sortedTroves_getSize()`
- **Visibility**: external
- **Source Range**: 4444:112:247

## Implementation

```solidity
function _sortedTroves_getSize() external view returns (uint256) {
    return _sortedTroves.getSize();
}
```

## External Calls

- **SortedTroves::getSize()**

## State Variable Reads

- **_sortedTroves** (`contract SortedTroves`) [src/SortedTroves.sol/contract_SortedTroves.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._sortedTroves_getSize() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
