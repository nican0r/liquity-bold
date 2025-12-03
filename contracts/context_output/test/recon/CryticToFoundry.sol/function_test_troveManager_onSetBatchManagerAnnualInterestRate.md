# Function: test_troveManager_onSetBatchManagerAnnualInterestRate()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_troveManager_onSetBatchManagerAnnualInterestRate()`
- **Visibility**: public
- **Source Range**: 30432:179:315

## Implementation

```solidity
function test_troveManager_onSetBatchManagerAnnualInterestRate() public {
    troveManager_onSetBatchManagerAnnualInterestRate(_getActor(), 10e18, 2000e18, 6e16, 10e18);
}
```

## Related Implementations

### troveManager_onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 9018:322:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:troveManager_onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256)`

```solidity
function troveManager_onSetBatchManagerAnnualInterestRate(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, uint256 _upfrontFee) public asAdmin() {
    troveManager.onSetBatchManagerAnnualInterestRate(_batchAddress, _newColl, _newDebt, _newAnnualInterestRate, _upfrontFee);
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_troveManager_onSetBatchManagerAnnualInterestRate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.troveManager_onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256) (NodeID: 1)
      💬 Args: [_getActor(), 10e18, 2000e18, 6e16, 10e18]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
