# Function: test_collSurplusPool_accountSurplus()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_collSurplusPool_accountSurplus()`
- **Visibility**: public
- **Source Range**: 19519:120:315

## Implementation

```solidity
function test_collSurplusPool_accountSurplus() public {
    collSurplusPool_accountSurplus(_getActor(), 1e18);
}
```

## Related Implementations

### collSurplusPool_accountSurplus(address,uint256)

- **Kind**: internal
- **Source**: 3636:156:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:collSurplusPool_accountSurplus(address,uint256)`

```solidity
function collSurplusPool_accountSurplus(address _account, uint256 _amount) public asAdmin() {
    collSurplusPool.accountSurplus(_account, _amount);
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_collSurplusPool_accountSurplus() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.collSurplusPool_accountSurplus(address,uint256) (NodeID: 1)
      💬 Args: [_getActor(), 1e18]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
