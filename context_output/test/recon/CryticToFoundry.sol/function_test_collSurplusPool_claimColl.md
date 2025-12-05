# Function: test_collSurplusPool_claimColl()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_collSurplusPool_claimColl()`
- **Visibility**: public
- **Source Range**: 19645:227:315

## Implementation

```solidity
function test_collSurplusPool_claimColl() public {
    collSurplusPool_accountSurplus(_getActor(), 1e18);
    collSurplusPool_claimColl(_getActor());
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

### collSurplusPool_claimColl(address)

- **Kind**: internal
- **Source**: 622:120:323
- **Link**: `test/recon/targets/CollSurplusPoolTargets.sol:CollSurplusPoolTargets:collSurplusPool_claimColl(address)`

```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function collSurplusPool_claimColl(address _account) public asActor() {
    collSurplusPool.claimColl(_account);
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

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_collSurplusPool_claimColl() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AdminTargets.collSurplusPool_accountSurplus(address,uint256) (NodeID: 1)
  │   💬 Args: [_getActor(), 1e18]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
  │     💬 Args: [no args]
  └─ [1] ⚙️ FUNCTION: CollSurplusPoolTargets.collSurplusPool_claimColl(address) (NodeID: 4)
      💬 Args: [_getActor()]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 7)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 5)
        💬 Args: [no args]
      └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 6)
          💬 Args: [no args]
          👁️  Def: internal
```
