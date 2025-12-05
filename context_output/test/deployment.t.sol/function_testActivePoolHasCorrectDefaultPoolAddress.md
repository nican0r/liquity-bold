# Function: testActivePoolHasCorrectDefaultPoolAddress()

**Contract**: [test/deployment.t.sol/contract_Deployment.md]

## Metadata

- **Contract**: Deployment
- **Signature**: `testActivePoolHasCorrectDefaultPoolAddress()`
- **Visibility**: public
- **Source Range**: 3639:276:302

## Implementation

```solidity
function testActivePoolHasCorrectDefaultPoolAddress() public view {
    address defaultPoolAddress = address(defaultPool);
    address recordedDefaultPoolAddress = activePool.defaultPoolAddress();
    assertEq(defaultPoolAddress, recordedDefaultPoolAddress);
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

- **IActivePool::defaultPoolAddress()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Deployment.testActivePoolHasCorrectDefaultPoolAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
      💬 Args: [defaultPoolAddress, recordedDefaultPoolAddress]
      👁️  Def: internal
```
