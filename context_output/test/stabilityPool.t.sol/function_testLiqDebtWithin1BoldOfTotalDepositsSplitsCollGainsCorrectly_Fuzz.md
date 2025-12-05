# Function: testLiqDebtWithin1BoldOfTotalDepositsSplitsCollGainsCorrectly_Fuzz()

**Contract**: [test/stabilityPool.t.sol/contract_SPTest.md]

## Metadata

- **Contract**: SPTest
- **Signature**: `testLiqDebtWithin1BoldOfTotalDepositsSplitsCollGainsCorrectly_Fuzz()`
- **Visibility**: public
- **Source Range**: 92800:3132:334

## Implementation

```solidity
function testLiqDebtWithin1BoldOfTotalDepositsSplitsCollGainsCorrectly_Fuzz() public {
    LiqTestVars memory vars;
    uint256 _toRedist = 5e17;
    uint256 rate = 5e16;
    priceFeed.setPrice(3000e18);
    uint256 toSP = 5000e18;
    uint256 troveIdA = openTroveNoHints100pct(A, 5 ether, toSP, rate);
    vars.debtABefore = troveManager.getTroveEntireDebt(troveIdA);
    vars.collABefore = troveManager.getTroveEntireColl(troveIdA);
    uint256 B_targetDebt = (toSP - 1e18) + _toRedist;
    (uint256 B_borrow, ) = findAmountToBorrowWithOpenTrove(B_targetDebt, rate);
    uint256 troveIdB = openTroveNoHints100pct(B, 5 ether, B_borrow, rate);
    vars.debtBBefore = troveManager.getTroveEntireDebt(troveIdB);
    vars.collBBefore = troveManager.getTroveEntireColl(troveIdB);
    makeSPDepositNoClaim(A, toSP);
    assertLt(stabilityPool.getTotalBoldDeposits() - vars.debtBBefore, 1e18);
    priceFeed.setPrice(300e18);
    vars.collCBefore = collToken.balanceOf(C);
    liquidate(C, troveIdB);
    uint256 liqDebtOffset = vars.debtBBefore - _toRedist;
    assertApproximatelyEqual(troveManager.getTroveEntireDebt(troveIdA), vars.debtABefore + _toRedist, 1e3, "Incorrect debt increase trove A");
    uint256 collToOffset = (vars.collBBefore * liqDebtOffset) / vars.debtBBefore;
    vars.collGasComp = collToOffset / 200;
    assertEq(collToken.balanceOf(C), (vars.collCBefore + vars.collGasComp) + 375e14, "Incorrect coll increase C");
    vars.spCollBalAfter = stabilityPool.getCollBalance();
    vars.collToGiveToSP = collToOffset - vars.collGasComp;
    vars.collToRedist = vars.collBBefore - collToOffset;
    assertApproxEqAbs(vars.spCollBalAfter - vars.spCollBalBefore, vars.collToGiveToSP, 10, "Incorrect coll in SP");
    assertApproxEqAbs(troveManager.getTroveEntireColl(troveIdA) - vars.collABefore, vars.collToRedist, 10, "Incorrect coll to A");
}
```

## Related Implementations

### openTroveNoHints100pct(address,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 6736:267:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:openTroveNoHints100pct(address,uint256,uint256,uint256)`

```solidity
function openTroveNoHints100pct(address _account, uint256 _coll, uint256 _boldAmount, uint256 _annualInterestRate) public returns (uint256 troveId) {
    (troveId, ) = openTroveHelper(_account, 0, _coll, _boldAmount, _annualInterestRate);
}
```

### openTroveHelper(address,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 7338:704:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:openTroveHelper(address,uint256,uint256,uint256,uint256)`

```solidity
function openTroveHelper(address _account, uint256 _index, uint256 _coll, uint256 _boldAmount, uint256 _annualInterestRate) public returns (uint256 troveId, uint256 upfrontFee) {
    upfrontFee = predictOpenTroveUpfrontFee(_boldAmount, _annualInterestRate);
    vm.startPrank(_account);
    troveId = borrowerOperations.openTrove(_account, _index, _coll, _boldAmount, 0, 0, _annualInterestRate, upfrontFee, address(0), address(0), address(0));
    vm.stopPrank();
}
```

### predictOpenTroveUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 3546:209:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:predictOpenTroveUpfrontFee(uint256,uint256)`

