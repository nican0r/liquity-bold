# Function: testCanAdjustTroveWithdrawCollAndBold()

**Contract**: [test/zapperGasComp.t.sol/contract_ZapperGasCompTest.md]

## Metadata

- **Contract**: ZapperGasCompTest
- **Signature**: `testCanAdjustTroveWithdrawCollAndBold()`
- **Visibility**: external
- **Source Range**: 16647:2100:337

## Implementation

```solidity
function testCanAdjustTroveWithdrawCollAndBold() external {
    uint256 collAmount1 = 10 ether;
    uint256 collAmount2 = 1 ether;
    uint256 boldAmount1 = 10000e18;
    uint256 boldAmount2 = 1000e18;
    IZapper.OpenTroveParams memory params = IZapper.OpenTroveParams({owner: A, ownerIndex: 0, collAmount: collAmount1, boldAmount: boldAmount1, upperHint: 0, lowerHint: 0, annualInterestRate: MIN_ANNUAL_INTEREST_RATE, batchManager: address(0), maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(A);
    uint256 troveId = gasCompZapper.openTroveWithRawETH{value: ETH_GAS_COMPENSATION}(params);
    vm.stopPrank();
    uint256 boldBalanceBeforeA = boldToken.balanceOf(A);
    uint256 collBalanceBeforeA = collToken.balanceOf(A);
    uint256 boldBalanceBeforeB = boldToken.balanceOf(B);
    uint256 collBalanceBeforeB = collToken.balanceOf(B);
    vm.startPrank(A);
    gasCompZapper.setRemoveManagerWithReceiver(troveId, B, A);
    vm.stopPrank();
    vm.startPrank(B);
    gasCompZapper.adjustTrove(troveId, collAmount2, false, boldAmount2, true, boldAmount2);
    vm.stopPrank();
    assertEq(troveManager.getTroveEntireColl(troveId), collAmount1 - collAmount2, "Trove coll mismatch");
    assertApproxEqAbs(troveManager.getTroveEntireDebt(troveId), boldAmount1 + boldAmount2, 2e18, "Trove  debt mismatch");
    assertEq(boldToken.balanceOf(A), boldBalanceBeforeA + boldAmount2, "A BOLD bal mismatch");
    assertEq(collToken.balanceOf(A), collBalanceBeforeA + collAmount2, "A Coll bal mismatch");
    assertEq(boldToken.balanceOf(B), boldBalanceBeforeB, "B BOLD bal mismatch");
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
- **IBoldToken::balanceOf(address)**
- **IERC20::balanceOf(address)**
- **GasCompZapper::setRemoveManagerWithReceiver(uint256,address,address)**
- **GasCompZapper::adjustTrove(uint256,uint256,bool,uint256,bool,uint256)**
- **ITroveManagerTester::getTroveEntireColl(uint256)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperGasCompTest.testCanAdjustTroveWithdrawCollAndBold() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [troveManager.getTroveEntireColl(troveId), collAmount1 - collAmount2, "Trove coll mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [troveManager.getTroveEntireDebt(troveId), boldAmount1 + boldAmount2, 2e18, "Trove  debt mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [boldToken.balanceOf(A), boldBalanceBeforeA + boldAmount2, "A BOLD bal mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [collToken.balanceOf(A), collBalanceBeforeA + collAmount2, "A Coll bal mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [boldToken.balanceOf(B), boldBalanceBeforeB, "B BOLD bal mismatch"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
      💬 Args: [collToken.balanceOf(B), collBalanceBeforeB, "B Coll bal mismatch"]
      👁️  Def: internal
```
