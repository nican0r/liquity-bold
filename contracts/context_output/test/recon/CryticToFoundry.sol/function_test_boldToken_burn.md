# Function: test_boldToken_burn()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_boldToken_burn()`
- **Visibility**: public
- **Source Range**: 3212:205:315

## Implementation

```solidity
function test_boldToken_burn() public {
    boldToken_mint(_getActor(), 1000e18);
    boldToken_burn(_getActor(), 500e18);
}
```

## Related Implementations

### boldToken_mint(address,uint256)

- **Kind**: internal
- **Source**: 2173:124:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:boldToken_mint(address,uint256)`

```solidity
function boldToken_mint(address _account, uint256 _amount) public asAdmin() {
    boldToken.mint(_account, _amount);
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

### boldToken_burn(address,uint256)

- **Kind**: internal
- **Source**: 2043:124:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:boldToken_burn(address,uint256)`

```solidity
function boldToken_burn(address _account, uint256 _amount) public asAdmin() {
    boldToken.burn(_account, _amount);
}
```

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_boldToken_burn() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AdminTargets.boldToken_mint(address,uint256) (NodeID: 1)
  │   💬 Args: [_getActor(), 1000e18]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
  │     💬 Args: [no args]
  └─ [1] ⚙️ FUNCTION: AdminTargets.boldToken_burn(address,uint256) (NodeID: 4)
      💬 Args: [_getActor(), 500e18]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 6)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 5)
        💬 Args: [no args]
```
