# Function: test_troveManager_urgentRedemption()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_troveManager_urgentRedemption()`
- **Visibility**: public
- **Source Range**: 31996:654:315

## Implementation

```solidity
function test_troveManager_urgentRedemption() public {
    borrowerOperations_openTrove(_getActor(), 0, 10e18, 2000e18, 0, 0, 5e16, 1000e18, address(0), address(0), address(0));
    borrowerOperations_shutdown();
    uint256[] memory troveIds = new uint256[](1);
    troveIds[0] = 0;
    troveManager_urgentRedemption(100e18, troveIds, 1e18);
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

### borrowerOperations_shutdown()

- **Kind**: internal
- **Source**: 3351:100:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:borrowerOperations_shutdown()`

```solidity
function borrowerOperations_shutdown() public asAdmin() {
    borrowerOperations.shutdown();
}
```

### asAdmin()

- **Kind**: modifier
- **Source**: 13885:68:317
- **Link**: `test/recon/Setup.sol:Setup:asAdmin()`

```solidity
/// === MODIFIERS === ///
///  Prank admin and actor
modifier asAdmin() {
    vm.prank(address(this));
    _;
}
```

### troveManager_urgentRedemption(uint256,uint256[],uint256)

- **Kind**: internal
- **Source**: 929:213:330
- **Link**: `test/recon/targets/TroveManagerTargets.sol:TroveManagerTargets:troveManager_urgentRedemption(uint256,uint256[],uint256)`

```solidity
function troveManager_urgentRedemption(uint256 _boldAmount, uint256[] memory _troveIds, uint256 _minCollateral) public asActor() {
    troveManager.urgentRedemption(_boldAmount, _troveIds, _minCollateral);
}
```

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_troveManager_urgentRedemption() (NodeID: 0)
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
  ├─ [1] ⚙️ FUNCTION: AdminTargets.borrowerOperations_shutdown() (NodeID: 5)
  │   💬 Args: [no args]
  │   👁️  Def: public
  │ └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 6)
  │     💬 Args: [no args]
  └─ [1] ⚙️ FUNCTION: TroveManagerTargets.troveManager_urgentRedemption(uint256,uint256[],uint256) (NodeID: 7)
      💬 Args: [100e18, troveIds, 1e18]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 8)
        💬 Args: [no args]
      └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 9)
          💬 Args: [no args]
          👁️  Def: internal
```
