# Function: getBorrowerOperations()

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `getBorrowerOperations()`
- **Visibility**: external
- **Source Range**: 1762:119:282

## Implementation

```solidity
function getBorrowerOperations() external view returns (IBorrowerOperations) {
    return borrowerOperations;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.getBorrowerOperations() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
