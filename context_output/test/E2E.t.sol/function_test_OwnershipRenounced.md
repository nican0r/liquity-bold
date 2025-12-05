# Function: test_OwnershipRenounced()

**Contract**: [test/E2E.t.sol/contract_E2ETest.md]

## Metadata

- **Contract**: E2ETest
- **Signature**: `test_OwnershipRenounced()`
- **Visibility**: external
- **Source Range**: 5377:876:231

## Implementation

```solidity
function test_OwnershipRenounced() external {
    ownables.push(address(boldToken));
    for (uint256 i = 0; i < branches.length; ++i) {
        ownables.push(address(branches[i].addressesRegistry));
    }
    for (uint256 i = 0; i < ownables.length; ++i) {
        assertEq(Ownable(ownables[i]).owner(), address(0), string.concat("Ownership of ", vm.getLabel(ownables[i]), " should have been renounced"));
    }
    ILiquidityGaugeV6[2] memory gauges = [curveUsdcBoldGauge, curveLusdBoldGauge];
    for (uint256 i = 0; i < gauges.length; ++i) {
        if (address(gauges[i]) == address(0)) continue;
        address gaugeManager = gauges[i].manager();
        assertEq(gaugeManager, address(0), "Gauge manager role should have been renounced");
    }
}
```

## Related Implementations

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 3570:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

## External Calls

- **Ownable::owner()**
- **Vm::getLabel(address)**
- **ILiquidityGaugeV6::manager()**

## State Variable Reads

- **ownables** (`address[]`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## State Variable Writes

- **ownables** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: E2ETest.test_OwnershipRenounced() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
  │   💬 Args: [Ownable(ownables[i]).owner(), address(0), string.concat("Ownership of ", vm.getLabel(ownables[i]), " should have been renounced")]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
      💬 Args: [gaugeManager, address(0), "Gauge manager role should have been renounced"]
      👁️  Def: internal
```
