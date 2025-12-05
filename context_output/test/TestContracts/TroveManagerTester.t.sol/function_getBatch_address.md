# Function: getBatch(address)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `getBatch(address)`
- **Visibility**: external
- **Source Range**: 13809:745:282

## Implementation

```solidity
function getBatch(address _batchAddress) external view returns (uint256 debt, uint256 coll, uint64 arrayIndex, uint64 lastDebtUpdateTime, uint64 lastInterestRateAdjTime, uint256 annualInterestRate, uint256 annualManagementFee, uint256 totalDebtShares) {
    Batch memory batch = batches[_batchAddress];
    return (batch.debt, batch.coll, batch.arrayIndex, batch.lastDebtUpdateTime, batch.lastInterestRateAdjTime, batch.annualInterestRate, batch.annualManagementFee, batch.totalDebtShares);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.getBatch(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
