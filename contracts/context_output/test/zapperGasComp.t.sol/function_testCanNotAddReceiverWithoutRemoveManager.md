# Function: testCanNotAddReceiverWithoutRemoveManager()

**Contract**: [test/zapperGasComp.t.sol/contract_ZapperGasCompTest.md]

## Metadata

- **Contract**: ZapperGasCompTest
- **Signature**: `testCanNotAddReceiverWithoutRemoveManager()`
- **Visibility**: external
- **Source Range**: 10170:1061:337

## Implementation

```solidity
function testCanNotAddReceiverWithoutRemoveManager() external {
    uint256 collAmount = 10 ether;
    uint256 boldAmount1 = 10000e18;
    IZapper.OpenTroveParams memory params = IZapper.OpenTroveParams({owner: A, ownerIndex: 0, collAmount: collAmount, boldAmount: boldAmount1, upperHint: 0, lowerHint: 0, annualInterestRate: MIN_ANNUAL_INTEREST_RATE, batchManager: address(0), maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(A);
    uint256 troveId = gasCompZapper.openTroveWithRawETH{value: ETH_GAS_COMPENSATION}(params);
    vm.stopPrank();
    vm.startPrank(A);
    vm.expectRevert(AddRemoveManagers.EmptyManager.selector);
    gasCompZapper.setRemoveManagerWithReceiver(troveId, address(0), B);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **unknown::unknown**
- **Vm::stopPrank()**
- **Vm::expectRevert(bytes4)**
- **GasCompZapper::setRemoveManagerWithReceiver(uint256,address,address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperGasCompTest.testCanNotAddReceiverWithoutRemoveManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
