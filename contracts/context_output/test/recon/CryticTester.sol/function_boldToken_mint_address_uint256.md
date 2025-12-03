# Function: boldToken_mint(address,uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `boldToken_mint(address,uint256)`
- **Visibility**: public
- **Source Range**: 2173:124:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function boldToken_mint(address _account, uint256 _amount) public asAdmin() {
    boldToken.mint(_account, _amount);
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

- **BoldToken::mint(address,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.boldToken_mint(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
