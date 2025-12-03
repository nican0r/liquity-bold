# Function: borrowerOperations_adjustZombieTrove(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `borrowerOperations_adjustZombieTrove(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 1432:392:322
- **Inherited From**: BorrowerOperationsTargets

## Implementation

```solidity
function borrowerOperations_adjustZombieTrove(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public asActor() {
    borrowerOperations.adjustZombieTrove(_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, _upperHint, _lowerHint, _maxUpfrontFee);
}
```

## Related Implementations

### asActor()

- **Kind**: modifier
- **Source**: 13959:75:317
- **Link**: `test/recon/Setup.sol:Setup:asActor()`

```solidity
modifier asActor() {
    vm.prank(address(_getActor()));
    _;
}
```

### _getActor()

- **Kind**: internal
- **Source**: 1115:83:104
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActor()`

```solidity
/// @notice Returns the current active actor
function _getActor() internal view returns (address) {
    return _actor;
}
```

## External Calls

- **BorrowerOperationsTester::adjustZombieTrove(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperationsTargets.borrowerOperations_adjustZombieTrove(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
