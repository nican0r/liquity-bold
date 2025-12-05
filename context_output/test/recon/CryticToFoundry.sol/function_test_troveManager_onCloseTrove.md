# Function: test_troveManager_onCloseTrove()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_troveManager_onCloseTrove()`
- **Visibility**: public
- **Source Range**: 27388:660:315

## Implementation

```solidity
function test_troveManager_onCloseTrove() public {
    TroveChange memory troveChange = TroveChange({appliedRedistBoldDebtGain: 0, appliedRedistCollGain: 0, collIncrease: 0, collDecrease: 10e18, debtIncrease: 0, debtDecrease: 2000e18, newWeightedRecordedDebt: 0, oldWeightedRecordedDebt: 2000e18, upfrontFee: 0, batchAccruedManagementFee: 0, newWeightedRecordedBatchManagementFee: 0, oldWeightedRecordedBatchManagementFee: 0});
    troveManager_onCloseTrove(0, troveChange, address(0), 0, 0);
}
```

## Related Implementations

### troveManager_onCloseTrove(uint256,struct TroveChange,address,uint256,uint256)

- **Kind**: internal
- **Source**: 7206:281:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:troveManager_onCloseTrove(uint256,struct TroveChange,address,uint256,uint256)`

```solidity
function troveManager_onCloseTrove(uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) public asAdmin() {
    troveManager.onCloseTrove(_troveId, _troveChange, _batchAddress, _newBatchColl, _newBatchDebt);
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_troveManager_onCloseTrove() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.troveManager_onCloseTrove(uint256,struct TroveChange,address,uint256,uint256) (NodeID: 1)
      💬 Args: [0, troveChange, address(0), 0, 0]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
