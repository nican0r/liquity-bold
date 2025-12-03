# Function: test_boldToken_setBranchAddresses()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_boldToken_setBranchAddresses()`
- **Visibility**: public
- **Source Range**: 4441:252:315

## Implementation

```solidity
function test_boldToken_setBranchAddresses() public {
    boldToken_setBranchAddresses(address(troveManager), address(stabilityPool), address(borrowerOperations), address(activePool));
}
```

## Related Implementations

### boldToken_setBranchAddresses(address,address,address,address)

- **Kind**: internal
- **Source**: 2667:316:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:boldToken_setBranchAddresses(address,address,address,address)`

```solidity
function boldToken_setBranchAddresses(address _troveManagerAddress, address _stabilityPoolAddress, address _borrowerOperationsAddress, address _activePoolAddress) public asAdmin() {
    boldToken.setBranchAddresses(_troveManagerAddress, _stabilityPoolAddress, _borrowerOperationsAddress, _activePoolAddress);
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_boldToken_setBranchAddresses() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.boldToken_setBranchAddresses(address,address,address,address) (NodeID: 1)
      💬 Args: [address(troveManager), address(stabilityPool), address(borrowerOperations), address(activePool)]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
