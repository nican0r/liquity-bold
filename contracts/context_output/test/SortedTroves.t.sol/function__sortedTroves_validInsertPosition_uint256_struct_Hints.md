# Function: _sortedTroves_validInsertPosition(uint256,struct Hints)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_sortedTroves_validInsertPosition(uint256,struct Hints)`
- **Visibility**: external
- **Source Range**: 7066:303:247

## Implementation

```solidity
function _sortedTroves_validInsertPosition(uint256 annualInterestRate, Hints memory hints) external view returns (bool) {
    return _sortedTroves.validInsertPosition(annualInterestRate, TroveId.unwrap(hints.prev), TroveId.unwrap(hints.next));
}
```

## External Calls

- **SortedTroves::validInsertPosition(uint256,uint256,uint256)**

## State Variable Reads

- **_sortedTroves** (`contract SortedTroves`) [src/SortedTroves.sol/contract_SortedTroves.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._sortedTroves_validInsertPosition(uint256,struct Hints) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
