# Function: borrowerOperations_onLiquidateTrove(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `borrowerOperations_onLiquidateTrove(uint256)`
- **Visibility**: public
- **Source Range**: 3205:140:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function borrowerOperations_onLiquidateTrove(uint256 _troveId) public asAdmin() {
    borrowerOperations.onLiquidateTrove(_troveId);
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

- **BorrowerOperationsTester::onLiquidateTrove(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.borrowerOperations_onLiquidateTrove(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
