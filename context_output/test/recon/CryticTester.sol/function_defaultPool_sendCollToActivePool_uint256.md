# Function: defaultPool_sendCollToActivePool(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `defaultPool_sendCollToActivePool(uint256)`
- **Visibility**: public
- **Source Range**: 4213:132:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function defaultPool_sendCollToActivePool(uint256 _amount) public asAdmin() {
    defaultPool.sendCollToActivePool(_amount);
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

- **DefaultPool::sendCollToActivePool(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.defaultPool_sendCollToActivePool(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
