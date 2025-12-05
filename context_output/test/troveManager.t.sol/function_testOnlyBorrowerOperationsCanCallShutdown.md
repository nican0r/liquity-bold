# Function: testOnlyBorrowerOperationsCanCallShutdown()

**Contract**: [test/troveManager.t.sol/contract_TroveManagerTest.md]

## Metadata

- **Contract**: TroveManagerTest
- **Signature**: `testOnlyBorrowerOperationsCanCallShutdown()`
- **Visibility**: public
- **Source Range**: 412:226:335

## Implementation

```solidity
function testOnlyBorrowerOperationsCanCallShutdown() public {
    vm.startPrank(A);
    vm.expectRevert(TroveManager.CallerNotBorrowerOperations.selector);
    troveManager.shutdown();
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **ITroveManagerTester::shutdown()**
- **Vm::stopPrank()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTest.testOnlyBorrowerOperationsCanCallShutdown() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
