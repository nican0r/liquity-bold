# Function: getInterestBatchManager(address)

**Contract**: [test/TestContracts/BorrowerOperationsTester.t.sol/contract_BorrowerOperationsTester.md]

## Metadata

- **Contract**: BorrowerOperationsTester
- **Signature**: `getInterestBatchManager(address)`
- **Visibility**: external
- **Source Range**: 33778:158:128
- **Inherited From**: BorrowerOperations

## Implementation

```solidity
function getInterestBatchManager(address _account) external view returns (InterestBatchManager memory) {
    return interestBatchManagers[_account];
}
```

## State Variable Reads

- **interestBatchManagers** (`mapping(address => struct IBorrowerOperations.InterestBatchManager)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.getInterestBatchManager(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