```solidity
function predictOpenTroveUpfrontFee(uint256 borrowedAmount, uint256 interestRate) internal view returns (uint256) {
    return hintHelpers.predictOpenTroveUpfrontFee(0, borrowedAmount, interestRate);
}
```

### findAmountToBorrowWithOpenTrove(uint256,uint256)

- **Kind**: internal
- **Source**: 4817:815:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:findAmountToBorrowWithOpenTrove(uint256,uint256)`

```solidity
function findAmountToBorrowWithOpenTrove(uint256 targetDebt, uint256 interestRate) internal view returns (uint256 borrow, uint256 upfrontFee) {
    uint256 borrowRight = targetDebt;
    upfrontFee = predictOpenTroveUpfrontFee(borrowRight, interestRate);
    uint256 borrowLeft = borrowRight - upfrontFee;
    for (uint256 i = 0; i < 256; ++i) {
        borrow = (borrowLeft + borrowRight) / 2;
        upfrontFee = predictOpenTroveUpfrontFee(borrow, interestRate);
        uint256 actualDebt = borrow + upfrontFee;
        if (actualDebt == targetDebt) {
            break;
        } else if (actualDebt < targetDebt) {
            borrowLeft = borrow;
        } else {
            borrowRight = borrow;
        }
    }
}
```

### makeSPDepositNoClaim(address,uint256)

- **Kind**: internal
- **Source**: 11348:187:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:makeSPDepositNoClaim(address,uint256)`

```solidity
function makeSPDepositNoClaim(address _account, uint256 _amount) public {
    vm.startPrank(_account);
    stabilityPool.provideToSP(_amount, false);
    vm.stopPrank();
}
```

### assertLt(uint256,uint256)

- **Kind**: internal
- **Source**: 11928:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLt(uint256,uint256)`

```solidity
function assertLt(uint256 left, uint256 right) virtual internal pure {
    vm.assertLt(left, right);
}
```

### liquidate(address,uint256)

- **Kind**: internal
- **Source**: 13598:162:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:liquidate(address,uint256)`

```solidity
function liquidate(address _from, uint256 _troveId) public {
    vm.startPrank(_from);
    troveManager.liquidate(_troveId);
    vm.stopPrank();
}
```

### assertApproximatelyEqual(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 20170:170:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:assertApproximatelyEqual(uint256,uint256,uint256,string)`

```solidity
function assertApproximatelyEqual(uint256 _x, uint256 _y, uint256 _margin, string memory _reason) public pure {
    assertApproxEqAbs(_x, _y, _margin, _reason);
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

- **IPriceFeedTestnet::setPrice(uint256)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **ITroveManagerTester::getTroveEntireColl(uint256)**
- **IStabilityPool::getTotalBoldDeposits()**
- **IERC20::balanceOf(address)**
- **IStabilityPool::getCollBalance()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **troveManager** (`contract ITroveManagerTester`) [test/TestContracts/Interfaces/ITroveManagerTester.sol/interface_ITroveManagerTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SPTest.testLiqDebtWithin1BoldOfTotalDepositsSplitsCollGainsCorrectly_Fuzz() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [A, 5 ether, toSP, rate]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 4)
  │   💬 Args: [B_targetDebt, rate]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 5)
  │ │   💬 Args: [borrowRight, interestRate]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 6)
  │     💬 Args: [borrow, interestRate]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 7)
  │   💬 Args: [B, 5 ether, B_borrow, rate]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 8)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 9)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositNoClaim(address,uint256) (NodeID: 10)
  │   💬 Args: [A, toSP]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 11)
  │   💬 Args: [stabilityPool.getTotalBoldDeposits() - vars.debtBBefore, 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.liquidate(address,uint256) (NodeID: 12)
  │   💬 Args: [C, troveIdB]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256,string) (NodeID: 13)
  │   💬 Args: [troveManager.getTroveEntireDebt(troveIdA), vars.debtABefore + _toRedist, 1e3, "Incorrect debt increase trove A"]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 14)
  │     💬 Args: [_x, _y, _margin, _reason]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 15)
  │   💬 Args: [collToken.balanceOf(C), (vars.collCBefore + vars.collGasComp) + 375e14, "Incorrect coll increase C"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 16)
  │   💬 Args: [vars.spCollBalAfter - vars.spCollBalBefore, vars.collToGiveToSP, 10, "Incorrect coll in SP"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 17)
      💬 Args: [troveManager.getTroveEntireColl(troveIdA) - vars.collABefore, vars.collToRedist, 10, "Incorrect coll to A"]
      👁️  Def: internal
```
