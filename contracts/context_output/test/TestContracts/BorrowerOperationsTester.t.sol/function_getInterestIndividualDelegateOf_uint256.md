# Function: getInterestIndividualDelegateOf(uint256)

**Contract**: [test/TestContracts/BorrowerOperationsTester.t.sol/contract_BorrowerOperationsTester.md]

## Metadata

- **Contract**: BorrowerOperationsTester
- **Signature**: `getInterestIndividualDelegateOf(uint256)`
- **Visibility**: external
- **Source Range**: 32047:207:128
- **Inherited From**: BorrowerOperations

## Implementation

```solidity
function getInterestIndividualDelegateOf(uint256 _troveId) external view returns (InterestIndividualDelegate memory) {
    return interestIndividualDelegateOf[_troveId];
}
```

## State Variable Reads

- **interestIndividualDelegateOf** (`mapping(uint256 => struct IBorrowerOperations.InterestIndividualDelegate)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.getInterestIndividualDelegateOf(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
