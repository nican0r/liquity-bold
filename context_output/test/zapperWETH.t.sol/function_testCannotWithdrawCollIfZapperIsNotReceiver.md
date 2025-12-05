# Function: testCannotWithdrawCollIfZapperIsNotReceiver()

**Contract**: [test/zapperWETH.t.sol/contract_ZapperWETHTest.md]

## Metadata

- **Contract**: ZapperWETHTest
- **Signature**: `testCannotWithdrawCollIfZapperIsNotReceiver()`
- **Visibility**: external
- **Source Range**: 8311:1136:339

## Implementation

```solidity
function testCannotWithdrawCollIfZapperIsNotReceiver() external {
    uint256 ethAmount1 = 10 ether;
    uint256 boldAmount = 10000e18;
    uint256 ethAmount2 = 1 ether;
    IZapper.OpenTroveParams memory params = IZapper.OpenTroveParams({owner: A, ownerIndex: 0, collAmount: 0, boldAmount: boldAmount, upperHint: 0, lowerHint: 0, annualInterestRate: 5e16, batchManager: address(0), maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(A);
    uint256 troveId = wethZapper.openTroveWithRawETH{value: ethAmount1 + ETH_GAS_COMPENSATION}(params);
    vm.stopPrank();
    vm.startPrank(A);
    borrowerOperations.setRemoveManagerWithReceiver(troveId, address(wethZapper), B);
    vm.expectRevert("BZ: Zapper is not receiver for this trove");
    wethZapper.withdrawCollToRawETH(troveId, ethAmount2);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **unknown::unknown**
- **Vm::stopPrank()**
- **IBorrowerOperationsTester::setRemoveManagerWithReceiver(uint256,address,address)**
- **Vm::expectRevert(bytes)**
- **WETHZapper::withdrawCollToRawETH(uint256,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperWETHTest.testCannotWithdrawCollIfZapperIsNotReceiver() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
