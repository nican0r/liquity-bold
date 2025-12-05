# Function: testWrongYield()

**Contract**: [test/AnchoredInvariantsTest.t.sol/contract_AnchoredInvariantsTest.md]

## Metadata

- **Contract**: AnchoredInvariantsTest
- **Signature**: `testWrongYield()`
- **Visibility**: external
- **Source Range**: 2284:2317:227

## Implementation

```solidity
function testWrongYield() external {
    vm.prank(adam);
    handler.addMeToUrgentRedemptionBatch();
    vm.prank(adam);
    handler.registerBatchManager(0, 0.257486338754888547 ether, 0.580260126400716372 ether, 0.474304801140122485 ether, 0.84978254245815657 ether, 2121012);
    vm.prank(eric);
    handler.registerBatchManager(2, 0.995000000000011223 ether, 0.999999999997818617 ether, 0.999999999561578875 ether, 0.000000000000010359 ether, 5174410);
    vm.prank(fran);
    handler.warp(3_662_052);
    vm.prank(adam);
    handler.addMeToUrgentRedemptionBatch();
    vm.prank(hope);
    handler.addMeToLiquidationBatch();
    vm.prank(barb);
    handler.addMeToLiquidationBatch();
    vm.prank(hope);
    handler.openTrove(0, 99_999.999999999999999997 ether, 2.251600954885856105 ether, 0.650005595391858041 ether, 8768, 0);
    vm.prank(adam);
    handler.addMeToLiquidationBatch();
    vm.prank(eric);
    handler.addMeToLiquidationBatch();
    vm.prank(hope);
    handler.warp(9_396_472);
    vm.prank(gabe);
    handler.addMeToUrgentRedemptionBatch();
    vm.prank(adam);
    handler.addMeToUrgentRedemptionBatch();
    vm.prank(dana);
    handler.registerBatchManager(2, 0.995000000000011139 ether, 0.998635073564148166 ether, 0.996010156573547401 ether, 0.000000000000011577 ether, 9078342);
    vm.prank(carl);
    handler.registerBatchManager(1, 0.995000004199127012 ether, 1 ether, 0.999139502777974999 ether, 0.059938454189132239 ether, 1706585);
    vm.prank(gabe);
    handler.provideToSP(0, 58_897.613356828171795189 ether, false);
}
```

## External Calls

- **Vm::prank(address)**
- **InvariantsTestHandler::addMeToUrgentRedemptionBatch()**
- **InvariantsTestHandler::registerBatchManager(uint256,uint256,uint256,uint256,uint256,uint256)**
- **InvariantsTestHandler::warp(uint256)**
- **InvariantsTestHandler::addMeToLiquidationBatch()**
- **InvariantsTestHandler::openTrove(uint256,uint256,uint256,uint256,uint32,uint32)**
- **InvariantsTestHandler::provideToSP(uint256,uint256,bool)**

## State Variable Reads

- **handler** (`contract InvariantsTestHandler`) [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AnchoredInvariantsTest.testWrongYield() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
