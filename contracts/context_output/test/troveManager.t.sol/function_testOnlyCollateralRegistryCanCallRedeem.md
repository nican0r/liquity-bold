# Function: testOnlyCollateralRegistryCanCallRedeem()

**Contract**: [test/troveManager.t.sol/contract_TroveManagerTest.md]

## Metadata

- **Contract**: TroveManagerTest
- **Signature**: `testOnlyCollateralRegistryCanCallRedeem()`
- **Visibility**: public
- **Source Range**: 150:256:335

## Implementation

```solidity
function testOnlyCollateralRegistryCanCallRedeem() public {
    vm.startPrank(A);
    vm.expectRevert(TroveManager.CallerNotCollateralRegistry.selector);
    troveManager.redeemCollateral(A, 1, 2000e18, 1e16, 100);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **ITroveManagerTester::redeemCollateral(address,uint256,uint256,uint256,uint256)**
- **Vm::stopPrank()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTest.testOnlyCollateralRegistryCanCallRedeem() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
