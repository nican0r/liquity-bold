# Function: _sortedTroves_insertIntoBatch(TroveId,BatchId,uint256,struct Hints)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_sortedTroves_insertIntoBatch(TroveId,BatchId,uint256,struct Hints)`
- **Visibility**: external
- **Source Range**: 5916:346:247

## Implementation

```solidity
function _sortedTroves_insertIntoBatch(TroveId troveId, BatchId batchId, uint256 annualInterestRate, Hints memory hints) external {
    _sortedTroves.insertIntoBatch(TroveId.unwrap(troveId), batchId, annualInterestRate, TroveId.unwrap(hints.prev), TroveId.unwrap(hints.next));
}
```

## External Calls

- **SortedTroves::insertIntoBatch(uint256,BatchId,uint256,uint256,uint256)**

## State Variable Reads

- **_sortedTroves** (`contract SortedTroves`) [src/SortedTroves.sol/contract_SortedTroves.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._sortedTroves_insertIntoBatch(TroveId,BatchId,uint256,struct Hints) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
