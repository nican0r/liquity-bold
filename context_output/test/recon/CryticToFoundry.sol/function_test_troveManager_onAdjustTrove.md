# Function: test_troveManager_onAdjustTrove()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_troveManager_onAdjustTrove()`
- **Visibility**: public
- **Source Range**: 24616:659:315

## Implementation

```solidity
function test_troveManager_onAdjustTrove() public {
    TroveChange memory troveChange = TroveChange({appliedRedistBoldDebtGain: 0, appliedRedistCollGain: 0, collIncrease: 1e18, collDecrease: 0, debtIncrease: 1000e18, debtDecrease: 0, newWeightedRecordedDebt: 1000e18, oldWeightedRecordedDebt: 0, upfrontFee: 0, batchAccruedManagementFee: 0, newWeightedRecordedBatchManagementFee: 0, oldWeightedRecordedBatchManagementFee: 0});
    troveManager_onAdjustTrove(0, 10e18, 2000e18, troveChange);
}
```

## Related Implementations

### troveManager_onAdjustTrove(uint256,uint256,uint256,struct TroveChange)

- **Kind**: internal
- **Source**: 5898:225:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:troveManager_onAdjustTrove(uint256,uint256,uint256,struct TroveChange)`

```solidity
function troveManager_onAdjustTrove(uint256 _troveId, uint256 _newColl, uint256 _newDebt, TroveChange memory _troveChange) public asAdmin() {
    troveManager.onAdjustTrove(_troveId, _newColl, _newDebt, _troveChange);
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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_troveManager_onAdjustTrove() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.troveManager_onAdjustTrove(uint256,uint256,uint256,struct TroveChange) (NodeID: 1)
      💬 Args: [0, 10e18, 2000e18, troveChange]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
