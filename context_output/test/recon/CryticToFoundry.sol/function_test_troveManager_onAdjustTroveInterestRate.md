# Function: test_troveManager_onAdjustTroveInterestRate()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_troveManager_onAdjustTroveInterestRate()`
- **Visibility**: public
- **Source Range**: 25997:686:315

## Implementation

```solidity
function test_troveManager_onAdjustTroveInterestRate() public {
    TroveChange memory troveChange = TroveChange({appliedRedistBoldDebtGain: 0, appliedRedistCollGain: 0, collIncrease: 0, collDecrease: 0, debtIncrease: 0, debtDecrease: 0, newWeightedRecordedDebt: 1000e18, oldWeightedRecordedDebt: 1000e18, upfrontFee: 0, batchAccruedManagementFee: 0, newWeightedRecordedBatchManagementFee: 0, oldWeightedRecordedBatchManagementFee: 0});
    troveManager_onAdjustTroveInterestRate(0, 10e18, 2000e18, 6e16, troveChange);
}
```

## Related Implementations

### troveManager_onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange)

- **Kind**: internal
- **Source**: 6516:305:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:troveManager_onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange)`

```solidity
function troveManager_onAdjustTroveInterestRate(uint256 _troveId, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, TroveChange memory _troveChange) public asAdmin() {
    troveManager.onAdjustTroveInterestRate(_troveId, _newColl, _newDebt, _newAnnualInterestRate, _troveChange);
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_troveManager_onAdjustTroveInterestRate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.troveManager_onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange) (NodeID: 1)
      💬 Args: [0, 10e18, 2000e18, 6e16, troveChange]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
