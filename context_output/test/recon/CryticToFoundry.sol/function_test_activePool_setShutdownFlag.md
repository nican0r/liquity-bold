# Function: test_activePool_setShutdownFlag()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_activePool_setShutdownFlag()`
- **Visibility**: public
- **Source Range**: 2951:95:315

## Implementation

```solidity
function test_activePool_setShutdownFlag() public {
    activePool_setShutdownFlag();
}
```

## Related Implementations

### activePool_setShutdownFlag()

- **Kind**: internal
- **Source**: 1906:98:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:activePool_setShutdownFlag()`

```solidity
function activePool_setShutdownFlag() public asAdmin() {
    activePool.setShutdownFlag();
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_activePool_setShutdownFlag() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.activePool_setShutdownFlag() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
