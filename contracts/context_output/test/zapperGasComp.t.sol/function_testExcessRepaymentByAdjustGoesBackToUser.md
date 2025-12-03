# Function: testExcessRepaymentByAdjustGoesBackToUser()

**Contract**: [test/zapperGasComp.t.sol/contract_ZapperGasCompTest.md]

## Metadata

- **Contract**: ZapperGasCompTest
- **Signature**: `testExcessRepaymentByAdjustGoesBackToUser()`
- **Visibility**: external
- **Source Range**: 32062:1822:337

## Implementation

```solidity
function testExcessRepaymentByAdjustGoesBackToUser() external {
    uint256 collAmount = 10 ether;
    uint256 boldAmount = 10000e18;
    IZapper.OpenTroveParams memory params = IZapper.OpenTroveParams({owner: A, ownerIndex: 0, collAmount: collAmount, boldAmount: boldAmount, upperHint: 0, lowerHint: 0, annualInterestRate: MIN_ANNUAL_INTEREST_RATE, batchManager: address(0), maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(A);
    uint256 troveId = gasCompZapper.openTroveWithRawETH{value: ETH_GAS_COMPENSATION}(params);
    vm.stopPrank();
    uint256 ethBalanceBefore = A.balance;
    uint256 collBalanceBefore = collToken.balanceOf(A);
    uint256 boldDebtBefore = troveManager.getTroveEntireDebt(troveId);
    vm.startPrank(A);
    boldToken.approve(address(gasCompZapper), type(uint256).max);
    gasCompZapper.adjustTrove(troveId, 1 ether, false, 9000e18, false, 0);
    vm.stopPrank();
    assertEq(boldToken.balanceOf(A), (boldAmount + MIN_DEBT) - boldDebtBefore, "BOLD bal mismatch");
    assertEq(boldToken.balanceOf(address(gasCompZapper)), 0, "Zapper BOLD bal should be zero");
    assertEq(A.balance, ethBalanceBefore, "ETH bal mismatch");
    assertEq(address(gasCompZapper).balance, 0, "Zapper ETH bal should be zero");
    assertEq(collToken.balanceOf(A), collBalanceBefore + 1 ether, "Coll bal mismatch");
    assertEq(collToken.balanceOf(address(gasCompZapper)), 0, "Zapper Coll bal should be zero");
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
- **IERC20::balanceOf(address)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **IBoldToken::approve(address,uint256)**
- **GasCompZapper::adjustTrove(uint256,uint256,bool,uint256,bool,uint256)**
- **IBoldToken::balanceOf(address)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperGasCompTest.testExcessRepaymentByAdjustGoesBackToUser() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [boldToken.balanceOf(A), (boldAmount + MIN_DEBT) - boldDebtBefore, "BOLD bal mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [boldToken.balanceOf(address(gasCompZapper)), 0, "Zapper BOLD bal should be zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [A.balance, ethBalanceBefore, "ETH bal mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [address(gasCompZapper).balance, 0, "Zapper ETH bal should be zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [collToken.balanceOf(A), collBalanceBefore + 1 ether, "Coll bal mismatch"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
      💬 Args: [collToken.balanceOf(address(gasCompZapper)), 0, "Zapper Coll bal should be zero"]
      👁️  Def: internal
```
