# Function: addColl(uint256,uint256)

**Contract**: [src/Zappers/LeverageLSTZapper.sol/contract_LeverageLSTZapper.md]

## Metadata

- **Contract**: LeverageLSTZapper
- **Signature**: `addColl(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3851:412:196
- **Inherited From**: GasCompZapper

## Implementation

```solidity
function addColl(uint256 _troveId, uint256 _amount) external {
    address owner = troveNFT.ownerOf(_troveId);
    _requireSenderIsOwnerOrAddManager(_troveId, owner);
    IBorrowerOperations borrowerOperationsCached = borrowerOperations;
    collToken.safeTransferFrom(msg.sender, address(this), _amount);
    borrowerOperationsCached.addColl(_troveId, _amount);
}
```

## Related Implementations

### _requireSenderIsOwnerOrAddManager(uint256,address)

- **Kind**: internal
- **Source**: 3975:504:133
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_requireSenderIsOwnerOrAddManager(uint256,address)`

```solidity
function _requireSenderIsOwnerOrAddManager(uint256 _troveId, address _owner) internal view {
    address addManager = addManagerOf[_troveId];
    if (((msg.sender != _owner) && (addManager != address(0))) && (msg.sender != addManager)) {
        address removeManager = removeManagerReceiverOf[_troveId].manager;
        if (msg.sender != removeManager) {
            revert NotOwnerNorAddManager();
        }
    }
}
```

## External Calls

- **ITroveNFT::ownerOf(uint256)**
- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**
- **IBorrowerOperations::addColl(uint256,uint256)**

## State Variable Reads

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **addManagerOf** (`mapping(uint256 => address)`)
- **removeManagerReceiverOf** (`mapping(uint256 => struct AddRemoveManagers.RemoveManagerReceiver)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GasCompZapper.addColl(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: AddRemoveManagers._requireSenderIsOwnerOrAddManager(uint256,address) (NodeID: 1)
      💬 Args: [_troveId, owner]
      👁️  Def: internal
```
