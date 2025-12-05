# Function: testOnlyBorrowerOperationsCanCallOnLowerBatchManagerAnnualFee()

**Contract**: [test/troveManager.t.sol/contract_TroveManagerTest.md]

## Metadata

- **Contract**: TroveManagerTest
- **Signature**: `testOnlyBorrowerOperationsCanCallOnLowerBatchManagerAnnualFee()`
- **Visibility**: public
- **Source Range**: 3650:292:335

## Implementation

```solidity
function testOnlyBorrowerOperationsCanCallOnLowerBatchManagerAnnualFee() public {
    vm.startPrank(A);
    vm.expectRevert(TroveManager.CallerNotBorrowerOperations.selector);
    troveManager.onLowerBatchManagerAnnualFee(A, 10000e18, 5000e18, 5e14);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **ITroveManagerTester::onLowerBatchManagerAnnualFee(address,uint256,uint256,uint256)**
- **Vm::stopPrank()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTest.testOnlyBorrowerOperationsCanCallOnLowerBatchManagerAnnualFee() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
