# Function: getCollToken()

**Contract**: [test/TestContracts/BorrowerOperationsTester.t.sol/contract_BorrowerOperationsTester.md]

## Metadata

- **Contract**: BorrowerOperationsTester
- **Signature**: `getCollToken()`
- **Visibility**: external
- **Source Range**: 601:88:256

## Implementation

```solidity
function getCollToken() external view returns (IERC20) {
    return collToken;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperationsTester.getCollToken() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
