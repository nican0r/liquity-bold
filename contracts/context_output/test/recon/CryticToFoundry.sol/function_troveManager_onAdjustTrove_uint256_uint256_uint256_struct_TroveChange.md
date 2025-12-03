# Function: troveManager_onAdjustTrove(uint256,uint256,uint256,struct TroveChange)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `troveManager_onAdjustTrove(uint256,uint256,uint256,struct TroveChange)`
- **Visibility**: public
- **Source Range**: 5898:225:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function troveManager_onAdjustTrove(uint256 _troveId, uint256 _newColl, uint256 _newDebt, TroveChange memory _troveChange) public asAdmin() {
    troveManager.onAdjustTrove(_troveId, _newColl, _newDebt, _troveChange);
}
```

## Related Implementations

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

## External Calls

- **TroveManagerTester::onAdjustTrove(uint256,uint256,uint256,struct TroveChange)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.troveManager_onAdjustTrove(uint256,uint256,uint256,struct TroveChange) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
