# Function: boldToken_setCollateralRegistry(address)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `boldToken_setCollateralRegistry(address)`
- **Visibility**: public
- **Source Range**: 2989:168:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function boldToken_setCollateralRegistry(address _collateralRegistryAddress) public asAdmin() {
    boldToken.setCollateralRegistry(_collateralRegistryAddress);
}
```

## Related Implementations

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

## External Calls

- **BoldToken::setCollateralRegistry(address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.boldToken_setCollateralRegistry(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
