# Function: testActivePoolHasCorrectInterestRouterAddress()

**Contract**: [test/deployment.t.sol/contract_Deployment.md]

## Metadata

- **Contract**: Deployment
- **Signature**: `testActivePoolHasCorrectInterestRouterAddress()`
- **Visibility**: public
- **Source Range**: 3046:289:302

## Implementation

```solidity
function testActivePoolHasCorrectInterestRouterAddress() public view {
    address interestRouter = address(mockInterestRouter);
    address recordedInterestRouterAddress = address(activePool.interestRouter());
    assertEq(interestRouter, recordedInterestRouterAddress);
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

- **IActivePool::interestRouter()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Deployment.testActivePoolHasCorrectInterestRouterAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
      💬 Args: [interestRouter, recordedInterestRouterAddress]
      👁️  Def: internal
```
