# Function: testCanAdjustZombieTroveWithdrawCollAndBold()

**Contract**: [test/zapperGasComp.t.sol/contract_ZapperGasCompTest.md]

## Metadata

- **Contract**: ZapperGasCompTest
- **Signature**: `testCanAdjustZombieTroveWithdrawCollAndBold()`
- **Visibility**: external
- **Source Range**: 23821:2260:337

## Implementation

```solidity
function testCanAdjustZombieTroveWithdrawCollAndBold() external {
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
    vm.stopPrank();
    vm.startPrank(A);
    collateralRegistry.redeemCollateral(boldAmount1 - boldAmount2, 10, 1e18);
    vm.stopPrank();
    uint256 troveCollBefore = troveManager.getTroveEntireColl(troveId);
    uint256 boldBalanceBeforeA = boldToken.balanceOf(A);
    uint256 collBalanceBeforeA = collToken.balanceOf(A);
    uint256 collBalanceBeforeB = collToken.balanceOf(B);
    vm.startPrank(B);
    gasCompZapper.adjustZombieTrove(troveId, collAmount2, false, boldAmount2, true, 0, 0, boldAmount2);
    vm.stopPrank();
    assertEq(troveManager.getTroveEntireColl(troveId), troveCollBefore - collAmount2, "Trove coll mismatch");
    assertApproxEqAbs(troveManager.getTroveEntireDebt(troveId), 2 * boldAmount2, 2e18, "Trove  debt mismatch");
    assertEq(boldToken.balanceOf(A), boldBalanceBeforeA + boldAmount2, "A BOLD bal mismatch");
    assertEq(collToken.balanceOf(A), collBalanceBeforeA + collAmount2, "A Coll bal mismatch");
    assertEq(boldToken.balanceOf(B), 0, "B BOLD bal mismatch");
    assertEq(collToken.balanceOf(B), collBalanceBeforeB, "B Coll bal mismatch");
}
```

## Related Implementations

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### assertApproxEqAbs(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 16826:208:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqAbs(uint256,uint256,uint256,string)`

```solidity
function assertApproxEqAbs(uint256 left, uint256 right, uint256 maxDelta, string memory err) virtual internal pure {
    vm.assertApproxEqAbs(left, right, maxDelta, err);
}
```

## External Calls

- **Vm::startPrank(address)**
- **unknown::unknown**
- **Vm::stopPrank()**
- **GasCompZapper::setRemoveManagerWithReceiver(uint256,address,address)**
- **ICollateralRegistry::redeemCollateral(uint256,uint256,uint256)**
- **ITroveManagerTester::getTroveEntireColl(uint256)**
- **IBoldToken::balanceOf(address)**
- **IERC20::balanceOf(address)**
- **GasCompZapper::adjustZombieTrove(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperGasCompTest.testCanAdjustZombieTroveWithdrawCollAndBold() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [troveManager.getTroveEntireColl(troveId), troveCollBefore - collAmount2, "Trove coll mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [troveManager.getTroveEntireDebt(troveId), 2 * boldAmount2, 2e18, "Trove  debt mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [boldToken.balanceOf(A), boldBalanceBeforeA + boldAmount2, "A BOLD bal mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [collToken.balanceOf(A), collBalanceBeforeA + collAmount2, "A Coll bal mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [boldToken.balanceOf(B), 0, "B BOLD bal mismatch"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
      💬 Args: [collToken.balanceOf(B), collBalanceBeforeB, "B Coll bal mismatch"]
      👁️  Def: internal
```
