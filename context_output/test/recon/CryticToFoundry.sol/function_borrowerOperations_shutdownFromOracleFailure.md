# Function: borrowerOperations_shutdownFromOracleFailure()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `borrowerOperations_shutdownFromOracleFailure()`
- **Visibility**: public
- **Source Range**: 3457:134:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function borrowerOperations_shutdownFromOracleFailure() public asAdmin() {
    borrowerOperations.shutdownFromOracleFailure();
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

- **BorrowerOperationsTester::shutdownFromOracleFailure()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.borrowerOperations_shutdownFromOracleFailure() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
