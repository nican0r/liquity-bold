# Function: testTroveManagerHasCorrectSPAddress()

**Contract**: [test/deployment.t.sol/contract_Deployment.md]

## Metadata

- **Contract**: Deployment
- **Signature**: `testTroveManagerHasCorrectSPAddress()`
- **Visibility**: public
- **Source Range**: 2735:285:302

## Implementation

```solidity
function testTroveManagerHasCorrectSPAddress() public view {
    address stabilityPoolAddress = address(stabilityPool);
    address recordedStabilityPoolAddress = address(troveManager.stabilityPool());
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

- **ITroveManagerTester::stabilityPool()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Deployment.testTroveManagerHasCorrectSPAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
      💬 Args: [stabilityPoolAddress, recordedStabilityPoolAddress]
      👁️  Def: internal
```
