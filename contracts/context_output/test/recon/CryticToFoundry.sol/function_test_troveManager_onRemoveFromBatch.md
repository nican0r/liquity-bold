# Function: test_troveManager_onRemoveFromBatch()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_troveManager_onRemoveFromBatch()`
- **Visibility**: public
- **Source Range**: 29737:689:315

## Implementation

```solidity
function test_troveManager_onRemoveFromBatch() public {
    TroveChange memory troveChange = TroveChange({appliedRedistBoldDebtGain: 0, appliedRedistCollGain: 0, collIncrease: 0, collDecrease: 0, debtIncrease: 0, debtDecrease: 0, newWeightedRecordedDebt: 2000e18, oldWeightedRecordedDebt: 2000e18, upfrontFee: 0, batchAccruedManagementFee: 0, newWeightedRecordedBatchManagementFee: 0, oldWeightedRecordedBatchManagementFee: 0});
    troveManager_onRemoveFromBatch(0, 10e18, 2000e18, troveChange, _getActor(), 0, 0, 5e16);
}
```

## Related Implementations

### troveManager_onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 8589:423:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:troveManager_onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256)`

```solidity
function troveManager_onRemoveFromBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, uint256 _newAnnualInterestRate) public asAdmin() {
    troveManager.onRemoveFromBatch(_troveId, _newTroveColl, _newTroveDebt, _troveChange, _batchAddress, _newBatchColl, _newBatchDebt, _newAnnualInterestRate);
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_troveManager_onRemoveFromBatch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.troveManager_onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256) (NodeID: 1)
      💬 Args: [0, 10e18, 2000e18, troveChange, _getActor(), 0, 0, 5e16]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
