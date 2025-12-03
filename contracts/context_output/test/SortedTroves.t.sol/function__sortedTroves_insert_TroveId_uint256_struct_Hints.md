# Function: _sortedTroves_insert(TroveId,uint256,struct Hints)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_sortedTroves_insert(TroveId,uint256,struct Hints)`
- **Visibility**: external
- **Source Range**: 4562:606:247

## Implementation

```solidity
function _sortedTroves_insert(TroveId id, uint256 annualInterestRate, Hints memory hints) external {
    _sortedTroves.insert(TroveId.unwrap(id), annualInterestRate, TroveId.unwrap(hints.prev), TroveId.unwrap(hints.next));
}
```

## External Calls

- **SortedTroves::insert(uint256,uint256,uint256,uint256)**

## State Variable Reads

- **_sortedTroves** (`contract SortedTroves`) [src/SortedTroves.sol/contract_SortedTroves.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._sortedTroves_insert(TroveId,uint256,struct Hints) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
