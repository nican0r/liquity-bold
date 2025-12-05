# Function: test_troveManager_shutdown()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_troveManager_shutdown()`
- **Visibility**: public
- **Source Range**: 31905:85:315

## Implementation

```solidity
function test_troveManager_shutdown() public {
    troveManager_shutdown();
}
```

## Related Implementations

### troveManager_shutdown()

- **Kind**: internal
- **Source**: 9963:88:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:troveManager_shutdown()`

```solidity
function troveManager_shutdown() public asAdmin() {
    troveManager.shutdown();
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_troveManager_shutdown() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.troveManager_shutdown() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
