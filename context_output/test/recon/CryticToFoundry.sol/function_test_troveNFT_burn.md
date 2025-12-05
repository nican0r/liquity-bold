# Function: test_troveNFT_burn()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_troveNFT_burn()`
- **Visibility**: public
- **Source Range**: 32903:166:315

## Implementation

```solidity
function test_troveNFT_burn() public {
    troveNFT_mint(_getActor(), 0);
    troveNFT_burn(0);
}
```

## Related Implementations

### troveNFT_mint(address,uint256)

- **Kind**: internal
- **Source**: 10191:120:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:troveNFT_mint(address,uint256)`

```solidity
function troveNFT_mint(address _owner, uint256 _troveId) public asAdmin() {
    troveNFT.mint(_owner, _troveId);
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

### troveNFT_burn(uint256)

- **Kind**: internal
- **Source**: 10089:96:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:troveNFT_burn(uint256)`

```solidity
function troveNFT_burn(uint256 _troveId) public asAdmin() {
    troveNFT.burn(_troveId);
}
```

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_troveNFT_burn() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AdminTargets.troveNFT_mint(address,uint256) (NodeID: 1)
  │   💬 Args: [_getActor(), 0]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
  │     💬 Args: [no args]
  └─ [1] ⚙️ FUNCTION: AdminTargets.troveNFT_burn(uint256) (NodeID: 4)
      💬 Args: [0]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 5)
        💬 Args: [no args]
```
