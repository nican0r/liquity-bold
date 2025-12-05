# Function: _sortedTroves_reInsert(TroveId,uint256,struct Hints)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_sortedTroves_reInsert(TroveId,uint256,struct Hints)`
- **Visibility**: external
- **Source Range**: 5174:622:247

## Implementation

```solidity
function _sortedTroves_reInsert(TroveId id, uint256 newAnnualInterestRate, Hints memory hints) external {
    _sortedTroves.reInsert(TroveId.unwrap(id), newAnnualInterestRate, TroveId.unwrap(hints.prev), TroveId.unwrap(hints.next));
}
```

## External Calls

- **SortedTroves::reInsert(uint256,uint256,uint256,uint256)**

## State Variable Reads

- **_sortedTroves** (`contract SortedTroves`) [src/SortedTroves.sol/contract_SortedTroves.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._sortedTroves_reInsert(TroveId,uint256,struct Hints) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
