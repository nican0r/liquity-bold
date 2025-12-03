# Function: _testReceiver(address,address,address,address,address)

**Contract**: [test/borrowerOperationsOnBehalfTroveManagament.t.sol/contract_BorrowerOperationsOnBehalfTroveManagamentTest.md]

## Metadata

- **Contract**: BorrowerOperationsOnBehalfTroveManagamentTest
- **Signature**: `_testReceiver(address,address,address,address,address)`
- **Visibility**: public
- **Source Range**: 26584:563:300

## Implementation

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

- **AddRemoveManagersTester::setRemoveManagerWithReceiverPermissionless(uint256,address,address)**
- **Vm::startPrank(address)**
- **AddRemoveManagersTester::requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address)**
- **Vm::stopPrank()**

## State Variable Reads

- **addRemoveManagersTester** (`contract AddRemoveManagersTester`) [test/TestContracts/AddRemoveManagersTester.sol/contract_AddRemoveManagersTester.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperationsOnBehalfTroveManagamentTest._testReceiver(address,address,address,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
      💬 Args: [receiverResult, _expectedReceiver]
      👁️  Def: internal
```
