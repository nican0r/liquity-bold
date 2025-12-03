# Function: getTroveWeightedRecordedDebt(uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `getTroveWeightedRecordedDebt(uint256)`
- **Visibility**: external
- **Source Range**: 9461:520:282

## Implementation

```solidity
function getTroveWeightedRecordedDebt(uint256 _troveId) external view returns (uint256) {
    Trove memory trove = Troves[_troveId];
    address batchAddress = _getBatchManager(trove);
    if (batchAddress != address(0)) {
        Batch memory batch = batches[batchAddress];
        if (batch.totalDebtShares == 0) return 0;
        return ((batch.debt * trove.batchDebtShares) / batch.totalDebtShares) * batch.annualInterestRate;
    }
    return trove.debt * trove.annualInterestRate;
}
```

## Related Implementations

### _getBatchManager(struct TroveManager.Trove)

- **Kind**: internal
- **Source**: 47706:128:188
- **Link**: `src/TroveManager.sol:TroveManager:_getBatchManager(struct TroveManager.Trove)`

```solidity
function _getBatchManager(Trove memory trove) internal pure returns (address) {
    return trove.interestBatchManager;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.getTroveWeightedRecordedDebt(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: TroveManager._getBatchManager(struct TroveManager.Trove) (NodeID: 1)
      💬 Args: [trove]
      👁️  Def: internal
```
