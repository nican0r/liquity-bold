# Function: testOnlyBorrowerOperationsCanCallOnRegisterBatchManager()

**Contract**: [test/troveManager.t.sol/contract_TroveManagerTest.md]

## Metadata

- **Contract**: TroveManagerTest
- **Signature**: `testOnlyBorrowerOperationsCanCallOnRegisterBatchManager()`
- **Visibility**: public
- **Source Range**: 3377:267:335

## Implementation

```solidity
function testOnlyBorrowerOperationsCanCallOnRegisterBatchManager() public {
    vm.startPrank(A);
    vm.expectRevert(TroveManager.CallerNotBorrowerOperations.selector);
    troveManager.onRegisterBatchManager(A, 5e16, 5e14);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **ITroveManagerTester::onRegisterBatchManager(address,uint256,uint256)**
- **Vm::stopPrank()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTest.testOnlyBorrowerOperationsCanCallOnRegisterBatchManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
