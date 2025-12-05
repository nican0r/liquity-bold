# Function: requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address)

**Contract**: [test/TestContracts/AddRemoveManagersTester.sol/contract_AddRemoveManagersTester.md]

## Metadata

- **Contract**: AddRemoveManagersTester
- **Signature**: `requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address)`
- **Visibility**: external
- **Source Range**: 461:245:249

## Implementation

```solidity
function requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256 _troveId, address _owner) external view returns (address) {
    return _requireSenderIsOwnerOrRemoveManagerAndGetReceiver(_troveId, _owner);
}
```

## Related Implementations

### _requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address)

- **Kind**: internal
- **Source**: 4485:544:133
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address)`

```solidity
function _requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256 _troveId, address _owner) internal view returns (address) {
    address manager = removeManagerReceiverOf[_troveId].manager;
    address receiver = removeManagerReceiverOf[_troveId].receiver;
    if ((msg.sender != _owner) && (msg.sender != manager)) {
        revert NotOwnerNorRemoveManager();
    }
    if ((receiver == address(0)) || (msg.sender != manager)) {
        return _owner;
    }
    return receiver;
}
```

## State Variable Reads

- **removeManagerReceiverOf** (`mapping(uint256 => struct AddRemoveManagers.RemoveManagerReceiver)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AddRemoveManagersTester.requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: AddRemoveManagers._requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address) (NodeID: 1)
      💬 Args: [_troveId, _owner]
      👁️  Def: internal
```
