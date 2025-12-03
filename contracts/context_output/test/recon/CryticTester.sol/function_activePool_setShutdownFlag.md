# Function: activePool_setShutdownFlag()

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `activePool_setShutdownFlag()`
- **Visibility**: public
- **Source Range**: 1906:98:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function activePool_setShutdownFlag() public asAdmin() {
    activePool.setShutdownFlag();
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

- **ActivePool::setShutdownFlag()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.activePool_setShutdownFlag() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
