# Function: setRemoveManagerWithReceiverPermissionless(uint256,address,address)

**Contract**: [test/TestContracts/AddRemoveManagersTester.sol/contract_AddRemoveManagersTester.md]

## Metadata

- **Contract**: AddRemoveManagersTester
- **Signature**: `setRemoveManagerWithReceiverPermissionless(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 265:190:249

## Implementation

```solidity
function setRemoveManagerWithReceiverPermissionless(uint256 _troveId, address _manager, address _receiver) public {
    _setRemoveManagerAndReceiver(_troveId, _manager, _receiver);
}
```

## Related Implementations

### _setRemoveManagerAndReceiver(uint256,address,address)

- **Kind**: internal
- **Source**: 2900:377:133
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_setRemoveManagerAndReceiver(uint256,address,address)`

```solidity
function _setRemoveManagerAndReceiver(uint256 _troveId, address _manager, address _receiver) internal {
    _requireNonZeroManagerUnlessWiping(_manager, _receiver);
    removeManagerReceiverOf[_troveId].manager = _manager;
    removeManagerReceiverOf[_troveId].receiver = _receiver;
    emit RemoveManagerAndReceiverUpdated(_troveId, _manager, _receiver);
}
```

### _requireNonZeroManagerUnlessWiping(address,address)

- **Kind**: internal
- **Source**: 3578:212:133
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_requireNonZeroManagerUnlessWiping(address,address)`

```solidity
function _requireNonZeroManagerUnlessWiping(address _manager, address _receiver) internal pure {
    if ((_manager == address(0)) && (_receiver != address(0))) {
        revert EmptyManager();
    }
}
```

## State Variable Writes

- **removeManagerReceiverOf** (`mapping(uint256 => struct AddRemoveManagers.RemoveManagerReceiver)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AddRemoveManagersTester.setRemoveManagerWithReceiverPermissionless(uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AddRemoveManagers._setRemoveManagerAndReceiver(uint256,address,address) (NodeID: 1)
      💬 Args: [_troveId, _manager, _receiver]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: AddRemoveManagers._requireNonZeroManagerUnlessWiping(address,address) (NodeID: 2)
        💬 Args: [_manager, _receiver]
        👁️  Def: internal
```
