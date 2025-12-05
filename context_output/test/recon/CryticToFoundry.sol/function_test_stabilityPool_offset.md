# Function: test_stabilityPool_offset()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_stabilityPool_offset()`
- **Visibility**: public
- **Source Range**: 23147:204:315

## Implementation

```solidity
function test_stabilityPool_offset() public {
    stabilityPool_provideToSP(1000e18, false);
    stabilityPool_offset(100e18, 1e18);
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

### stabilityPool_offset(uint256,uint256)

- **Kind**: internal
- **Source**: 5560:152:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:stabilityPool_offset(uint256,uint256)`

```solidity
function stabilityPool_offset(uint256 _debtToOffset, uint256 _collToAdd) public asAdmin() {
    stabilityPool.offset(_debtToOffset, _collToAdd);
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

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_stabilityPool_offset() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StabilityPoolTargets.stabilityPool_provideToSP(uint256,bool) (NodeID: 1)
  │   💬 Args: [1000e18, false]
  │   👁️  Def: public
  │ └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 2)
  │     💬 Args: [no args]
  │   └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: AdminTargets.stabilityPool_offset(uint256,uint256) (NodeID: 4)
      💬 Args: [100e18, 1e18]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 5)
        💬 Args: [no args]
```
