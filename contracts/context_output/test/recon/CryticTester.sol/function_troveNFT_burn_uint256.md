# Function: troveNFT_burn(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `troveNFT_burn(uint256)`
- **Visibility**: public
- **Source Range**: 10089:96:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function troveNFT_burn(uint256 _troveId) public asAdmin() {
    troveNFT.burn(_troveId);
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

- **TroveNFT::burn(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.troveNFT_burn(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
