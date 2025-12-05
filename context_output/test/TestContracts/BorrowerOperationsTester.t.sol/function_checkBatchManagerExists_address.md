# Function: checkBatchManagerExists(address)

**Contract**: [test/TestContracts/BorrowerOperationsTester.t.sol/contract_BorrowerOperationsTester.md]

## Metadata

- **Contract**: BorrowerOperationsTester
- **Signature**: `checkBatchManagerExists(address)`
- **Visibility**: external
- **Source Range**: 53815:165:128
- **Inherited From**: BorrowerOperations

## Implementation

```solidity
function checkBatchManagerExists(address _batchManager) external view returns (bool) {
    return interestBatchManagers[_batchManager].maxInterestRate > 0;
}
```

## State Variable Reads

- **interestBatchManagers** (`mapping(address => struct IBorrowerOperations.InterestBatchManager)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.checkBatchManagerExists(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
