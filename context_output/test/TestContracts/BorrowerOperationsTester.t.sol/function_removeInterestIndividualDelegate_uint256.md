# Function: removeInterestIndividualDelegate(uint256)

**Contract**: [test/TestContracts/BorrowerOperationsTester.t.sol/contract_BorrowerOperationsTester.md]

## Metadata

- **Contract**: BorrowerOperationsTester
- **Signature**: `removeInterestIndividualDelegate(uint256)`
- **Visibility**: external
- **Source Range**: 33597:175:128
- **Inherited From**: BorrowerOperations

## Implementation

```solidity
function removeInterestIndividualDelegate(uint256 _troveId) external {
    _requireCallerIsBorrower(_troveId);
    delete interestIndividualDelegateOf[_troveId];
}
```

## Related Implementations

### _requireCallerIsBorrower(uint256)

- **Kind**: internal
- **Source**: 3796:173:133
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_requireCallerIsBorrower(uint256)`

```solidity
function _requireCallerIsBorrower(uint256 _troveId) internal view {
    if (msg.sender != troveNFT.ownerOf(_troveId)) {
        revert NotBorrower();
    }
}
```

## State Variable Reads

- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

## State Variable Writes

- **interestIndividualDelegateOf** (`mapping(uint256 => struct IBorrowerOperations.InterestIndividualDelegate)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.removeInterestIndividualDelegate(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: AddRemoveManagers._requireCallerIsBorrower(uint256) (NodeID: 1)
      💬 Args: [_troveId]
      👁️  Def: internal
```
