# Function: onLiquidateTrove(uint256)

**Contract**: [src/BorrowerOperations.sol/contract_BorrowerOperations.md]

## Metadata

- **Contract**: BorrowerOperations
- **Signature**: `onLiquidateTrove(uint256)`
- **Visibility**: external
- **Source Range**: 49901:139:128

## Implementation

```solidity
function onLiquidateTrove(uint256 _troveId) external {
    _requireCallerIsTroveManager();
    _wipeTroveMappings(_troveId);
}
```

## Related Implementations

### _requireCallerIsTroveManager()

- **Kind**: internal
- **Source**: 63694:166:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireCallerIsTroveManager()`

```solidity
function _requireCallerIsTroveManager() internal view {
    if (msg.sender != address(troveManager)) {
        revert CallerNotTroveManager();
    }
}
```

### _wipeTroveMappings(uint256)

- **Kind**: internal
- **Source**: 50046:208:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_wipeTroveMappings(uint256)`

```solidity
function _wipeTroveMappings(uint256 _troveId) internal {
    delete interestIndividualDelegateOf[_troveId];
    delete interestBatchManagerOf[_troveId];
    _wipeAddRemoveManagers(_troveId);
}
```

### _wipeAddRemoveManagers(uint256)

- **Kind**: internal
- **Source**: 3283:289:133
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_wipeAddRemoveManagers(uint256)`

```solidity
function _wipeAddRemoveManagers(uint256 _troveId) internal {
    delete addManagerOf[_troveId];
    delete removeManagerReceiverOf[_troveId];
    emit AddManagerUpdated(_troveId, address(0));
    emit RemoveManagerAndReceiverUpdated(_troveId, address(0), address(0));
}
```

## State Variable Reads

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

## State Variable Writes

- **interestIndividualDelegateOf** (`mapping(uint256 => struct IBorrowerOperations.InterestIndividualDelegate)`)
- **interestBatchManagerOf** (`mapping(uint256 => address)`)
- **addManagerOf** (`mapping(uint256 => address)`)
- **removeManagerReceiverOf** (`mapping(uint256 => struct AddRemoveManagers.RemoveManagerReceiver)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.onLiquidateTrove(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireCallerIsTroveManager() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BorrowerOperations._wipeTroveMappings(uint256) (NodeID: 2)
      💬 Args: [_troveId]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: AddRemoveManagers._wipeAddRemoveManagers(uint256) (NodeID: 3)
        💬 Args: [_troveId]
        👁️  Def: internal
```
