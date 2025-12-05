# Function: test_stabilityPool_triggerBoldRewards()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_stabilityPool_triggerBoldRewards()`
- **Visibility**: public
- **Source Range**: 23470:113:315

## Implementation

```solidity
function test_stabilityPool_triggerBoldRewards() public {
    stabilityPool_triggerBoldRewards(100e18);
}
```

## Related Implementations

### stabilityPool_triggerBoldRewards(uint256)

- **Kind**: internal
- **Source**: 5718:138:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:stabilityPool_triggerBoldRewards(uint256)`

```solidity
function stabilityPool_triggerBoldRewards(uint256 _boldYield) public asAdmin() {
    stabilityPool.triggerBoldRewards(_boldYield);
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_stabilityPool_triggerBoldRewards() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.stabilityPool_triggerBoldRewards(uint256) (NodeID: 1)
      💬 Args: [100e18]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
