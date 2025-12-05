# Function: test_borrowerOperations_adjustTrove()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_borrowerOperations_adjustTrove()`
- **Visibility**: public
- **Source Range**: 5695:472:315

## Implementation

```solidity
function test_borrowerOperations_adjustTrove() public {
    borrowerOperations_openTrove(_getActor(), 0, 10e18, 2000e18, 0, 0, 5e16, 1000e18, address(0), address(0), address(0));
    borrowerOperations_adjustTrove(0, 1e18, true, 100e18, true, 100e18);
}
```

## Related Implementations

### borrowerOperations_openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)

- **Kind**: internal
- **Source**: 2688:482:322
- **Link**: `test/recon/targets/BorrowerOperationsTargets.sol:BorrowerOperationsTargets:borrowerOperations_openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)`

```solidity
function borrowerOperations_openTrove(address _owner, uint256 _ownerIndex, uint256 _collAmount, uint256 _boldAmount, uint256 _upperHint, uint256 _lowerHint, uint256 _annualInterestRate, uint256 _maxUpfrontFee, address _addManager, address _removeManager, address _receiver) public asActor() {
    borrowerOperations.openTrove(_owner, _ownerIndex, _collAmount, _boldAmount, _upperHint, _lowerHint, _annualInterestRate, _maxUpfrontFee, _addManager, _removeManager, _receiver);
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

### borrowerOperations_adjustTrove(uint256,uint256,bool,uint256,bool,uint256)

- **Kind**: internal
- **Source**: 790:316:322
- **Link**: `test/recon/targets/BorrowerOperationsTargets.sol:BorrowerOperationsTargets:borrowerOperations_adjustTrove(uint256,uint256,bool,uint256,bool,uint256)`

```solidity
function borrowerOperations_adjustTrove(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _maxUpfrontFee) public asActor() {
    borrowerOperations.adjustTrove(_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, _maxUpfrontFee);
}
```

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_borrowerOperations_adjustTrove() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BorrowerOperationsTargets.borrowerOperations_openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address) (NodeID: 1)
  │   💬 Args: [_getActor(), 0, 10e18, 2000e18, 0, 0, 5e16, 1000e18, address(0), address(0), address(0)]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 4)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 2)
  │     💬 Args: [no args]
  │   └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BorrowerOperationsTargets.borrowerOperations_adjustTrove(uint256,uint256,bool,uint256,bool,uint256) (NodeID: 5)
      💬 Args: [0, 1e18, true, 100e18, true, 100e18]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 6)
        💬 Args: [no args]
      └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 7)
          💬 Args: [no args]
          👁️  Def: internal
```
