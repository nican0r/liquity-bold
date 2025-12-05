# Function: testCanSetAddManagerOnOpenTrove()

**Contract**: [test/borrowerOperationsOnBehalfTroveManagament.t.sol/contract_BorrowerOperationsOnBehalfTroveManagamentTest.md]

## Metadata

- **Contract**: BorrowerOperationsOnBehalfTroveManagamentTest
- **Signature**: `testCanSetAddManagerOnOpenTrove()`
- **Visibility**: public
- **Source Range**: 967:663:300

## Implementation

```solidity
function testCanSetAddManagerOnOpenTrove() public {
    vm.startPrank(A);
    uint256 ATroveId = borrowerOperations.openTrove(A, 0, 100 ether, 10000e18, 0, 0, 5e16, 10000e18, B, address(0), address(0));
    vm.stopPrank();
    assertEq(borrowerOperations.addManagerOf(ATroveId), B);
}
```

## Related Implementations

### assertEq(address,address)

- **Kind**: internal
- **Source**: 3454:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address)`

```solidity
function assertEq(address left, address right) virtual internal pure {
    vm.assertEq(left, right);
}
```

## External Calls

- **Vm::startPrank(address)**
- **IBorrowerOperationsTester::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**
- **Vm::stopPrank()**
- **IBorrowerOperationsTester::addManagerOf(uint256)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperationsOnBehalfTroveManagamentTest.testCanSetAddManagerOnOpenTrove() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
      💬 Args: [borrowerOperations.addManagerOf(ATroveId), B]
      👁️  Def: internal
```
