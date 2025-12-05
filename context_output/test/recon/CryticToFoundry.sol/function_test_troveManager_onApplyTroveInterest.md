# Function: test_troveManager_onApplyTroveInterest()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_troveManager_onApplyTroveInterest()`
- **Visibility**: public
- **Source Range**: 26689:693:315

## Implementation

```solidity
function test_troveManager_onApplyTroveInterest() public {
    TroveChange memory troveChange = TroveChange({appliedRedistBoldDebtGain: 0, appliedRedistCollGain: 0, collIncrease: 0, collDecrease: 0, debtIncrease: 100e18, debtDecrease: 0, newWeightedRecordedDebt: 1100e18, oldWeightedRecordedDebt: 1000e18, upfrontFee: 0, batchAccruedManagementFee: 0, newWeightedRecordedBatchManagementFee: 0, oldWeightedRecordedBatchManagementFee: 0});
    troveManager_onApplyTroveInterest(0, 10e18, 2100e18, address(0), 0, 0, troveChange);
}
```

## Related Implementations

### troveManager_onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange)

- **Kind**: internal
- **Source**: 6827:373:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:troveManager_onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange)`

```solidity
function troveManager_onApplyTroveInterest(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, TroveChange memory _troveChange) public asAdmin() {
    troveManager.onApplyTroveInterest(_troveId, _newTroveColl, _newTroveDebt, _batchAddress, _newBatchColl, _newBatchDebt, _troveChange);
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_troveManager_onApplyTroveInterest() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.troveManager_onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange) (NodeID: 1)
      💬 Args: [0, 10e18, 2100e18, address(0), 0, 0, troveChange]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
