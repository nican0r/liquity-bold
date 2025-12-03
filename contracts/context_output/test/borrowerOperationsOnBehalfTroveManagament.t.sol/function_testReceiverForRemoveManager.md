# Function: testReceiverForRemoveManager()

**Contract**: [test/borrowerOperationsOnBehalfTroveManagament.t.sol/contract_BorrowerOperationsOnBehalfTroveManagamentTest.md]

## Metadata

- **Contract**: BorrowerOperationsOnBehalfTroveManagamentTest
- **Signature**: `testReceiverForRemoveManager()`
- **Visibility**: public
- **Source Range**: 27153:559:300

## Implementation

```solidity
function testReceiverForRemoveManager() public {
    _testReceiver(A, A, B, address(0), A);
    _testReceiver(B, A, B, address(0), A);
    _testReceiver(A, A, address(0), address(0), A);
    _testReceiver(A, A, B, C, A);
    _testReceiver(B, A, B, C, C);
    _testReceiver(A, A, A, C, C);
}
```

## Related Implementations

### _testReceiver(address,address,address,address,address)

- **Kind**: internal
- **Source**: 26584:563:300
- **Link**: `test/borrowerOperationsOnBehalfTroveManagament.t.sol:BorrowerOperationsOnBehalfTroveManagamentTest:_testReceiver(address,address,address,address,address)`

```solidity
function _testReceiver(address _sender, address _owner, address _manager, address _receiver, address _expectedReceiver) public {
    uint256 troveId = 1;
    addRemoveManagersTester.setRemoveManagerWithReceiverPermissionless(troveId, _manager, _receiver);
    vm.startPrank(_sender);
    address receiverResult = addRemoveManagersTester.requireSenderIsOwnerOrRemoveManagerAndGetReceiver(troveId, _owner);
    vm.stopPrank();
    assertEq(receiverResult, _expectedReceiver);
}
```

### assertEq(address,address)

- **Kind**: internal
- **Source**: 3454:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address)`

```solidity
function assertEq(address left, address right) virtual internal pure {
    vm.assertEq(left, right);
}
```

## State Variable Reads

- **addRemoveManagersTester** (`contract AddRemoveManagersTester`) [test/TestContracts/AddRemoveManagersTester.sol/contract_AddRemoveManagersTester.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperationsOnBehalfTroveManagamentTest.testReceiverForRemoveManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BorrowerOperationsOnBehalfTroveManagamentTest._testReceiver(address,address,address,address,address) (NodeID: 1)
  │   💬 Args: [A, A, B, address(0), A]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 2)
  │     💬 Args: [receiverResult, _expectedReceiver]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperationsOnBehalfTroveManagamentTest._testReceiver(address,address,address,address,address) (NodeID: 3)
  │   💬 Args: [B, A, B, address(0), A]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 4)
  │     💬 Args: [receiverResult, _expectedReceiver]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperationsOnBehalfTroveManagamentTest._testReceiver(address,address,address,address,address) (NodeID: 5)
  │   💬 Args: [A, A, address(0), address(0), A]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 6)
  │     💬 Args: [receiverResult, _expectedReceiver]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperationsOnBehalfTroveManagamentTest._testReceiver(address,address,address,address,address) (NodeID: 7)
  │   💬 Args: [A, A, B, C, A]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 8)
  │     💬 Args: [receiverResult, _expectedReceiver]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperationsOnBehalfTroveManagamentTest._testReceiver(address,address,address,address,address) (NodeID: 9)
  │   💬 Args: [B, A, B, C, C]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 10)
  │     💬 Args: [receiverResult, _expectedReceiver]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BorrowerOperationsOnBehalfTroveManagamentTest._testReceiver(address,address,address,address,address) (NodeID: 11)
      💬 Args: [A, A, A, C, C]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 12)
        💬 Args: [receiverResult, _expectedReceiver]
        👁️  Def: internal
```
