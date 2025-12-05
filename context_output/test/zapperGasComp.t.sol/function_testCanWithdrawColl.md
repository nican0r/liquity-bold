# Function: testCanWithdrawColl()

**Contract**: [test/zapperGasComp.t.sol/contract_ZapperGasCompTest.md]

## Metadata

- **Contract**: ZapperGasCompTest
- **Signature**: `testCanWithdrawColl()`
- **Visibility**: external
- **Source Range**: 7713:1328:337

## Implementation

```solidity
function testCanWithdrawColl() external {
    uint256 collAmount1 = 10 ether;
    uint256 boldAmount = 10000e18;
    uint256 collAmount2 = 1 ether;
    IZapper.OpenTroveParams memory params = IZapper.OpenTroveParams({owner: A, ownerIndex: 0, collAmount: collAmount1, boldAmount: boldAmount, upperHint: 0, lowerHint: 0, annualInterestRate: 5e16, batchManager: address(0), maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(A);
    uint256 troveId = gasCompZapper.openTroveWithRawETH{value: ETH_GAS_COMPENSATION}(params);
    vm.stopPrank();
    uint256 collBalanceBefore = collToken.balanceOf(A);
    vm.startPrank(A);
    gasCompZapper.withdrawColl(troveId, collAmount2);
    vm.stopPrank();
    assertEq(troveManager.getTroveEntireColl(troveId), collAmount1 - collAmount2, "Coll mismatch");
    assertGt(troveManager.getTroveEntireDebt(troveId), boldAmount, "Debt mismatch");
    assertEq(boldToken.balanceOf(A), boldAmount, "BOLD bal mismatch");
    assertEq(collToken.balanceOf(A), collBalanceBefore + collAmount2, "Coll bal mismatch");
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

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 13228:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertGt(left, right, err);
}
```

## External Calls

- **Vm::startPrank(address)**
- **unknown::unknown**
- **Vm::stopPrank()**
- **IERC20::balanceOf(address)**
- **GasCompZapper::withdrawColl(uint256,uint256)**
- **ITroveManagerTester::getTroveEntireColl(uint256)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **IBoldToken::balanceOf(address)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperGasCompTest.testCanWithdrawColl() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [troveManager.getTroveEntireColl(troveId), collAmount1 - collAmount2, "Coll mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [troveManager.getTroveEntireDebt(troveId), boldAmount, "Debt mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [boldToken.balanceOf(A), boldAmount, "BOLD bal mismatch"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
      💬 Args: [collToken.balanceOf(A), collBalanceBefore + collAmount2, "Coll bal mismatch"]
      👁️  Def: internal
```
