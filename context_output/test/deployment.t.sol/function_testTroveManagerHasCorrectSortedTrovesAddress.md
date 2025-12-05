# Function: testTroveManagerHasCorrectSortedTrovesAddress()

**Contract**: [test/deployment.t.sol/contract_Deployment.md]

## Metadata

- **Contract**: Deployment
- **Signature**: `testTroveManagerHasCorrectSortedTrovesAddress()`
- **Visibility**: public
- **Source Range**: 1444:289:302

## Implementation

```solidity
function testTroveManagerHasCorrectSortedTrovesAddress() public view {
    address sortedTrovesAddress = address(sortedTroves);
    address recordedSortedTrovesAddress = address(troveManager.sortedTroves());
    assertEq(sortedTrovesAddress, recordedSortedTrovesAddress);
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

- **ITroveManagerTester::sortedTroves()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Deployment.testTroveManagerHasCorrectSortedTrovesAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
      💬 Args: [sortedTrovesAddress, recordedSortedTrovesAddress]
      👁️  Def: internal
```
