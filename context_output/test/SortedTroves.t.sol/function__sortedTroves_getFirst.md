# Function: _sortedTroves_getFirst()

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_sortedTroves_getFirst()`
- **Visibility**: external
- **Source Range**: 3495:128:247

## Implementation

```solidity
/// 
///  Wrappers around SortedTroves
///  Needed because only TroveManager has permissions to perform every operation
function _sortedTroves_getFirst() external view returns (TroveId) {
    return TroveId.wrap(_sortedTroves.getFirst());
}
```

## External Calls

- **SortedTroves::getFirst()**

## State Variable Reads

- **_sortedTroves** (`contract SortedTroves`) [src/SortedTroves.sol/contract_SortedTroves.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._sortedTroves_getFirst() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation


 Wrappers around SortedTroves
 Needed because only TroveManager has permissions to perform every operation
