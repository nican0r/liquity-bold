# Function: getETHGasCompensation()

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `getETHGasCompensation()`
- **Visibility**: external
- **Source Range**: 3850:109:282

## Implementation

```solidity
function getETHGasCompensation() external pure returns (uint256) {
    return ETH_GAS_COMPENSATION;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.getETHGasCompensation() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
