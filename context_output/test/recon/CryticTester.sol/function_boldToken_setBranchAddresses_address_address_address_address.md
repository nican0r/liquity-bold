# Function: boldToken_setBranchAddresses(address,address,address,address)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `boldToken_setBranchAddresses(address,address,address,address)`
- **Visibility**: public
- **Source Range**: 2667:316:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function boldToken_setBranchAddresses(address _troveManagerAddress, address _stabilityPoolAddress, address _borrowerOperationsAddress, address _activePoolAddress) public asAdmin() {
    boldToken.setBranchAddresses(_troveManagerAddress, _stabilityPoolAddress, _borrowerOperationsAddress, _activePoolAddress);
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

- **BoldToken::setBranchAddresses(address,address,address,address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.boldToken_setBranchAddresses(address,address,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
