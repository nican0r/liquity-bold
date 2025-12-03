# Function: getBatchAnnualInterestRate(address)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `getBatchAnnualInterestRate(address)`
- **Visibility**: external
- **Source Range**: 13485:156:282

## Implementation

```solidity
function getBatchAnnualInterestRate(address _batchAddress) external view returns (uint256) {
    return batches[_batchAddress].annualInterestRate;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.getBatchAnnualInterestRate(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
