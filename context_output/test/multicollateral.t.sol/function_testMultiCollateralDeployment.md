# Function: testMultiCollateralDeployment()

**Contract**: [test/multicollateral.t.sol/contract_MulticollateralTest.md]

## Metadata

- **Contract**: MulticollateralTest
- **Signature**: `testMultiCollateralDeployment()`
- **Visibility**: public
- **Source Range**: 4445:956:311

## Implementation

```solidity
function testMultiCollateralDeployment() public {
    assertEq(collateralRegistry.totalCollaterals(), NUM_COLLATERALS, "Wrong number of branches");
    for (uint256 c = 0; c < NUM_COLLATERALS; c++) {
        assertNotEq(address(collateralRegistry.getToken(c)), ZERO_ADDRESS, "Missing collateral token");
        assertNotEq(address(collateralRegistry.getTroveManager(c)), ZERO_ADDRESS, "Missing TroveManager");
    }
    for (uint256 c = NUM_COLLATERALS; c < 10; c++) {
        assertEq(address(collateralRegistry.getToken(c)), ZERO_ADDRESS, "Extra collateral token");
        assertEq(address(collateralRegistry.getTroveManager(c)), ZERO_ADDRESS, "Extra TroveManager");
    }
    vm.expectRevert("Invalid index");
    collateralRegistry.getToken(10);
    vm.expectRevert("Invalid index");
    collateralRegistry.getTroveManager(10);
}
```

## Related Implementations

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### assertNotEq(address,address,string)

- **Kind**: internal
- **Source**: 8568:140:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertNotEq(address,address,string)`

```solidity
function assertNotEq(address left, address right, string memory err) virtual internal pure {
    vm.assertNotEq(left, right, err);
}
```

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

- **ICollateralRegistry::totalCollaterals()**
- **ICollateralRegistry::getToken(uint256)**
- **ICollateralRegistry::getTroveManager(uint256)**
- **Vm::expectRevert(bytes)**

## State Variable Reads

- **NUM_COLLATERALS** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MulticollateralTest.testMultiCollateralDeployment() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [collateralRegistry.totalCollaterals(), NUM_COLLATERALS, "Wrong number of branches"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 2)
  │   💬 Args: [address(collateralRegistry.getToken(c)), ZERO_ADDRESS, "Missing collateral token"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 3)
  │   💬 Args: [address(collateralRegistry.getTroveManager(c)), ZERO_ADDRESS, "Missing TroveManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 4)
  │   💬 Args: [address(collateralRegistry.getToken(c)), ZERO_ADDRESS, "Extra collateral token"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 5)
      💬 Args: [address(collateralRegistry.getTroveManager(c)), ZERO_ADDRESS, "Extra TroveManager"]
      👁️  Def: internal
```
