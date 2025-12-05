# Function: troveManager_setTroveStatusToActive(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `troveManager_setTroveStatusToActive(uint256)`
- **Visibility**: public
- **Source Range**: 9817:140:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function troveManager_setTroveStatusToActive(uint256 _troveId) public asAdmin() {
    troveManager.setTroveStatusToActive(_troveId);
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

- **TroveManagerTester::setTroveStatusToActive(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.troveManager_setTroveStatusToActive(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
