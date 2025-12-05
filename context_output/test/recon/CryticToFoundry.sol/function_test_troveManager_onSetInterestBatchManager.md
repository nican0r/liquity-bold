# Function: test_troveManager_onSetInterestBatchManager()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_troveManager_onSetInterestBatchManager()`
- **Visibility**: public
- **Source Range**: 30617:1017:315

## Implementation

```solidity
function test_troveManager_onSetInterestBatchManager() public {
    ITroveManager.OnSetInterestBatchManagerParams memory params = ITroveManager.OnSetInterestBatchManagerParams({troveId: 0, troveColl: 10e18, troveDebt: 2000e18, troveChange: TroveChange({appliedRedistBoldDebtGain: 0, appliedRedistCollGain: 0, collIncrease: 0, collDecrease: 0, debtIncrease: 0, debtDecrease: 0, newWeightedRecordedDebt: 2000e18, oldWeightedRecordedDebt: 2000e18, upfrontFee: 0, batchAccruedManagementFee: 0, newWeightedRecordedBatchManagementFee: 0, oldWeightedRecordedBatchManagementFee: 0}), newBatchAddress: _getActor(), newBatchColl: 10e18, newBatchDebt: 2000e18});
    troveManager_onSetInterestBatchManager(params);
}
```

## Related Implementations

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

### troveManager_onSetInterestBatchManager(struct ITroveManager.OnSetInterestBatchManagerParams)

- **Kind**: internal
- **Source**: 9346:189:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:troveManager_onSetInterestBatchManager(struct ITroveManager.OnSetInterestBatchManagerParams)`

```solidity
function troveManager_onSetInterestBatchManager(ITroveManager.OnSetInterestBatchManagerParams memory _params) public asAdmin() {
    troveManager.onSetInterestBatchManager(_params);
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_troveManager_onSetInterestBatchManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: AdminTargets.troveManager_onSetInterestBatchManager(struct ITroveManager.OnSetInterestBatchManagerParams) (NodeID: 2)
      💬 Args: [params]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 3)
        💬 Args: [no args]
```
