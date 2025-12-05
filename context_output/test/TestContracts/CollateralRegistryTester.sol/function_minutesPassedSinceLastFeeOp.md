# Function: minutesPassedSinceLastFeeOp()

**Contract**: [test/TestContracts/CollateralRegistryTester.sol/contract_CollateralRegistryTester.md]

## Metadata

- **Contract**: CollateralRegistryTester
- **Signature**: `minutesPassedSinceLastFeeOp()`
- **Visibility**: external
- **Source Range**: 729:125:258

## Implementation

```solidity
function minutesPassedSinceLastFeeOp() external view returns (uint256) {
    return _minutesPassedSinceLastFeeOp();
}
```

## Related Implementations

### _minutesPassedSinceLastFeeOp()

- **Kind**: internal
- **Source**: 8968:149:130
- **Link**: `src/CollateralRegistry.sol:CollateralRegistry:_minutesPassedSinceLastFeeOp()`

```solidity
function _minutesPassedSinceLastFeeOp() internal view returns (uint256) {
    return (block.timestamp - lastFeeOperationTime) / ONE_MINUTE;
}
```

## State Variable Reads

- **lastFeeOperationTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CollateralRegistryTester.minutesPassedSinceLastFeeOp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: CollateralRegistry._minutesPassedSinceLastFeeOp() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
