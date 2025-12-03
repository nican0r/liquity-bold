# Function: getTroveAnnualInterestRate(TroveId)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `getTroveAnnualInterestRate(TroveId)`
- **Visibility**: public
- **Source Range**: 1191:258:247

## Implementation

```solidity
function getTroveAnnualInterestRate(TroveId troveId) public view returns (uint256) {
    return _troves[troveId].batchId.isZero() ? _troves[troveId].annualInterestRate : _batches[_troves[troveId].batchId].annualInterestRate;
}
```

## Related Implementations

### isZero(BatchId)

- **Kind**: free-function
- **Source**: 364:81:190
- **Link**: `src/Types/BatchId.sol:isZero(BatchId)`

```solidity
function isZero(BatchId x) pure returns (bool) {
    return x == BATCH_ID_ZERO;
}
```

## State Variable Reads

- **_troves** (`mapping(TroveId => struct MockTroveManager.Trove)`)
- **_batches** (`mapping(BatchId => struct MockTroveManager.Batch)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager.getTroveAnnualInterestRate(TroveId) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 1)
      💬 Args: [_troves[troveId].batchId]
      👁️  Def: internal
```
