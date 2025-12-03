# Function: setLastFeeOpTimeToNow()

**Contract**: [test/TestContracts/CollateralRegistryTester.sol/contract_CollateralRegistryTester.md]

## Metadata

- **Contract**: CollateralRegistryTester
- **Signature**: `setLastFeeOpTimeToNow()`
- **Visibility**: external
- **Source Range**: 860:97:258

## Implementation

```solidity
function setLastFeeOpTimeToNow() external {
    lastFeeOperationTime = block.timestamp;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CollateralRegistryTester.setLastFeeOpTimeToNow() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
