# Function: test_activePool_sendColl()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_activePool_sendColl()`
- **Visibility**: public
- **Source Range**: 2730:98:315

## Implementation

```solidity
function test_activePool_sendColl() public {
    activePool_sendColl(_getActor(), 1e18);
}
```

## Related Implementations

### activePool_sendColl(address,uint256)

- **Kind**: internal
- **Source**: 1628:134:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:activePool_sendColl(address,uint256)`

```solidity
function activePool_sendColl(address _account, uint256 _amount) public asAdmin() {
    activePool.sendColl(_account, _amount);
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_activePool_sendColl() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.activePool_sendColl(address,uint256) (NodeID: 1)
      💬 Args: [_getActor(), 1e18]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
