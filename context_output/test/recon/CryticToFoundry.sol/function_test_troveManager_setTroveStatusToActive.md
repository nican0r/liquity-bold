# Function: test_troveManager_setTroveStatusToActive()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_troveManager_setTroveStatusToActive()`
- **Visibility**: public
- **Source Range**: 31785:114:315

## Implementation

```solidity
function test_troveManager_setTroveStatusToActive() public {
    troveManager_setTroveStatusToActive(0);
}
```

## Related Implementations

### troveManager_setTroveStatusToActive(uint256)

- **Kind**: internal
- **Source**: 9817:140:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:troveManager_setTroveStatusToActive(uint256)`

```solidity
function troveManager_setTroveStatusToActive(uint256 _troveId) public asAdmin() {
    troveManager.setTroveStatusToActive(_troveId);
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_troveManager_setTroveStatusToActive() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.troveManager_setTroveStatusToActive(uint256) (NodeID: 1)
      💬 Args: [0]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
