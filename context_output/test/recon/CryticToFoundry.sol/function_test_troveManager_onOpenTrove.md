# Function: test_troveManager_onOpenTrove()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_troveManager_onOpenTrove()`
- **Visibility**: public
- **Source Range**: 28218:659:315

## Implementation

```solidity
function test_troveManager_onOpenTrove() public {
    TroveChange memory troveChange = TroveChange({appliedRedistBoldDebtGain: 0, appliedRedistCollGain: 0, collIncrease: 10e18, collDecrease: 0, debtIncrease: 2000e18, debtDecrease: 0, newWeightedRecordedDebt: 2000e18, oldWeightedRecordedDebt: 0, upfrontFee: 0, batchAccruedManagementFee: 0, newWeightedRecordedBatchManagementFee: 0, oldWeightedRecordedBatchManagementFee: 0});
    troveManager_onOpenTrove(_getActor(), 0, troveChange, 5e16);
}
```

## Related Implementations

### troveManager_onOpenTrove(address,uint256,struct TroveChange,uint256)

- **Kind**: internal
- **Source**: 7775:239:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:troveManager_onOpenTrove(address,uint256,struct TroveChange,uint256)`

```solidity
function troveManager_onOpenTrove(address _owner, uint256 _troveId, TroveChange memory _troveChange, uint256 _annualInterestRate) public asAdmin() {
    troveManager.onOpenTrove(_owner, _troveId, _troveChange, _annualInterestRate);
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_troveManager_onOpenTrove() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.troveManager_onOpenTrove(address,uint256,struct TroveChange,uint256) (NodeID: 1)
      💬 Args: [_getActor(), 0, troveChange, 5e16]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
