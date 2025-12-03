# Function: testCannotWithdrawBoldIfZapperIsNotReceiver()

**Contract**: [test/zapperGasComp.t.sol/contract_ZapperGasCompTest.md]

## Metadata

- **Contract**: ZapperGasCompTest
- **Signature**: `testCannotWithdrawBoldIfZapperIsNotReceiver()`
- **Visibility**: external
- **Source Range**: 15295:1346:337

## Implementation

```solidity
function testCannotWithdrawBoldIfZapperIsNotReceiver() external {
    uint256 collAmount = 10 ether;
    uint256 boldAmount1 = 10000e18;
    uint256 boldAmount2 = 1000e18;
    IZapper.OpenTroveParams memory params = IZapper.OpenTroveParams({owner: A, ownerIndex: 0, collAmount: collAmount, boldAmount: boldAmount1, upperHint: 0, lowerHint: 0, annualInterestRate: MIN_ANNUAL_INTEREST_RATE, batchManager: address(0), maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(A);
    uint256 troveId = gasCompZapper.openTroveWithRawETH{value: ETH_GAS_COMPENSATION}(params);
    vm.stopPrank();
    vm.startPrank(A);
    gasCompZapper.setRemoveManagerWithReceiver(troveId, B, A);
    borrowerOperations.setRemoveManagerWithReceiver(troveId, address(gasCompZapper), B);
    vm.stopPrank();
    vm.startPrank(B);
    vm.expectRevert("BZ: Zapper is not receiver for this trove");
    gasCompZapper.withdrawBold(troveId, boldAmount2, boldAmount2);
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
- **GasCompZapper::withdrawBold(uint256,uint256,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperGasCompTest.testCannotWithdrawBoldIfZapperIsNotReceiver() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
