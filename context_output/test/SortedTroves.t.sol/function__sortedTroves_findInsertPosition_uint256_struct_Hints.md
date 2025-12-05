# Function: _sortedTroves_findInsertPosition(uint256,struct Hints)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_sortedTroves_findInsertPosition(uint256,struct Hints)`
- **Visibility**: external
- **Source Range**: 6674:386:247

## Implementation

```solidity
function _sortedTroves_findInsertPosition(uint256 annualInterestRate, Hints memory hints) external view returns (Hints memory) {
    (uint256 prev, uint256 next) = _sortedTroves.findInsertPosition(annualInterestRate, TroveId.unwrap(hints.prev), TroveId.unwrap(hints.next));
    return Hints(TroveId.wrap(prev), TroveId.wrap(next));
}
```

## External Calls

- **SortedTroves::findInsertPosition(uint256,uint256,uint256)**

## State Variable Reads

- **_sortedTroves** (`contract SortedTroves`) [src/SortedTroves.sol/contract_SortedTroves.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._sortedTroves_findInsertPosition(uint256,struct Hints) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
