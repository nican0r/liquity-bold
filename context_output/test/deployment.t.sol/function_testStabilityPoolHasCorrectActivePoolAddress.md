# Function: testStabilityPoolHasCorrectActivePoolAddress()

**Contract**: [test/deployment.t.sol/contract_Deployment.md]

## Metadata

- **Contract**: Deployment
- **Signature**: `testStabilityPoolHasCorrectActivePoolAddress()`
- **Visibility**: public
- **Source Range**: 4557:277:302

## Implementation

```solidity
function testStabilityPoolHasCorrectActivePoolAddress() public view {
    address activePoolAddress = address(activePool);
    address recordedActivePoolAddress = address(stabilityPool.activePool());
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

- **IStabilityPool::activePool()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Deployment.testStabilityPoolHasCorrectActivePoolAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
      💬 Args: [activePoolAddress, recordedActivePoolAddress]
      👁️  Def: internal
```
