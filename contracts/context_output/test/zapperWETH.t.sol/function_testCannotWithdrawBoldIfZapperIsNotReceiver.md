# Function: testCannotWithdrawBoldIfZapperIsNotReceiver()

**Contract**: [test/zapperWETH.t.sol/contract_ZapperWETHTest.md]

## Metadata

- **Contract**: ZapperWETHTest
- **Signature**: `testCannotWithdrawBoldIfZapperIsNotReceiver()`
- **Visibility**: external
- **Source Range**: 14481:1350:339

## Implementation

```solidity
function testCannotWithdrawBoldIfZapperIsNotReceiver() external {
    uint256 ethAmount = 10 ether;
    uint256 boldAmount1 = 10000e18;
    uint256 boldAmount2 = 1000e18;
    IZapper.OpenTroveParams memory params = IZapper.OpenTroveParams({owner: A, ownerIndex: 0, collAmount: 0, boldAmount: boldAmount1, upperHint: 0, lowerHint: 0, annualInterestRate: MIN_ANNUAL_INTEREST_RATE, batchManager: address(0), maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(A);
    uint256 troveId = wethZapper.openTroveWithRawETH{value: ethAmount + ETH_GAS_COMPENSATION}(params);
    vm.stopPrank();
    vm.startPrank(A);
    wethZapper.setRemoveManagerWithReceiver(troveId, B, A);
    borrowerOperations.setRemoveManagerWithReceiver(troveId, address(wethZapper), C);
    vm.stopPrank();
    vm.startPrank(B);
    vm.expectRevert("BZ: Zapper is not receiver for this trove");
    wethZapper.withdrawBold(troveId, boldAmount2, boldAmount2);
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
- **WETHZapper::withdrawBold(uint256,uint256,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperWETHTest.testCannotWithdrawBoldIfZapperIsNotReceiver() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
