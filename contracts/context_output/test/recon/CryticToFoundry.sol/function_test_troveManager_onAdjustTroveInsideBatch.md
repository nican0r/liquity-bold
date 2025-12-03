# Function: test_troveManager_onAdjustTroveInsideBatch()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_troveManager_onAdjustTroveInsideBatch()`
- **Visibility**: public
- **Source Range**: 25281:710:315

## Implementation

```solidity
function test_troveManager_onAdjustTroveInsideBatch() public {
    TroveChange memory troveChange = TroveChange({appliedRedistBoldDebtGain: 0, appliedRedistCollGain: 0, collIncrease: 1e18, collDecrease: 0, debtIncrease: 1000e18, debtDecrease: 0, newWeightedRecordedDebt: 1000e18, oldWeightedRecordedDebt: 0, upfrontFee: 0, batchAccruedManagementFee: 0, newWeightedRecordedBatchManagementFee: 0, oldWeightedRecordedBatchManagementFee: 0});
    troveManager_onAdjustTroveInsideBatch(0, 10e18, 2000e18, troveChange, _getActor(), 10e18, 2000e18);
}
```

## Related Implementations

### troveManager_onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256)

- **Kind**: internal
- **Source**: 6129:381:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:troveManager_onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256)`

```solidity
function troveManager_onAdjustTroveInsideBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) public asAdmin() {
    troveManager.onAdjustTroveInsideBatch(_troveId, _newTroveColl, _newTroveDebt, _troveChange, _batchAddress, _newBatchColl, _newBatchDebt);
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_troveManager_onAdjustTroveInsideBatch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.troveManager_onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256) (NodeID: 1)
      💬 Args: [0, 10e18, 2000e18, troveChange, _getActor(), 10e18, 2000e18]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
