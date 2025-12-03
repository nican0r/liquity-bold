# Function: _setBatchInterestRate(BatchId,uint256)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_setBatchInterestRate(BatchId,uint256)`
- **Visibility**: external
- **Source Range**: 2459:155:247

## Implementation

```solidity
function _setBatchInterestRate(BatchId id, uint256 newAnnualInterestRate) external {
    _batches[id].annualInterestRate = newAnnualInterestRate;
}
```

## State Variable Writes

- **_batches** (`mapping(BatchId => struct MockTroveManager.Batch)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._setBatchInterestRate(BatchId,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
