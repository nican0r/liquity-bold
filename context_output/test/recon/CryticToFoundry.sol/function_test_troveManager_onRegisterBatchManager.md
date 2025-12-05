# Function: test_troveManager_onRegisterBatchManager()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_troveManager_onRegisterBatchManager()`
- **Visibility**: public
- **Source Range**: 29595:136:315

## Implementation

```solidity
function test_troveManager_onRegisterBatchManager() public {
    troveManager_onRegisterBatchManager(_getActor(), 5e16, 1e16);
}
```

## Related Implementations

### troveManager_onRegisterBatchManager(address,uint256,uint256)

- **Kind**: internal
- **Source**: 8341:242:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:troveManager_onRegisterBatchManager(address,uint256,uint256)`

```solidity
function troveManager_onRegisterBatchManager(address _account, uint256 _annualInterestRate, uint256 _annualManagementFee) public asAdmin() {
    troveManager.onRegisterBatchManager(_account, _annualInterestRate, _annualManagementFee);
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

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_troveManager_onRegisterBatchManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.troveManager_onRegisterBatchManager(address,uint256,uint256) (NodeID: 1)
      💬 Args: [_getActor(), 5e16, 1e16]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
