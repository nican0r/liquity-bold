# Function: withdrawBold(uint256,uint256,uint256)

**Contract**: [src/Zappers/LeverageLSTZapper.sol/contract_LeverageLSTZapper.md]

## Metadata

- **Contract**: LeverageLSTZapper
- **Signature**: `withdrawBold(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4679:447:196
- **Inherited From**: GasCompZapper

## Implementation

```solidity
function withdrawBold(uint256 _troveId, uint256 _boldAmount, uint256 _maxUpfrontFee) external {
    address owner = troveNFT.ownerOf(_troveId);
    address receiver = _requireSenderIsOwnerOrRemoveManagerAndGetReceiver(_troveId, owner);
    _requireZapperIsReceiver(_troveId);
    borrowerOperations.withdrawBold(_troveId, _boldAmount, _maxUpfrontFee);
    boldToken.transfer(receiver, _boldAmount);
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

### _requireZapperIsReceiver(uint256)

- **Kind**: internal
- **Source**: 1662:247:195
- **Link**: `src/Zappers/BaseZapper.sol:BaseZapper:_requireZapperIsReceiver(uint256)`

```solidity
function _requireZapperIsReceiver(uint256 _troveId) internal view {
    (, address receiver) = borrowerOperations.removeManagerReceiverOf(_troveId);
    require(receiver == address(this), "BZ: Zapper is not receiver for this trove");
}
```

## External Calls

- **ITroveNFT::ownerOf(uint256)**
- **IBorrowerOperations::withdrawBold(uint256,uint256,uint256)**
- **IBoldToken::transfer(address,uint256)**

## Native Transfers

- **boldToken** (computed)

## State Variable Reads

- **removeManagerReceiverOf** (`mapping(uint256 => struct AddRemoveManagers.RemoveManagerReceiver)`)
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GasCompZapper.withdrawBold(uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: AddRemoveManagers._requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address) (NodeID: 1)
  │   💬 Args: [_troveId, owner]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseZapper._requireZapperIsReceiver(uint256) (NodeID: 2)
      💬 Args: [_troveId]
      👁️  Def: internal
```
