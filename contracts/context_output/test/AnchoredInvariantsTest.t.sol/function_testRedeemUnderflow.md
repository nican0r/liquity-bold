# Function: testRedeemUnderflow()

**Contract**: [test/AnchoredInvariantsTest.t.sol/contract_AnchoredInvariantsTest.md]

## Metadata

- **Contract**: AnchoredInvariantsTest
- **Signature**: `testRedeemUnderflow()`
- **Visibility**: external
- **Source Range**: 4607:4651:227

## Implementation

```solidity
function testRedeemUnderflow() external {
    vm.prank(fran);
    handler.warp(18_162);
    vm.prank(carl);
    handler.registerBatchManager(0, 0.995000001857124003 ether, 0.999999628575220679 ether, 0.999925530120657388 ether, 0.249999999999999999 ether, 12664);
    vm.prank(hope);
    handler.addMeToLiquidationBatch();
    vm.prank(fran);
    handler.addMeToUrgentRedemptionBatch();
    vm.prank(fran);
    handler.addMeToUrgentRedemptionBatch();
    vm.prank(gabe);
    handler.addMeToUrgentRedemptionBatch();
    vm.prank(dana);
    handler.addMeToLiquidationBatch();
    vm.prank(eric);
    handler.warp(4_641_555);
    vm.prank(adam);
    handler.addMeToUrgentRedemptionBatch();
    vm.prank(dana);
    handler.addMeToLiquidationBatch();
    vm.prank(gabe);
    handler.addMeToLiquidationBatch();
    vm.prank(fran);
    handler.addMeToLiquidationBatch();
    vm.prank(hope);
    handler.registerBatchManager(0, 0.739903753088089514 ether, 0.780288740735740819 ether, 0.767858707410717411 ether, 0.000000000000022941 ether, 21644);
    vm.prank(adam);
    handler.openTrove(3, 39_503.887731534058892956 ether, 1.6863644596244192 ether, 0.38385567397413886 ether, 1, 7433679);
    vm.prank(adam);
    handler.addMeToUrgentRedemptionBatch();
    vm.prank(hope);
    handler.warp(23_201);
    vm.prank(carl);
    handler.warp(18_593_995);
    vm.prank(carl);
    handler.redeemCollateral(15_191.361299840412827416 ether, 0);
    vm.prank(dana);
    handler.redeemCollateral(0.000000000000006302 ether, 1);
    vm.prank(hope);
    handler.registerBatchManager(1, 0.822978751289802582 ether, 0.835495454680029657 ether, 0.833312890646159679 ether, 0.422857251385135959 ether, 29470036);
    vm.prank(gabe);
    handler.addMeToUrgentRedemptionBatch();
    vm.prank(barb);
    handler.addMeToLiquidationBatch();
    vm.prank(gabe);
    handler.warp(31);
    vm.prank(carl);
    handler.provideToSP(3, 0.000000000000021916 ether, false);
    vm.prank(carl);
    handler.setBatchManagerAnnualInterestRate(0, 0.998884384586837808 ether, 15539582, 63731457);
    vm.prank(gabe);
    handler.registerBatchManager(0, 0.351143076054309979 ether, 0.467168361632094569 ether, 0.433984569464653931 ether, 0.000000000000000026 ether, 16482089);
    vm.prank(adam);
    handler.registerBatchManager(3, 0.995000000000006201 ether, 0.996462074472343849 ether, 0.995351673013151748 ether, 0.045759837128294745 ether, 10150905);
    vm.prank(dana);
    handler.warp(23_299);
    vm.prank(carl);
    handler.warp(13_319_679);
    vm.prank(eric);
    handler.redeemCollateral(16_223.156659761268542045 ether, 0);
}
```

## External Calls

- **Vm::prank(address)**
- **InvariantsTestHandler::warp(uint256)**
- **InvariantsTestHandler::registerBatchManager(uint256,uint256,uint256,uint256,uint256,uint256)**
- **InvariantsTestHandler::addMeToLiquidationBatch()**
- **InvariantsTestHandler::addMeToUrgentRedemptionBatch()**
- **InvariantsTestHandler::openTrove(uint256,uint256,uint256,uint256,uint32,uint32)**
- **InvariantsTestHandler::redeemCollateral(uint256,uint256)**
- **InvariantsTestHandler::provideToSP(uint256,uint256,bool)**
- **InvariantsTestHandler::setBatchManagerAnnualInterestRate(uint256,uint256,uint32,uint32)**

## State Variable Reads

- **handler** (`contract InvariantsTestHandler`) [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AnchoredInvariantsTest.testRedeemUnderflow() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
