# Function: testSPYieldBigDispropRedeem()

**Contract**: [test/AnchoredSPInvariantsTest.t.sol/contract_AnchoredSPInvariantsTest.md]

## Metadata

- **Contract**: AnchoredSPInvariantsTest
- **Signature**: `testSPYieldBigDispropRedeem()`
- **Visibility**: external
- **Source Range**: 42003:2326:228

## Implementation

```solidity
function testSPYieldBigDispropRedeem() external {
    vm.prank(barb);
    handler.openTrove(65_340_180_846_456_745_712.365995789115062922 ether);
    vm.prank(gabe);
    handler.openTrove(99_999_999_999_999_998_000.000000000000020497 ether);
    vm.prank(hope);
    handler.openTrove(66_998_787_786_176_443_734.508398955185448923 ether);
    vm.prank(carl);
    handler.provideToSp(65_346_446_343_250_241_630.04102517305741141 ether, false);
    vm.prank(eric);
    handler.provideToSp(0.00000000000000052 ether, false);
    vm.prank(barb);
    handler.liquidateMe();
    vm.prank(eric);
    handler.openTrove(7_139_376_295_357_676_734.290616044087341676 ether);
    vm.prank(carl);
    handler.provideToSp(67_005_212_327_471_008_598.976091541386631089 ether, false);
    vm.prank(hope);
    handler.liquidateMe();
    vm.prank(fran);
    handler.openTrove(76_042_952_954_096_078_299.799742132137100824 ether);
}
```

## External Calls

- **Vm::prank(address)**
- **SPInvariantsTestHandler::openTrove(uint256)**
- **SPInvariantsTestHandler::provideToSp(uint256,bool)**
- **SPInvariantsTestHandler::liquidateMe()**

## State Variable Reads

- **barb** (`address`)
- **handler** (`contract SPInvariantsTestHandler`) [test/TestContracts/SPInvariantsTestHandler.t.sol/contract_SPInvariantsTestHandler.md]
- **gabe** (`address`)
- **hope** (`address`)
- **carl** (`address`)
- **eric** (`address`)
- **fran** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AnchoredSPInvariantsTest.testSPYieldBigDispropRedeem() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
