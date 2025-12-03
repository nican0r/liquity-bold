# Function: stabilityPool_triggerBoldRewards(uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `stabilityPool_triggerBoldRewards(uint256)`
- **Visibility**: public
- **Source Range**: 5718:138:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function stabilityPool_triggerBoldRewards(uint256 _boldYield) public asAdmin() {
    stabilityPool.triggerBoldRewards(_boldYield);
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

- **StabilityPool::triggerBoldRewards(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.stabilityPool_triggerBoldRewards(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
