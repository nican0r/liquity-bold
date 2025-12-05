# Function: testCanSetRemoveManagerWithRemoveManagerAsReceiverOnOpenTrove()

**Contract**: [test/borrowerOperationsOnBehalfTroveManagament.t.sol/contract_BorrowerOperationsOnBehalfTroveManagamentTest.md]

## Metadata

- **Contract**: BorrowerOperationsOnBehalfTroveManagamentTest
- **Signature**: `testCanSetRemoveManagerWithRemoveManagerAsReceiverOnOpenTrove()`
- **Visibility**: public
- **Source Range**: 6196:816:300

## Implementation

```solidity
function testCanSetRemoveManagerWithRemoveManagerAsReceiverOnOpenTrove() public {
    vm.startPrank(A);
    uint256 ATroveId = borrowerOperations.openTrove(A, 0, 100 ether, 10000e18, 0, 0, 5e16, 10000e18, address(0), B, B);
    vm.stopPrank();
    (address manager, address receiver) = borrowerOperations.removeManagerReceiverOf(ATroveId);
    assertEq(manager, B, "Wrong Manager");
    assertEq(receiver, B, "Wrong Receiver");
}
```

## Related Implementations

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 3570:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

## External Calls

- **Vm::startPrank(address)**
- **IBorrowerOperationsTester::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**
- **Vm::stopPrank()**
- **IBorrowerOperationsTester::removeManagerReceiverOf(uint256)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperationsOnBehalfTroveManagamentTest.testCanSetRemoveManagerWithRemoveManagerAsReceiverOnOpenTrove() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
  │   💬 Args: [manager, B, "Wrong Manager"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
      💬 Args: [receiver, B, "Wrong Receiver"]
      👁️  Def: internal
```
