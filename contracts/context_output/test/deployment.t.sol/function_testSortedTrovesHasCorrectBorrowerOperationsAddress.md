# Function: testSortedTrovesHasCorrectBorrowerOperationsAddress()

**Contract**: [test/deployment.t.sol/contract_Deployment.md]

## Metadata

- **Contract**: Deployment
- **Signature**: `testSortedTrovesHasCorrectBorrowerOperationsAddress()`
- **Visibility**: public
- **Source Range**: 6031:329:302

## Implementation

```solidity
function testSortedTrovesHasCorrectBorrowerOperationsAddress() public view {
    address borrowerOperationsAddress = address(borrowerOperations);
    address recordedBorrowerOperationsAddress = sortedTroves.borrowerOperationsAddress();
    assertEq(borrowerOperationsAddress, recordedBorrowerOperationsAddress);
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

- **ISortedTroves::borrowerOperationsAddress()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Deployment.testSortedTrovesHasCorrectBorrowerOperationsAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
      💬 Args: [borrowerOperationsAddress, recordedBorrowerOperationsAddress]
      👁️  Def: internal
```
