# Function: troveManager_onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `troveManager_onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 9018:322:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function troveManager_onSetBatchManagerAnnualInterestRate(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, uint256 _upfrontFee) public asAdmin() {
    troveManager.onSetBatchManagerAnnualInterestRate(_batchAddress, _newColl, _newDebt, _newAnnualInterestRate, _upfrontFee);
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

- **TroveManagerTester::onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.troveManager_onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
