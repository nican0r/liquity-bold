# Function: troveManager_onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `troveManager_onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange)`
- **Visibility**: public
- **Source Range**: 6516:305:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function troveManager_onAdjustTroveInterestRate(uint256 _troveId, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, TroveChange memory _troveChange) public asAdmin() {
    troveManager.onAdjustTroveInterestRate(_troveId, _newColl, _newDebt, _newAnnualInterestRate, _troveChange);
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

- **TroveManagerTester::onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.troveManager_onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
