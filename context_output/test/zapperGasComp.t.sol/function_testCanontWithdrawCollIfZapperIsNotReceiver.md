# Function: testCanontWithdrawCollIfZapperIsNotReceiver()

**Contract**: [test/zapperGasComp.t.sol/contract_ZapperGasCompTest.md]

## Metadata

- **Contract**: ZapperGasCompTest
- **Signature**: `testCanontWithdrawCollIfZapperIsNotReceiver()`
- **Visibility**: external
- **Source Range**: 9047:1117:337

## Implementation

```solidity
function testCanontWithdrawCollIfZapperIsNotReceiver() external {
    uint256 collAmount1 = 10 ether;
    uint256 boldAmount = 10000e18;
    uint256 collAmount2 = 1 ether;
    IZapper.OpenTroveParams memory params = IZapper.OpenTroveParams({owner: A, ownerIndex: 0, collAmount: collAmount1, boldAmount: boldAmount, upperHint: 0, lowerHint: 0, annualInterestRate: 5e16, batchManager: address(0), maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(A);
    uint256 troveId = gasCompZapper.openTroveWithRawETH{value: ETH_GAS_COMPENSATION}(params);
    vm.stopPrank();
    vm.startPrank(A);
    borrowerOperations.setRemoveManagerWithReceiver(troveId, address(gasCompZapper), B);
    vm.expectRevert("BZ: Zapper is not receiver for this trove");
    gasCompZapper.withdrawColl(troveId, collAmount2);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **unknown::unknown**
- **Vm::stopPrank()**
- **IBorrowerOperationsTester::setRemoveManagerWithReceiver(uint256,address,address)**
- **Vm::expectRevert(bytes)**
- **GasCompZapper::withdrawColl(uint256,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperGasCompTest.testCanontWithdrawCollIfZapperIsNotReceiver() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
