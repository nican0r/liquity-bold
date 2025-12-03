# Function: testOnlyBorrowerOperationsCanCallOnSetBatchManagerAnnualInterestRate()

**Contract**: [test/troveManager.t.sol/contract_TroveManagerTest.md]

## Metadata

- **Contract**: TroveManagerTest
- **Signature**: `testOnlyBorrowerOperationsCanCallOnSetBatchManagerAnnualInterestRate()`
- **Visibility**: public
- **Source Range**: 3948:314:335

## Implementation

```solidity
function testOnlyBorrowerOperationsCanCallOnSetBatchManagerAnnualInterestRate() public {
    vm.startPrank(A);
    vm.expectRevert(TroveManager.CallerNotBorrowerOperations.selector);
    troveManager.onSetBatchManagerAnnualInterestRate(A, 10000e18, 5000e18, 5e14, 100e18);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **ITroveManagerTester::onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256)**
- **Vm::stopPrank()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTest.testOnlyBorrowerOperationsCanCallOnSetBatchManagerAnnualInterestRate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
