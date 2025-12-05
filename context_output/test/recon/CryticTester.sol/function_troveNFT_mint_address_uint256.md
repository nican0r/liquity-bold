# Function: troveNFT_mint(address,uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `troveNFT_mint(address,uint256)`
- **Visibility**: public
- **Source Range**: 10191:120:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function troveNFT_mint(address _owner, uint256 _troveId) public asAdmin() {
    troveNFT.mint(_owner, _troveId);
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

- **TroveNFT::mint(address,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.troveNFT_mint(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
