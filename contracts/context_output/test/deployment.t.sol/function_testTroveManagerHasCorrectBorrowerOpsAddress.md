# Function: testTroveManagerHasCorrectBorrowerOpsAddress()

**Contract**: [test/deployment.t.sol/contract_Deployment.md]

## Metadata

- **Contract**: Deployment
- **Signature**: `testTroveManagerHasCorrectBorrowerOpsAddress()`
- **Visibility**: public
- **Source Range**: 1739:324:302

## Implementation

```solidity
function testTroveManagerHasCorrectBorrowerOpsAddress() public view {
    address borrowerOperationsAddress = address(borrowerOperations);
    address recordedBorrowerOperationsAddress = address(troveManager.borrowerOperations());
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

- **ITroveManagerTester::borrowerOperations()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Deployment.testTroveManagerHasCorrectBorrowerOpsAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
      💬 Args: [borrowerOperationsAddress, recordedBorrowerOperationsAddress]
      👁️  Def: internal
```
