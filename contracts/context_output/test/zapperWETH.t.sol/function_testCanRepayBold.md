# Function: testCanRepayBold()

**Contract**: [test/zapperWETH.t.sol/contract_ZapperWETHTest.md]

## Metadata

- **Contract**: ZapperWETHTest
- **Signature**: `testCanRepayBold()`
- **Visibility**: external
- **Source Range**: 10530:2022:339

## Implementation

```solidity
function testCanRepayBold() external {
    uint256 ethAmount = 10 ether;
    uint256 boldAmount1 = 10000e18;
    uint256 boldAmount2 = 1000e18;
    IZapper.OpenTroveParams memory params = IZapper.OpenTroveParams({owner: A, ownerIndex: 0, collAmount: 0, boldAmount: boldAmount1, upperHint: 0, lowerHint: 0, annualInterestRate: MIN_ANNUAL_INTEREST_RATE, batchManager: address(0), maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(A);
    uint256 troveId = wethZapper.openTroveWithRawETH{value: ethAmount + ETH_GAS_COMPENSATION}(params);
    vm.stopPrank();
    uint256 boldBalanceBeforeA = boldToken.balanceOf(A);
    uint256 ethBalanceBeforeA = A.balance;
    uint256 boldBalanceBeforeB = boldToken.balanceOf(B);
    uint256 ethBalanceBeforeB = B.balance;
    vm.startPrank(A);
    wethZapper.setRemoveManagerWithReceiver(troveId, B, A);
    boldToken.transfer(B, boldAmount2);
    vm.stopPrank();
    vm.startPrank(B);
    boldToken.approve(address(wethZapper), boldAmount2);
    wethZapper.repayBold(troveId, boldAmount2);
    vm.stopPrank();
    assertEq(troveManager.getTroveEntireColl(troveId), ethAmount, "Trove coll mismatch");
    assertApproxEqAbs(troveManager.getTroveEntireDebt(troveId), boldAmount1 - boldAmount2, 2e18, "Trove  debt mismatch");
    assertEq(boldToken.balanceOf(A), boldBalanceBeforeA - boldAmount2, "A BOLD bal mismatch");
    assertEq(A.balance, ethBalanceBeforeA, "A ETH bal mismatch");
    assertEq(boldToken.balanceOf(B), boldBalanceBeforeB, "B BOLD bal mismatch");
    assertEq(B.balance, ethBalanceBeforeB, "B ETH bal mismatch");
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
- **WETHZapper::setRemoveManagerWithReceiver(uint256,address,address)**
- **IBoldToken::transfer(address,uint256)**
- **IBoldToken::approve(address,uint256)**
- **WETHZapper::repayBold(uint256,uint256)**
- **ITroveManagerTester::getTroveEntireColl(uint256)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**

## Native Transfers

- **boldToken** (computed)

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperWETHTest.testCanRepayBold() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [troveManager.getTroveEntireColl(troveId), ethAmount, "Trove coll mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [troveManager.getTroveEntireDebt(troveId), boldAmount1 - boldAmount2, 2e18, "Trove  debt mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [boldToken.balanceOf(A), boldBalanceBeforeA - boldAmount2, "A BOLD bal mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [A.balance, ethBalanceBeforeA, "A ETH bal mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [boldToken.balanceOf(B), boldBalanceBeforeB, "B BOLD bal mismatch"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
      💬 Args: [B.balance, ethBalanceBeforeB, "B ETH bal mismatch"]
      👁️  Def: internal
```
