# Function: testBorrowerOperationsHasCorrectActivePoolAddress()

**Contract**: [test/deployment.t.sol/contract_Deployment.md]

## Metadata

- **Contract**: Deployment
- **Signature**: `testBorrowerOperationsHasCorrectActivePoolAddress()`
- **Visibility**: public
- **Source Range**: 7608:287:302

## Implementation

```solidity
function testBorrowerOperationsHasCorrectActivePoolAddress() public view {
    address activePoolAddress = address(activePool);
    address recordedActivePoolAddress = address(borrowerOperations.activePool());
    assertEq(activePoolAddress, recordedActivePoolAddress);
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

- **IBorrowerOperationsTester::activePool()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Deployment.testBorrowerOperationsHasCorrectActivePoolAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
      💬 Args: [activePoolAddress, recordedActivePoolAddress]
      👁️  Def: internal
```
