# Function: testCannotAdjustZombieTroveWithdrawCollAndBoldIfZapperIsNotReceiver()

**Contract**: [test/zapperWETH.t.sol/contract_ZapperWETHTest.md]

## Metadata

- **Contract**: ZapperWETHTest
- **Signature**: `testCannotAdjustZombieTroveWithdrawCollAndBoldIfZapperIsNotReceiver()`
- **Visibility**: external
- **Source Range**: 23809:1650:339

## Implementation

```solidity
function testCannotAdjustZombieTroveWithdrawCollAndBoldIfZapperIsNotReceiver() external {
    uint256 ethAmount1 = 10 ether;
    uint256 ethAmount2 = 1 ether;
    uint256 boldAmount1 = 10000e18;
    uint256 boldAmount2 = 1000e18;
    IZapper.OpenTroveParams memory params = IZapper.OpenTroveParams({owner: A, ownerIndex: 0, collAmount: 0, boldAmount: boldAmount1, upperHint: 0, lowerHint: 0, annualInterestRate: MIN_ANNUAL_INTEREST_RATE, batchManager: address(0), maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(A);
    uint256 troveId = wethZapper.openTroveWithRawETH{value: ethAmount1 + ETH_GAS_COMPENSATION}(params);
    vm.stopPrank();
    vm.startPrank(A);
    wethZapper.setRemoveManagerWithReceiver(troveId, B, A);
    borrowerOperations.setRemoveManagerWithReceiver(troveId, address(wethZapper), C);
    vm.stopPrank();
    vm.startPrank(A);
    collateralRegistry.redeemCollateral(boldAmount1 - boldAmount2, 10, 1e18);
    vm.stopPrank();
    vm.startPrank(B);
    vm.expectRevert("BZ: Zapper is not receiver for this trove");
    wethZapper.adjustZombieTroveWithRawETH(troveId, ethAmount2, false, boldAmount2, true, 0, 0, boldAmount2);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **unknown::unknown**
- **Vm::stopPrank()**
- **WETHZapper::setRemoveManagerWithReceiver(uint256,address,address)**
- **IBorrowerOperationsTester::setRemoveManagerWithReceiver(uint256,address,address)**
- **ICollateralRegistry::redeemCollateral(uint256,uint256,uint256)**
- **Vm::expectRevert(bytes)**
- **WETHZapper::adjustZombieTroveWithRawETH(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperWETHTest.testCannotAdjustZombieTroveWithdrawCollAndBoldIfZapperIsNotReceiver() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
