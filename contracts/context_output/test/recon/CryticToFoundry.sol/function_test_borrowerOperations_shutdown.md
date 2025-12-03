# Function: test_borrowerOperations_shutdown()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_borrowerOperations_shutdown()`
- **Visibility**: public
- **Source Range**: 16992:97:315

## Implementation

```solidity
function test_borrowerOperations_shutdown() public {
    borrowerOperations_shutdown();
}
```

## Related Implementations

### borrowerOperations_shutdown()

- **Kind**: internal
- **Source**: 3351:100:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:borrowerOperations_shutdown()`

```solidity
function borrowerOperations_shutdown() public asAdmin() {
    borrowerOperations.shutdown();
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_borrowerOperations_shutdown() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.borrowerOperations_shutdown() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
