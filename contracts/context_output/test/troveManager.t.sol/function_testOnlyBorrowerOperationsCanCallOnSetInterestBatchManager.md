# Function: testOnlyBorrowerOperationsCanCallOnSetInterestBatchManager()

**Contract**: [test/troveManager.t.sol/contract_TroveManagerTest.md]

## Metadata

- **Contract**: TroveManagerTest
- **Signature**: `testOnlyBorrowerOperationsCanCallOnSetInterestBatchManager()`
- **Visibility**: public
- **Source Range**: 4268:334:335

## Implementation

```solidity
function testOnlyBorrowerOperationsCanCallOnSetInterestBatchManager() public {
    vm.startPrank(A);
    vm.expectRevert(TroveManager.CallerNotBorrowerOperations.selector);
    TroveManager.OnSetInterestBatchManagerParams memory params;
    troveManager.onSetInterestBatchManager(params);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **ITroveManagerTester::onSetInterestBatchManager(struct ITroveManager.OnSetInterestBatchManagerParams)**
- **Vm::stopPrank()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTest.testOnlyBorrowerOperationsCanCallOnSetInterestBatchManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
