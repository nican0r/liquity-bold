# Function: testCanNotAddReceiverWithoutRemoveManager()

**Contract**: [test/zapperWETH.t.sol/contract_ZapperWETHTest.md]

## Metadata

- **Contract**: ZapperWETHTest
- **Signature**: `testCanNotAddReceiverWithoutRemoveManager()`
- **Visibility**: external
- **Source Range**: 9453:1071:339

## Implementation

```solidity
function testCanNotAddReceiverWithoutRemoveManager() external {
    uint256 ethAmount = 10 ether;
    uint256 boldAmount1 = 10000e18;
    IZapper.OpenTroveParams memory params = IZapper.OpenTroveParams({owner: A, ownerIndex: 0, collAmount: 0, boldAmount: boldAmount1, upperHint: 0, lowerHint: 0, annualInterestRate: MIN_ANNUAL_INTEREST_RATE, batchManager: address(0), maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(A);
    uint256 troveId = wethZapper.openTroveWithRawETH{value: ethAmount + ETH_GAS_COMPENSATION}(params);
    vm.stopPrank();
    vm.startPrank(A);
    vm.expectRevert(AddRemoveManagers.EmptyManager.selector);
    wethZapper.setRemoveManagerWithReceiver(troveId, address(0), B);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **unknown::unknown**
- **Vm::stopPrank()**
- **Vm::expectRevert(bytes4)**
- **WETHZapper::setRemoveManagerWithReceiver(uint256,address,address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperWETHTest.testCanNotAddReceiverWithoutRemoveManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
