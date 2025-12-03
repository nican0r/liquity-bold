# Function: testDefaultPoolHasCorrectActivePoolAddress()

**Contract**: [test/deployment.t.sol/contract_Deployment.md]

## Metadata

- **Contract**: Deployment
- **Signature**: `testDefaultPoolHasCorrectActivePoolAddress()`
- **Visibility**: public
- **Source Range**: 5732:271:302

## Implementation

```solidity
function testDefaultPoolHasCorrectActivePoolAddress() public view {
    address activePoolAddress = address(activePool);
    address recordedActivePoolAddress = defaultPool.activePoolAddress();
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

- **IDefaultPool::activePoolAddress()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Deployment.testDefaultPoolHasCorrectActivePoolAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
      💬 Args: [activePoolAddress, recordedActivePoolAddress]
      👁️  Def: internal
```
