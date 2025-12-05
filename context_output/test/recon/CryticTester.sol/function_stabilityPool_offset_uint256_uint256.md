# Function: stabilityPool_offset(uint256,uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `stabilityPool_offset(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 5560:152:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function stabilityPool_offset(uint256 _debtToOffset, uint256 _collToAdd) public asAdmin() {
    stabilityPool.offset(_debtToOffset, _collToAdd);
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

- **StabilityPool::offset(uint256,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.stabilityPool_offset(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
