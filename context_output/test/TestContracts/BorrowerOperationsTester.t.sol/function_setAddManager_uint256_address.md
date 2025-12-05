# Function: setAddManager(uint256,address)

**Contract**: [test/TestContracts/BorrowerOperationsTester.t.sol/contract_BorrowerOperationsTester.md]

## Metadata

- **Contract**: BorrowerOperationsTester
- **Signature**: `setAddManager(uint256,address)`
- **Visibility**: external
- **Source Range**: 2158:163:133
- **Inherited From**: AddRemoveManagers

## Implementation

```solidity
function setAddManager(uint256 _troveId, address _manager) external {
    _requireCallerIsBorrower(_troveId);
    _setAddManager(_troveId, _manager);
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

### _setAddManager(uint256,address)

- **Kind**: internal
- **Source**: 2327:171:133
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_setAddManager(uint256,address)`

```solidity
function _setAddManager(uint256 _troveId, address _manager) internal {
    addManagerOf[_troveId] = _manager;
    emit AddManagerUpdated(_troveId, _manager);
}
```

## State Variable Reads

- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

## State Variable Writes

- **addManagerOf** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AddRemoveManagers.setAddManager(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: AddRemoveManagers._requireCallerIsBorrower(uint256) (NodeID: 1)
  │   💬 Args: [_troveId]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: AddRemoveManagers._setAddManager(uint256,address) (NodeID: 2)
      💬 Args: [_troveId, _manager]
      👁️  Def: internal
```
