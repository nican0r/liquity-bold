# Function: activePool_sendCollToDefaultPool(uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `activePool_sendCollToDefaultPool(uint256)`
- **Visibility**: public
- **Source Range**: 1768:132:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function activePool_sendCollToDefaultPool(uint256 _amount) public asAdmin() {
    activePool.sendCollToDefaultPool(_amount);
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

- **ActivePool::sendCollToDefaultPool(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.activePool_sendCollToDefaultPool(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
