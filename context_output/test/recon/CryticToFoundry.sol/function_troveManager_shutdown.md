# Function: troveManager_shutdown()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `troveManager_shutdown()`
- **Visibility**: public
- **Source Range**: 9963:88:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function troveManager_shutdown() public asAdmin() {
    troveManager.shutdown();
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

- **TroveManagerTester::shutdown()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.troveManager_shutdown() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
