# Function: getBatchLastDebtUpdateTime(address)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `getBatchLastDebtUpdateTime(address)`
- **Visibility**: external
- **Source Range**: 13647:156:282

## Implementation

```solidity
function getBatchLastDebtUpdateTime(address _batchAddress) external view returns (uint256) {
    return batches[_batchAddress].lastDebtUpdateTime;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.getBatchLastDebtUpdateTime(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
