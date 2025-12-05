# Function: troveNFT_safeTransferFrom(address,address,uint256,bytes)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `troveNFT_safeTransferFrom(address,address,uint256,bytes)`
- **Visibility**: public
- **Source Range**: 890:179:331
- **Inherited From**: TroveNFTTargets

## Implementation

```solidity
function troveNFT_safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public asActor() {
    troveNFT.safeTransferFrom(from, to, tokenId, data);
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

- **TroveNFT::safeTransferFrom(address,address,uint256,bytes)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveNFTTargets.troveNFT_safeTransferFrom(address,address,uint256,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
