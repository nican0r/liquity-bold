# Function: testCanAdjustTroveAddCollAndBold()

**Contract**: [test/zapperWETH.t.sol/contract_ZapperWETHTest.md]

## Metadata

- **Contract**: ZapperWETHTest
- **Signature**: `testCanAdjustTroveAddCollAndBold()`
- **Visibility**: external
- **Source Range**: 19405:2177:339

## Implementation

```solidity
function testCanAdjustTroveAddCollAndBold() external {
    uint256 ethAmount1 = 10 ether;
    uint256 ethAmount2 = 1 ether;
    uint256 boldAmount1 = 10000e18;
    uint256 boldAmount2 = 1000e18;
    IZapper.OpenTroveParams memory params = IZapper.OpenTroveParams({owner: A, ownerIndex: 0, collAmount: 0, boldAmount: boldAmount1, upperHint: 0, lowerHint: 0, annualInterestRate: MIN_ANNUAL_INTEREST_RATE, batchManager: address(0), maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(A);
    uint256 troveId = wethZapper.openTroveWithRawETH{value: ethAmount1 + ETH_GAS_COMPENSATION}(params);
    boldToken.transfer(B, boldAmount2);
    vm.stopPrank();
    uint256 boldBalanceBeforeA = boldToken.balanceOf(A);
    uint256 ethBalanceBeforeA = A.balance;
    uint256 boldBalanceBeforeB = boldToken.balanceOf(B);
    uint256 ethBalanceBeforeB = B.balance;
    vm.startPrank(A);
    wethZapper.setAddManager(troveId, B);
    vm.stopPrank();
    vm.startPrank(B);
    boldToken.approve(address(wethZapper), boldAmount2);
    wethZapper.adjustTroveWithRawETH{value: ethAmount2}(troveId, ethAmount2, true, boldAmount2, false, boldAmount2);
    vm.stopPrank();
    assertEq(troveManager.getTroveEntireColl(troveId), ethAmount1 + ethAmount2, "Trove coll mismatch");
    assertApproxEqAbs(troveManager.getTroveEntireDebt(troveId), boldAmount1 - boldAmount2, 2e18, "Trove  debt mismatch");
    assertEq(boldToken.balanceOf(A), boldBalanceBeforeA, "A BOLD bal mismatch");
    assertEq(A.balance, ethBalanceBeforeA, "A ETH bal mismatch");
    assertEq(boldToken.balanceOf(B), boldBalanceBeforeB - boldAmount2, "B BOLD bal mismatch");
    assertEq(B.balance, ethBalanceBeforeB - ethAmount2, "B ETH bal mismatch");
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
- **IBoldToken::transfer(address,uint256)**
- **Vm::stopPrank()**
- **IBoldToken::balanceOf(address)**
- **WETHZapper::setAddManager(uint256,address)**
- **IBoldToken::approve(address,uint256)**
- **ITroveManagerTester::getTroveEntireColl(uint256)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**

## Native Transfers

- **boldToken** (computed)

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperWETHTest.testCanAdjustTroveAddCollAndBold() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [troveManager.getTroveEntireColl(troveId), ethAmount1 + ethAmount2, "Trove coll mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [troveManager.getTroveEntireDebt(troveId), boldAmount1 - boldAmount2, 2e18, "Trove  debt mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [boldToken.balanceOf(A), boldBalanceBeforeA, "A BOLD bal mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [A.balance, ethBalanceBeforeA, "A ETH bal mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [boldToken.balanceOf(B), boldBalanceBeforeB - boldAmount2, "B BOLD bal mismatch"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
      💬 Args: [B.balance, ethBalanceBeforeB - ethAmount2, "B ETH bal mismatch"]
      👁️  Def: internal
```
