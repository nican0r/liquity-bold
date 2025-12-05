# Function: testCannotAdjustTroveWithdrawCollAndBoldIfZapperIsNotReceiver()

**Contract**: [test/zapperWETH.t.sol/contract_ZapperWETHTest.md]

## Metadata

- **Contract**: ZapperWETHTest
- **Signature**: `testCannotAdjustTroveWithdrawCollAndBoldIfZapperIsNotReceiver()`
- **Visibility**: external
- **Source Range**: 17939:1460:339

## Implementation

```solidity
function testCannotAdjustTroveWithdrawCollAndBoldIfZapperIsNotReceiver() external {
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
    vm.startPrank(B);
    vm.expectRevert("BZ: Zapper is not receiver for this trove");
    wethZapper.adjustTroveWithRawETH(troveId, ethAmount2, false, boldAmount2, true, boldAmount2);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **unknown::unknown**
- **Vm::stopPrank()**
- **WETHZapper::setRemoveManagerWithReceiver(uint256,address,address)**
- **IBorrowerOperationsTester::setRemoveManagerWithReceiver(uint256,address,address)**
- **Vm::expectRevert(bytes)**
- **WETHZapper::adjustTroveWithRawETH(uint256,uint256,bool,uint256,bool,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperWETHTest.testCannotAdjustTroveWithdrawCollAndBoldIfZapperIsNotReceiver() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
