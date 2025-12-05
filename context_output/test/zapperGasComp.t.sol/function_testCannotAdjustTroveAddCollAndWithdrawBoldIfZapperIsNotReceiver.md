# Function: testCannotAdjustTroveAddCollAndWithdrawBoldIfZapperIsNotReceiver()

**Contract**: [test/zapperGasComp.t.sol/contract_ZapperGasCompTest.md]

## Metadata

- **Contract**: ZapperGasCompTest
- **Signature**: `testCannotAdjustTroveAddCollAndWithdrawBoldIfZapperIsNotReceiver()`
- **Visibility**: external
- **Source Range**: 22319:1454:337

## Implementation

```solidity
function testCannotAdjustTroveAddCollAndWithdrawBoldIfZapperIsNotReceiver() external {
    uint256 collAmount1 = 10 ether;
    uint256 collAmount2 = 1 ether;
    uint256 boldAmount1 = 10000e18;
    uint256 boldAmount2 = 1000e18;
    IZapper.OpenTroveParams memory params = IZapper.OpenTroveParams({owner: A, ownerIndex: 0, collAmount: collAmount1, boldAmount: boldAmount1, upperHint: 0, lowerHint: 0, annualInterestRate: MIN_ANNUAL_INTEREST_RATE, batchManager: address(0), maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(A);
    uint256 troveId = gasCompZapper.openTroveWithRawETH{value: ETH_GAS_COMPENSATION}(params);
    vm.stopPrank();
    vm.startPrank(A);
    gasCompZapper.setRemoveManagerWithReceiver(troveId, B, A);
    borrowerOperations.setRemoveManagerWithReceiver(troveId, address(gasCompZapper), B);
    vm.stopPrank();
    vm.startPrank(B);
    vm.expectRevert("BZ: Zapper is not receiver for this trove");
    gasCompZapper.adjustTrove(troveId, collAmount2, true, boldAmount2, true, boldAmount2);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **unknown::unknown**
- **Vm::stopPrank()**
- **GasCompZapper::setRemoveManagerWithReceiver(uint256,address,address)**
- **IBorrowerOperationsTester::setRemoveManagerWithReceiver(uint256,address,address)**
- **Vm::expectRevert(bytes)**
- **GasCompZapper::adjustTrove(uint256,uint256,bool,uint256,bool,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperGasCompTest.testCannotAdjustTroveAddCollAndWithdrawBoldIfZapperIsNotReceiver() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
