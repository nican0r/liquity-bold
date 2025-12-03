# Function: testMultiCollRedemptionIncreasesRedeemerETHBalanceByCorrespondingETHLessTheETHFee()

**Contract**: [test/multicollateral.t.sol/contract_MulticollateralTest.md]

## Metadata

- **Contract**: MulticollateralTest
- **Signature**: `testMultiCollRedemptionIncreasesRedeemerETHBalanceByCorrespondingETHLessTheETHFee()`
- **Visibility**: public
- **Source Range**: 19178:5350:311

## Implementation

```solidity
function testMultiCollRedemptionIncreasesRedeemerETHBalanceByCorrespondingETHLessTheETHFee() public {
    TestValues memory testValues0;
    TestValues memory testValues1;
    TestValues memory testValues2;
    TestValues memory testValues3;
    uint256 boldAmount = 100000e18;
    testValues0.spBoldAmount = boldAmount / 2;
    testValues1.spBoldAmount = boldAmount / 4;
    testValues2.spBoldAmount = boldAmount / 8;
    testValues3.spBoldAmount = boldAmount / 16;
    uint256 redemptionFraction = 25e16;
    testValues0.price = contractsArray[0].priceFeed.getPrice();
    testValues1.price = contractsArray[1].priceFeed.getPrice();
    testValues2.price = contractsArray[2].priceFeed.getPrice();
    testValues3.price = contractsArray[3].priceFeed.getPrice();
    openMulticollateralTroveNoHints100pctWithIndex(0, A, 0, 100e18, boldAmount, 5e16);
    makeMulticollateralSPDepositAndClaim(0, A, testValues0.spBoldAmount);
    openMulticollateralTroveNoHints100pctWithIndex(1, A, 0, 1000e18, boldAmount, 5e16);
    makeMulticollateralSPDepositAndClaim(1, A, testValues1.spBoldAmount);
    openMulticollateralTroveNoHints100pctWithIndex(2, A, 0, 100e18, boldAmount, 5e16);
    makeMulticollateralSPDepositAndClaim(2, A, testValues2.spBoldAmount);
    openMulticollateralTroveNoHints100pctWithIndex(3, A, 0, 100e18, boldAmount, 5e16);
    makeMulticollateralSPDepositAndClaim(3, A, testValues3.spBoldAmount);
    uint256 boldBalance = boldToken.balanceOf(A);
    uint256 redeemAmount = (boldBalance * redemptionFraction) / DECIMAL_PRECISION;
    uint256 expectedFeePct = (collateralRegistry.getEffectiveRedemptionFeeInBold(redeemAmount) * DECIMAL_PRECISION) / redeemAmount;
    assertGt(expectedFeePct, 0);
    testValues0.branchDebt = contractsArray[0].troveManager.getEntireBranchDebt();
    testValues1.branchDebt = contractsArray[1].troveManager.getEntireBranchDebt();
    testValues2.branchDebt = contractsArray[2].troveManager.getEntireBranchDebt();
    testValues3.branchDebt = contractsArray[3].troveManager.getEntireBranchDebt();
    testValues0.collTokenBalBefore_A = contractsArray[0].collToken.balanceOf(A);
    testValues1.collTokenBalBefore_A = contractsArray[1].collToken.balanceOf(A);
    testValues2.collTokenBalBefore_A = contractsArray[2].collToken.balanceOf(A);
    testValues3.collTokenBalBefore_A = contractsArray[3].collToken.balanceOf(A);
    redeem(A, redeemAmount);
    testValues0.redeemed = testValues0.branchDebt - contractsArray[0].troveManager.getEntireBranchDebt();
    testValues1.redeemed = testValues1.branchDebt - contractsArray[1].troveManager.getEntireBranchDebt();
    testValues2.redeemed = testValues2.branchDebt - contractsArray[2].troveManager.getEntireBranchDebt();
    testValues3.redeemed = testValues3.branchDebt - contractsArray[3].troveManager.getEntireBranchDebt();
    assertGt(testValues0.redeemed, 0);
    assertGt(testValues1.redeemed, 0);
    assertGt(testValues2.redeemed, 0);
    assertGt(testValues3.redeemed, 0);
    testValues0.correspondingETH = (testValues0.redeemed * DECIMAL_PRECISION) / testValues0.price;
    testValues1.correspondingETH = (testValues1.redeemed * DECIMAL_PRECISION) / testValues1.price;
    testValues2.correspondingETH = (testValues2.redeemed * DECIMAL_PRECISION) / testValues2.price;
    testValues3.correspondingETH = (testValues3.redeemed * DECIMAL_PRECISION) / testValues3.price;
    testValues0.ETHFee = (testValues0.correspondingETH * expectedFeePct) / DECIMAL_PRECISION;
    testValues1.ETHFee = (testValues1.correspondingETH * expectedFeePct) / DECIMAL_PRECISION;
    testValues2.ETHFee = (testValues2.correspondingETH * expectedFeePct) / DECIMAL_PRECISION;
    testValues3.ETHFee = (testValues3.correspondingETH * expectedFeePct) / DECIMAL_PRECISION;
    assertGt(testValues0.ETHFee, 0);
    assertGt(testValues1.ETHFee, 0);
    assertGt(testValues2.ETHFee, 0);
    assertGt(testValues3.ETHFee, 0);
    assertApproxEqAbs(contractsArray[0].collToken.balanceOf(A) - testValues0.collTokenBalBefore_A, testValues0.correspondingETH - testValues0.ETHFee, 20);
    assertApproxEqAbs(contractsArray[1].collToken.balanceOf(A) - testValues1.collTokenBalBefore_A, testValues1.correspondingETH - testValues1.ETHFee, 100);
    assertApproxEqAbs(contractsArray[2].collToken.balanceOf(A) - testValues2.collTokenBalBefore_A, testValues2.correspondingETH - testValues2.ETHFee, 20);
    assertApproxEqAbs(contractsArray[3].collToken.balanceOf(A) - testValues3.collTokenBalBefore_A, testValues3.correspondingETH - testValues3.ETHFee, 20);
}
```

