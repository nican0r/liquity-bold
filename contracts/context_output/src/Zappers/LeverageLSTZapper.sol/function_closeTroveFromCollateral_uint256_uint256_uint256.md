# Function: closeTroveFromCollateral(uint256,uint256,uint256)

**Contract**: [src/Zappers/LeverageLSTZapper.sol/contract_LeverageLSTZapper.md]

## Metadata

- **Contract**: LeverageLSTZapper
- **Signature**: `closeTroveFromCollateral(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 9422:1144:196
- **Inherited From**: GasCompZapper

## Implementation

```solidity
function closeTroveFromCollateral(uint256 _troveId, uint256 _flashLoanAmount, uint256 _minExpectedCollateral) override external {
    address owner = troveNFT.ownerOf(_troveId);
    address payable receiver = payable(_requireSenderIsOwnerOrRemoveManagerAndGetReceiver(_troveId, owner));
    _requireZapperIsReceiver(_troveId);
    CloseTroveParams memory params = CloseTroveParams({troveId: _troveId, flashLoanAmount: _flashLoanAmount, minExpectedCollateral: _minExpectedCollateral, receiver: receiver});
    InitialBalances memory initialBalances;
    initialBalances.tokens[0] = collToken;
    initialBalances.tokens[1] = boldToken;
    _setInitialBalancesAndReceiver(initialBalances, receiver);
    flashLoanProvider.makeFlashLoan(collToken, _flashLoanAmount, IFlashLoanProvider.Operation.CloseTrove, abi.encode(params));
    _returnLeftovers(initialBalances);
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

### _setInitialBalancesAndReceiver(struct LeftoversSweep.InitialBalances,address)

- **Kind**: internal
- **Source**: 1293:420:204
- **Link**: `src/Zappers/LeftoversSweep.sol:LeftoversSweep:_setInitialBalancesAndReceiver(struct LeftoversSweep.InitialBalances,address)`

```solidity
function _setInitialBalancesAndReceiver(InitialBalances memory _initialBalances, address _receiver) internal view {
    for (uint256 i = 0; i < _initialBalances.tokens.length; i++) {
        if (address(_initialBalances.tokens[i]) == address(0)) break;
        _initialBalances.balances[i] = _initialBalances.tokens[i].balanceOf(address(this));
    }
    _initialBalances.receiver = _receiver;
}
```

### _returnLeftovers(struct LeftoversSweep.InitialBalances)

- **Kind**: internal
- **Source**: 1719:577:204
- **Link**: `src/Zappers/LeftoversSweep.sol:LeftoversSweep:_returnLeftovers(struct LeftoversSweep.InitialBalances)`

```solidity
function _returnLeftovers(InitialBalances memory _initialBalances) internal {
    for (uint256 i = 0; i < _initialBalances.tokens.length; i++) {
        if (address(_initialBalances.tokens[i]) == address(0)) break;
        uint256 currentBalance = _initialBalances.tokens[i].balanceOf(address(this));
        if (currentBalance > _initialBalances.balances[i]) {
            _initialBalances.tokens[i].safeTransfer(_initialBalances.receiver, currentBalance - _initialBalances.balances[i]);
        }
    }
}
```

## External Calls

- **ITroveNFT::ownerOf(uint256)**
- **IFlashLoanProvider::makeFlashLoan(contract IERC20,uint256,enum IFlashLoanProvider.Operation,bytes)**

## State Variable Reads

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **removeManagerReceiverOf** (`mapping(uint256 => struct AddRemoveManagers.RemoveManagerReceiver)`)
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GasCompZapper.closeTroveFromCollateral(uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: AddRemoveManagers._requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address) (NodeID: 1)
  │   💬 Args: [_troveId, owner]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseZapper._requireZapperIsReceiver(uint256) (NodeID: 2)
  │   💬 Args: [_troveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: LeftoversSweep._setInitialBalancesAndReceiver(struct LeftoversSweep.InitialBalances,address) (NodeID: 3)
  │   💬 Args: [initialBalances, receiver]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: LeftoversSweep._returnLeftovers(struct LeftoversSweep.InitialBalances) (NodeID: 4)
      💬 Args: [initialBalances]
      👁️  Def: internal
```
