# Function: stabilityPool_withdrawFromSP(uint256,bool)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `stabilityPool_withdrawFromSP(uint256,bool)`
- **Visibility**: public
- **Source Range**: 879:149:329
- **Inherited From**: StabilityPoolTargets

## Implementation

```solidity
function stabilityPool_withdrawFromSP(uint256 _amount, bool _doClaim) public asActor() {
    stabilityPool.withdrawFromSP(_amount, _doClaim);
}
```

## Related Implementations

### asActor()

- **Kind**: modifier
- **Source**: 13959:75:317
- **Link**: `test/recon/Setup.sol:Setup:asActor()`

```solidity
modifier asActor() {
    vm.prank(address(_getActor()));
    _;
}
```

### _getActor()

- **Kind**: internal
- **Source**: 1115:83:104
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActor()`

```solidity
/// @notice Returns the current active actor
function _getActor() internal view returns (address) {
    return _actor;
}
```

## External Calls

- **StabilityPool::withdrawFromSP(uint256,bool)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPoolTargets.stabilityPool_withdrawFromSP(uint256,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