## Related Implementations

### openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 325:1098:311
- **Link**: `test/multicollateral.t.sol:MulticollateralTest:openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256)`

```solidity
function openMulticollateralTroveNoHints100pctWithIndex(uint256 _collIndex, address _account, uint256 _index, uint256 _coll, uint256 _boldAmount, uint256 _annualInterestRate) public returns (uint256 troveId) {
    TroveChange memory troveChange;
    troveChange.debtIncrease = _boldAmount;
    troveChange.newWeightedRecordedDebt = troveChange.debtIncrease * _annualInterestRate;
    uint256 avgInterestRate = contractsArray[_collIndex].activePool.getNewApproxAvgInterestRateFromTroveChange(troveChange);
    uint256 upfrontFee = calcUpfrontFee(troveChange.debtIncrease, avgInterestRate);
    vm.startPrank(_account);
    troveId = contractsArray[_collIndex].borrowerOperations.openTrove(_account, _index, _coll, _boldAmount, 0, 0, _annualInterestRate, upfrontFee, address(0), address(0), address(0));
    vm.stopPrank();
}
```

### calcUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 3360:180:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:calcUpfrontFee(uint256,uint256)`

```solidity
function calcUpfrontFee(uint256 debt, uint256 avgInterestRate) internal pure returns (uint256) {
    return calcInterest(debt * avgInterestRate, UPFRONT_INTEREST_PERIOD);
}
```

### calcInterest(uint256,uint256)

- **Kind**: internal
- **Source**: 3170:184:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:calcInterest(uint256,uint256)`

```solidity
function calcInterest(uint256 weightedRecordedDebt, uint256 period) internal pure returns (uint256) {
    return ((weightedRecordedDebt * period) / 365 days) / DECIMAL_PRECISION;
}
```

### makeMulticollateralSPDepositAndClaim(uint256,address,uint256)

- **Kind**: internal
- **Source**: 1429:249:311
- **Link**: `test/multicollateral.t.sol:MulticollateralTest:makeMulticollateralSPDepositAndClaim(uint256,address,uint256)`

```solidity
function makeMulticollateralSPDepositAndClaim(uint256 _collIndex, address _account, uint256 _amount) public {
    vm.startPrank(_account);
    contractsArray[_collIndex].stabilityPool.provideToSP(_amount, true);
    vm.stopPrank();
}
```

### assertGt(uint256,uint256)

- **Kind**: internal
- **Source**: 13112:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256)`

