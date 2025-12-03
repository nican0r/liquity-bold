# Function: getSortedTroves()

**Contract**: [test/TestContracts/BorrowerOperationsTester.t.sol/contract_BorrowerOperationsTester.md]

## Metadata

- **Contract**: BorrowerOperationsTester
- **Signature**: `getSortedTroves()`
- **Visibility**: external
- **Source Range**: 695:101:256

## Implementation

```solidity
function getSortedTroves() external view returns (ISortedTroves) {
    return sortedTroves;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperationsTester.getSortedTroves() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
