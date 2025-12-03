# Function: testExcessRepaymentByRepayGoesBackToUser()

**Contract**: [test/zapperWETH.t.sol/contract_ZapperWETHTest.md]

## Metadata

- **Contract**: ZapperWETHTest
- **Signature**: `testExcessRepaymentByRepayGoesBackToUser()`
- **Visibility**: external
- **Source Range**: 35102:1636:339

## Implementation

```solidity
function testExcessRepaymentByRepayGoesBackToUser() external {
    uint256 ethAmount = 10 ether;
    uint256 boldAmount = 10000e18;
    IZapper.OpenTroveParams memory params = IZapper.OpenTroveParams({owner: A, ownerIndex: 0, collAmount: 0, boldAmount: boldAmount, upperHint: 0, lowerHint: 0, annualInterestRate: MIN_ANNUAL_INTEREST_RATE, batchManager: address(0), maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(A);
    uint256 troveId = wethZapper.openTroveWithRawETH{value: ethAmount + ETH_GAS_COMPENSATION}(params);
    vm.stopPrank();
    uint256 boldDebtBefore = troveManager.getTroveEntireDebt(troveId);
    uint256 collBalanceBefore = WETH.balanceOf(A);
    vm.startPrank(A);
    boldToken.approve(address(wethZapper), type(uint256).max);
    wethZapper.repayBold(troveId, 9000e18);
    vm.stopPrank();
    assertEq(boldToken.balanceOf(A), (boldAmount + MIN_DEBT) - boldDebtBefore, "BOLD bal mismatch");
    assertEq(boldToken.balanceOf(address(wethZapper)), 0, "Zapper BOLD bal should be zero");
    assertEq(address(wethZapper).balance, 0, "Zapper ETH bal should be zero");
    assertEq(WETH.balanceOf(A), collBalanceBefore, "Coll bal mismatch");
    assertEq(WETH.balanceOf(address(wethZapper)), 0, "Zapper Coll bal should be zero");
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

## External Calls

- **Vm::startPrank(address)**
- **unknown::unknown**
- **Vm::stopPrank()**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **IWETH::balanceOf(address)**
- **IBoldToken::approve(address,uint256)**
- **WETHZapper::repayBold(uint256,uint256)**
- **IBoldToken::balanceOf(address)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperWETHTest.testExcessRepaymentByRepayGoesBackToUser() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [boldToken.balanceOf(A), (boldAmount + MIN_DEBT) - boldDebtBefore, "BOLD bal mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [boldToken.balanceOf(address(wethZapper)), 0, "Zapper BOLD bal should be zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [address(wethZapper).balance, 0, "Zapper ETH bal should be zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [WETH.balanceOf(A), collBalanceBefore, "Coll bal mismatch"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
      💬 Args: [WETH.balanceOf(address(wethZapper)), 0, "Zapper Coll bal should be zero"]
      👁️  Def: internal
```