```solidity
function assertGt(uint256 left, uint256 right) virtual internal pure {
    vm.assertGt(left, right);
}
```

### redeem(address,uint256)

- **Kind**: internal
- **Source**: 13971:197:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:redeem(address,uint256)`

```solidity
function redeem(address _from, uint256 _boldAmount) public {
    vm.startPrank(_from);
    collateralRegistry.redeemCollateral(_boldAmount, MAX_UINT256, 1e18);
    vm.stopPrank();
}
```

### assertApproxEqAbs(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 16664:156:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqAbs(uint256,uint256,uint256)`

```solidity
function assertApproxEqAbs(uint256 left, uint256 right, uint256 maxDelta) virtual internal pure {
    vm.assertApproxEqAbs(left, right, maxDelta);
}
```

## External Calls

- **IPriceFeedTestnet::getPrice()**
- **IBoldToken::balanceOf(address)**
- **ICollateralRegistry::getEffectiveRedemptionFeeInBold(uint256)**
- **ITroveManagerTester::getEntireBranchDebt()**
- **IERC20Metadata::balanceOf(address)**

## State Variable Reads

- **contractsArray** (`struct TestDeployer.LiquityContractsDev[]`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MulticollateralTest.testMultiCollRedemptionIncreasesRedeemerETHBalanceByCorrespondingETHLessTheETHFee() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MulticollateralTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [0, A, 0, 100e18, boldAmount, 5e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 2)
  │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 3)
  │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MulticollateralTest.makeMulticollateralSPDepositAndClaim(uint256,address,uint256) (NodeID: 4)
  │   💬 Args: [0, A, testValues0.spBoldAmount]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MulticollateralTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 5)
  │   💬 Args: [1, A, 0, 1000e18, boldAmount, 5e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 6)
  │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 7)
  │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MulticollateralTest.makeMulticollateralSPDepositAndClaim(uint256,address,uint256) (NodeID: 8)
  │   💬 Args: [1, A, testValues1.spBoldAmount]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MulticollateralTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 9)
  │   💬 Args: [2, A, 0, 100e18, boldAmount, 5e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 10)
  │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 11)
  │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MulticollateralTest.makeMulticollateralSPDepositAndClaim(uint256,address,uint256) (NodeID: 12)
  │   💬 Args: [2, A, testValues2.spBoldAmount]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MulticollateralTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 13)
  │   💬 Args: [3, A, 0, 100e18, boldAmount, 5e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 14)
  │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 15)
  │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MulticollateralTest.makeMulticollateralSPDepositAndClaim(uint256,address,uint256) (NodeID: 16)
  │   💬 Args: [3, A, testValues3.spBoldAmount]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 17)
  │   💬 Args: [expectedFeePct, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.redeem(address,uint256) (NodeID: 18)
  │   💬 Args: [A, redeemAmount]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 19)
  │   💬 Args: [testValues0.redeemed, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 20)
  │   💬 Args: [testValues1.redeemed, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 21)
  │   💬 Args: [testValues2.redeemed, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 22)
  │   💬 Args: [testValues3.redeemed, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 23)
  │   💬 Args: [testValues0.ETHFee, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 24)
  │   💬 Args: [testValues1.ETHFee, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 25)
  │   💬 Args: [testValues2.ETHFee, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 26)
  │   💬 Args: [testValues3.ETHFee, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256) (NodeID: 27)
  │   💬 Args: [contractsArray[0].collToken.balanceOf(A) - testValues0.collTokenBalBefore_A, testValues0.correspondingETH - testValues0.ETHFee, 20]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256) (NodeID: 28)
  │   💬 Args: [contractsArray[1].collToken.balanceOf(A) - testValues1.collTokenBalBefore_A, testValues1.correspondingETH - testValues1.ETHFee, 100]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256) (NodeID: 29)
  │   💬 Args: [contractsArray[2].collToken.balanceOf(A) - testValues2.collTokenBalBefore_A, testValues2.correspondingETH - testValues2.ETHFee, 20]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256) (NodeID: 30)
      💬 Args: [contractsArray[3].collToken.balanceOf(A) - testValues3.collTokenBalBefore_A, testValues3.correspondingETH - testValues3.ETHFee, 20]
      👁️  Def: internal
```
