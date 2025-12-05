# Function: test_borrowerOperations_shutdownFromOracleFailure()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_borrowerOperations_shutdownFromOracleFailure()`
- **Visibility**: public
- **Source Range**: 17095:131:315

## Implementation

```solidity
function test_borrowerOperations_shutdownFromOracleFailure() public {
    borrowerOperations_shutdownFromOracleFailure();
}
```

## Related Implementations

### borrowerOperations_shutdownFromOracleFailure()

- **Kind**: internal
- **Source**: 3457:134:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:borrowerOperations_shutdownFromOracleFailure()`

```solidity
function borrowerOperations_shutdownFromOracleFailure() public asAdmin() {
    borrowerOperations.shutdownFromOracleFailure();
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_borrowerOperations_shutdownFromOracleFailure() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.borrowerOperations_shutdownFromOracleFailure() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
