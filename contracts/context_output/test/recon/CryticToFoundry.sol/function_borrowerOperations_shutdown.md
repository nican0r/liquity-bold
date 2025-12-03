# Function: borrowerOperations_shutdown()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `borrowerOperations_shutdown()`
- **Visibility**: public
- **Source Range**: 3351:100:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function borrowerOperations_shutdown() public asAdmin() {
    borrowerOperations.shutdown();
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

- **BorrowerOperationsTester::shutdown()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.borrowerOperations_shutdown() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
