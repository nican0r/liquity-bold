# Function: testSortedTrovesHasCorrectTroveManagerAddress()

**Contract**: [test/deployment.t.sol/contract_Deployment.md]

## Metadata

- **Contract**: Deployment
- **Signature**: `testSortedTrovesHasCorrectTroveManagerAddress()`
- **Visibility**: public
- **Source Range**: 6366:289:302

## Implementation

```solidity
function testSortedTrovesHasCorrectTroveManagerAddress() public view {
    address troveManagerAddress = address(troveManager);
    address recordedTroveManagerAddress = address(sortedTroves.troveManager());
    assertEq(troveManagerAddress, recordedTroveManagerAddress);
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

- **ISortedTroves::troveManager()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Deployment.testSortedTrovesHasCorrectTroveManagerAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
      💬 Args: [troveManagerAddress, recordedTroveManagerAddress]
      👁️  Def: internal
```
