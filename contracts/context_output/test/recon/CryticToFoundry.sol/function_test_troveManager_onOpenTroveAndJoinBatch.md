# Function: test_troveManager_onOpenTroveAndJoinBatch()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_troveManager_onOpenTroveAndJoinBatch()`
- **Visibility**: public
- **Source Range**: 28883:706:315

## Implementation

```solidity
function test_troveManager_onOpenTroveAndJoinBatch() public {
    TroveChange memory troveChange = TroveChange({appliedRedistBoldDebtGain: 0, appliedRedistCollGain: 0, collIncrease: 10e18, collDecrease: 0, debtIncrease: 2000e18, debtDecrease: 0, newWeightedRecordedDebt: 2000e18, oldWeightedRecordedDebt: 0, upfrontFee: 0, batchAccruedManagementFee: 0, newWeightedRecordedBatchManagementFee: 0, oldWeightedRecordedBatchManagementFee: 0});
    troveManager_onOpenTroveAndJoinBatch(_getActor(), 0, troveChange, _getActor(), 10e18, 2000e18);
}
```

## Related Implementations

### troveManager_onOpenTroveAndJoinBatch(address,uint256,struct TroveChange,address,uint256,uint256)

- **Kind**: internal
- **Source**: 8020:315:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:troveManager_onOpenTroveAndJoinBatch(address,uint256,struct TroveChange,address,uint256,uint256)`

```solidity
function troveManager_onOpenTroveAndJoinBatch(address _owner, uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _batchColl, uint256 _batchDebt) public asAdmin() {
    troveManager.onOpenTroveAndJoinBatch(_owner, _troveId, _troveChange, _batchAddress, _batchColl, _batchDebt);
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_troveManager_onOpenTroveAndJoinBatch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.troveManager_onOpenTroveAndJoinBatch(address,uint256,struct TroveChange,address,uint256,uint256) (NodeID: 1)
      💬 Args: [_getActor(), 0, troveChange, _getActor(), 10e18, 2000e18]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 4)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
