# Function: test_activePool_mintAggInterestAndAccountForTroveChange()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_activePool_mintAggInterestAndAccountForTroveChange()`
- **Visibility**: public
- **Source Range**: 1083:700:315

## Implementation

```solidity
function test_activePool_mintAggInterestAndAccountForTroveChange() public {
    TroveChange memory troveChange = TroveChange({appliedRedistBoldDebtGain: 0, appliedRedistCollGain: 0, collIncrease: 1e18, collDecrease: 0, debtIncrease: 1000e18, debtDecrease: 0, newWeightedRecordedDebt: 1000e18, oldWeightedRecordedDebt: 0, upfrontFee: 0, batchAccruedManagementFee: 0, newWeightedRecordedBatchManagementFee: 0, oldWeightedRecordedBatchManagementFee: 0});
    activePool_mintAggInterestAndAccountForTroveChange(troveChange, address(0));
}
```

## Related Implementations

### activePool_mintAggInterestAndAccountForTroveChange(struct TroveChange,address)

- **Kind**: internal
- **Source**: 1040:227:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:activePool_mintAggInterestAndAccountForTroveChange(struct TroveChange,address)`

```solidity
function activePool_mintAggInterestAndAccountForTroveChange(TroveChange memory _troveChange, address _batchAddress) public asAdmin() {
    activePool.mintAggInterestAndAccountForTroveChange(_troveChange, _batchAddress);
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_activePool_mintAggInterestAndAccountForTroveChange() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.activePool_mintAggInterestAndAccountForTroveChange(struct TroveChange,address) (NodeID: 1)
      💬 Args: [troveChange, address(0)]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
