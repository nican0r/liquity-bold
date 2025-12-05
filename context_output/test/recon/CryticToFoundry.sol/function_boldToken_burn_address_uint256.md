# Function: boldToken_burn(address,uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `boldToken_burn(address,uint256)`
- **Visibility**: public
- **Source Range**: 2043:124:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function boldToken_burn(address _account, uint256 _amount) public asAdmin() {
    boldToken.burn(_account, _amount);
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

- **BoldToken::burn(address,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.boldToken_burn(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
