# Function: testInitialRedemptionBaseRate()

**Contract**: [test/troveManager.t.sol/contract_TroveManagerTest.md]

## Metadata

- **Contract**: TroveManagerTest
- **Signature**: `testInitialRedemptionBaseRate()`
- **Visibility**: public
- **Source Range**: 7185:128:335

## Implementation

```solidity
function testInitialRedemptionBaseRate() public view {
    assertEq(collateralRegistry.baseRate(), INITIAL_BASE_RATE);
}
```

## Related Implementations

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
}
```

## External Calls

- **ICollateralRegistry::baseRate()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTest.testInitialRedemptionBaseRate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
      💬 Args: [collateralRegistry.baseRate(), INITIAL_BASE_RATE]
      👁️  Def: internal
```
