# Function: stabilityPool_provideToSP(uint256,bool)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `stabilityPool_provideToSP(uint256,bool)`
- **Visibility**: public
- **Source Range**: 732:141:329
- **Inherited From**: StabilityPoolTargets

## Implementation

```solidity
function stabilityPool_provideToSP(uint256 _topUp, bool _doClaim) public asActor() {
    stabilityPool.provideToSP(_topUp, _doClaim);
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

- **StabilityPool::provideToSP(uint256,bool)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPoolTargets.stabilityPool_provideToSP(uint256,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
