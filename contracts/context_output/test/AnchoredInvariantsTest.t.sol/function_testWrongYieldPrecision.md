# Function: testWrongYieldPrecision()

**Contract**: [test/AnchoredInvariantsTest.t.sol/contract_AnchoredInvariantsTest.md]

## Metadata

- **Contract**: AnchoredInvariantsTest
- **Signature**: `testWrongYieldPrecision()`
- **Visibility**: external
- **Source Range**: 9264:5627:227

## Implementation

```solidity
function testWrongYieldPrecision() external {
    vm.prank(carl);
    handler.addMeToLiquidationBatch();
    vm.prank(adam);
    handler.addMeToUrgentRedemptionBatch();
    vm.prank(barb);
    handler.warp(19_326);
    vm.prank(carl);
    handler.addMeToUrgentRedemptionBatch();
    vm.prank(dana);
    handler.registerBatchManager(3, 0.30820256993275862 ether, 0.691797430067250243 ether, 0.383672204747583321 ether, 0.000000000000018015 ether, 11403);
    vm.prank(eric);
    handler.registerBatchManager(3, 0.018392910495297323 ether, 0.98160708950470919 ether, 0.963214179009414206 ether, 0.000000000000019546 ether, 13319597);
    vm.prank(fran);
    handler.warp(354);
    vm.prank(adam);
    handler.addMeToUrgentRedemptionBatch();
    vm.prank(eric);
    handler.warp(15_305_108);
    vm.prank(fran);
    handler.openTrove(1, 99_999.999999999999999998 ether, 1.883224555937797003 ether, 0.887905235895642125 ether, 4164477, 39);
    vm.prank(dana);
    handler.warp(996);
    vm.prank(eric);
    handler.addMeToUrgentRedemptionBatch();
    vm.prank(barb);
    handler.warp(4_143_017);
    vm.prank(fran);
    handler.addMeToLiquidationBatch();
    vm.prank(adam);
    handler.provideToSP(0, 0.000000000000011094 ether, true);
    vm.prank(carl);
    handler.addMeToUrgentRedemptionBatch();
    vm.prank(barb);
    handler.openTrove(2, 79_311.063107967331806055 ether, 1.900000000000001559 ether, 0.995000000000007943 ether, 3270556590, 1229144376);
    vm.prank(fran);
    handler.addMeToLiquidationBatch();
    vm.prank(dana);
    handler.setPrice(2, 2.100000000000011917 ether);
    vm.prank(carl);
    handler.provideToSP(1, 0.027362680048399155 ether, false);
    vm.prank(eric);
    handler.openTrove(3, 30_260.348082017558572105 ether, 1.683511222023706186 ether, 0.016900375815455486 ether, 108, 14159);
    vm.prank(carl);
    handler.addMeToUrgentRedemptionBatch();
    vm.prank(adam);
    handler.addMeToLiquidationBatch();
    vm.prank(adam);
    handler.addMeToUrgentRedemptionBatch();
    vm.prank(dana);
    handler.redeemCollateral(64_016.697525751186019705 ether, 0);
    vm.prank(eric);
    handler.applyMyPendingDebt(3, 2542, 468);
    vm.prank(gabe);
    handler.warp(20_216);
    vm.prank(carl);
    handler.registerBatchManager(1, 0.995000000000425732 ether, 0.998288014105982235 ether, 0.996095220733623871 ether, 0.000000000000027477 ether, 3299);
    vm.prank(carl);
    handler.addMeToLiquidationBatch();
    vm.prank(hope);
    handler.redeemCollateral(0.000151948988774209 ether, 0);
    vm.prank(eric);
    handler.provideToSP(0, 76_740.446487959260685533 ether, true);
    vm.prank(adam);
    handler.addMeToUrgentRedemptionBatch();
    vm.prank(hope);
    handler.provideToSP(1, 4.127947448768090932 ether, false);
}
```

## External Calls

- **Vm::prank(address)**
- **InvariantsTestHandler::addMeToLiquidationBatch()**
- **InvariantsTestHandler::addMeToUrgentRedemptionBatch()**
- **InvariantsTestHandler::warp(uint256)**
- **InvariantsTestHandler::registerBatchManager(uint256,uint256,uint256,uint256,uint256,uint256)**
- **InvariantsTestHandler::openTrove(uint256,uint256,uint256,uint256,uint32,uint32)**
- **InvariantsTestHandler::provideToSP(uint256,uint256,bool)**
- **InvariantsTestHandler::setPrice(uint256,uint256)**
- **InvariantsTestHandler::redeemCollateral(uint256,uint256)**
- **InvariantsTestHandler::applyMyPendingDebt(uint256,uint32,uint32)**

## State Variable Reads

- **handler** (`contract InvariantsTestHandler`) [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AnchoredInvariantsTest.testWrongYieldPrecision() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
