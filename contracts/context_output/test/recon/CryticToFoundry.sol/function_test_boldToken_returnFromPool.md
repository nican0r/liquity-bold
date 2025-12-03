# Function: test_boldToken_returnFromPool()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_boldToken_returnFromPool()`
- **Visibility**: public
- **Source Range**: 4020:282:315

## Implementation

```solidity
function test_boldToken_returnFromPool() public {
    boldToken_sendToPool(_getActor(), address(stabilityPool), 1000e18);
    boldToken_returnFromPool(address(stabilityPool), _getActor(), 500e18);
}
```

## Related Implementations

### boldToken_sendToPool(address,address,uint256)

- **Kind**: internal
- **Source**: 2491:170:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:boldToken_sendToPool(address,address,uint256)`

```solidity
function boldToken_sendToPool(address _sender, address _poolAddress, uint256 _amount) public asAdmin() {
    boldToken.sendToPool(_sender, _poolAddress, _amount);
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

### boldToken_returnFromPool(address,address,uint256)

- **Kind**: internal
- **Source**: 2303:182:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:boldToken_returnFromPool(address,address,uint256)`

```solidity
function boldToken_returnFromPool(address _poolAddress, address _receiver, uint256 _amount) public asAdmin() {
    boldToken.returnFromPool(_poolAddress, _receiver, _amount);
}
```

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_boldToken_returnFromPool() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AdminTargets.boldToken_sendToPool(address,address,uint256) (NodeID: 1)
  │   💬 Args: [_getActor(), address(stabilityPool), 1000e18]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
  │     💬 Args: [no args]
  └─ [1] ⚙️ FUNCTION: AdminTargets.boldToken_returnFromPool(address,address,uint256) (NodeID: 4)
      💬 Args: [address(stabilityPool), _getActor(), 500e18]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 6)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 5)
        💬 Args: [no args]
```
