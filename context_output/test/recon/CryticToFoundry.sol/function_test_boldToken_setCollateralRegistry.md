# Function: test_boldToken_setCollateralRegistry()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_boldToken_setCollateralRegistry()`
- **Visibility**: public
- **Source Range**: 4699:132:315

## Implementation

```solidity
function test_boldToken_setCollateralRegistry() public {
    boldToken_setCollateralRegistry(address(collateralRegistry));
}
```

## Related Implementations

### boldToken_setCollateralRegistry(address)

- **Kind**: internal
- **Source**: 2989:168:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:boldToken_setCollateralRegistry(address)`

```solidity
function boldToken_setCollateralRegistry(address _collateralRegistryAddress) public asAdmin() {
    boldToken.setCollateralRegistry(_collateralRegistryAddress);
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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_boldToken_setCollateralRegistry() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.boldToken_setCollateralRegistry(address) (NodeID: 1)
      💬 Args: [address(collateralRegistry)]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
