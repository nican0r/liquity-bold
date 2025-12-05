# Function: _sortedTroves_reInsertBatch(BatchId,uint256,struct Hints)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_sortedTroves_reInsertBatch(BatchId,uint256,struct Hints)`
- **Visibility**: external
- **Source Range**: 6268:268:247

## Implementation

```solidity
function _sortedTroves_reInsertBatch(BatchId batchId, uint256 newAnnualInterestRate, Hints memory hints) external {
    _sortedTroves.reInsertBatch(batchId, newAnnualInterestRate, TroveId.unwrap(hints.prev), TroveId.unwrap(hints.next));
}
```

## External Calls

- **SortedTroves::reInsertBatch(BatchId,uint256,uint256,uint256)**

## State Variable Reads

- **_sortedTroves** (`contract SortedTroves`) [src/SortedTroves.sol/contract_SortedTroves.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._sortedTroves_reInsertBatch(BatchId,uint256,struct Hints) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
