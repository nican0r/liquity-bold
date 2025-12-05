# Function: testStabilityPoolHasCorrectTroveManagerAddress()

**Contract**: [test/deployment.t.sol/contract_Deployment.md]

## Metadata

- **Contract**: Deployment
- **Signature**: `testStabilityPoolHasCorrectTroveManagerAddress()`
- **Visibility**: public
- **Source Range**: 5123:291:302

## Implementation

```solidity
function testStabilityPoolHasCorrectTroveManagerAddress() public view {
    address troveManagerAddress = address(troveManager);
    address recordedTroveManagerAddress = address(stabilityPool.troveManager());
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

- **IStabilityPool::troveManager()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Deployment.testStabilityPoolHasCorrectTroveManagerAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
      💬 Args: [troveManagerAddress, recordedTroveManagerAddress]
      👁️  Def: internal
```
