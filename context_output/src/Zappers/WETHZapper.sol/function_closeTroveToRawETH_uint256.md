# Function: closeTroveToRawETH(uint256)

**Contract**: [src/Zappers/WETHZapper.sol/contract_WETHZapper.md]

## Metadata

- **Contract**: WETHZapper
- **Signature**: `closeTroveToRawETH(uint256)`
- **Visibility**: external
- **Source Range**: 9099:726:226

## Implementation

```solidity
function closeTroveToRawETH(uint256 _troveId) external {
    address owner = troveNFT.ownerOf(_troveId);
    address payable receiver = payable(_requireSenderIsOwnerOrRemoveManagerAndGetReceiver(_troveId, owner));
    _requireZapperIsReceiver(_troveId);
    LatestTroveData memory trove = troveManager.getLatestTroveData(_troveId);
    boldToken.transferFrom(msg.sender, address(this), trove.entireDebt);
    borrowerOperations.closeTrove(_troveId);
    WETH.withdraw(trove.entireColl + ETH_GAS_COMPENSATION);
    (bool success, ) = receiver.call{value: trove.entireColl + ETH_GAS_COMPENSATION}("");
    require(success, "WZ: Sending ETH failed");
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
- **ITroveManager::getLatestTroveData(uint256)**
- **IBoldToken::transferFrom(address,address,uint256)**
- **IBorrowerOperations::closeTrove(uint256)**
- **IWETH::withdraw(uint256)**
- **unknown::unknown**

## State Variable Reads

- **removeManagerReceiverOf** (`mapping(uint256 => struct AddRemoveManagers.RemoveManagerReceiver)`)
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: WETHZapper.closeTroveToRawETH(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: AddRemoveManagers._requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address) (NodeID: 1)
  │   💬 Args: [_troveId, owner]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseZapper._requireZapperIsReceiver(uint256) (NodeID: 2)
      💬 Args: [_troveId]
      👁️  Def: internal
```
