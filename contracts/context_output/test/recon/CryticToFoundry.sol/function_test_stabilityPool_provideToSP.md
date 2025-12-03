# Function: test_stabilityPool_provideToSP()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_stabilityPool_provideToSP()`
- **Visibility**: public
- **Source Range**: 23357:107:315

## Implementation

```solidity
function test_stabilityPool_provideToSP() public {
    stabilityPool_provideToSP(1000e18, false);
}
```

## Related Implementations

### stabilityPool_provideToSP(uint256,bool)

- **Kind**: internal
- **Source**: 732:141:329
- **Link**: `test/recon/targets/StabilityPoolTargets.sol:StabilityPoolTargets:stabilityPool_provideToSP(uint256,bool)`

```solidity
function stabilityPool_provideToSP(uint256 _topUp, bool _doClaim) public asActor() {
    stabilityPool.provideToSP(_topUp, _doClaim);
}
```

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

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_stabilityPool_provideToSP() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StabilityPoolTargets.stabilityPool_provideToSP(uint256,bool) (NodeID: 1)
      💬 Args: [1000e18, false]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 2)
        💬 Args: [no args]
      └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
          💬 Args: [no args]
          👁️  Def: internal
```
