# Function: testActivePoolHasCorrectStabilityPoolAddress()

**Contract**: [test/deployment.t.sol/contract_Deployment.md]

## Metadata

- **Contract**: Deployment
- **Signature**: `testActivePoolHasCorrectStabilityPoolAddress()`
- **Visibility**: public
- **Source Range**: 3341:292:302

## Implementation

```solidity
function testActivePoolHasCorrectStabilityPoolAddress() public view {
    address stabilityPoolAddress = address(stabilityPool);
    address recordedStabilityPoolAddress = address(activePool.stabilityPool());
    assertEq(stabilityPoolAddress, recordedStabilityPoolAddress);
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

- **IActivePool::stabilityPool()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Deployment.testActivePoolHasCorrectStabilityPoolAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
      💬 Args: [stabilityPoolAddress, recordedStabilityPoolAddress]
      👁️  Def: internal
```
