# Function: troveManager_onOpenTrove(address,uint256,struct TroveChange,uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `troveManager_onOpenTrove(address,uint256,struct TroveChange,uint256)`
- **Visibility**: public
- **Source Range**: 7775:239:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function troveManager_onOpenTrove(address _owner, uint256 _troveId, TroveChange memory _troveChange, uint256 _annualInterestRate) public asAdmin() {
    troveManager.onOpenTrove(_owner, _troveId, _troveChange, _annualInterestRate);
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

- **TroveManagerTester::onOpenTrove(address,uint256,struct TroveChange,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.troveManager_onOpenTrove(address,uint256,struct TroveChange,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
