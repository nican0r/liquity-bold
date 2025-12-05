# Function: testMultiCollateralRedemption()

**Contract**: [test/multicollateral.t.sol/contract_MulticollateralTest.md]

## Metadata

- **Contract**: MulticollateralTest
- **Signature**: `testMultiCollateralRedemption()`
- **Visibility**: public
- **Source Range**: 5820:5824:311

## Implementation

```solidity
function testMultiCollateralRedemption() public {
    TestValues memory testValues1;
    TestValues memory testValues2;
    TestValues memory testValues3;
    TestValues memory testValues4;
    uint256 redeemAmount = 1600e18;
    testValues1.troveId = openMulticollateralTroveNoHints100pctWithIndex(0, A, 0, 10e18, 10000e18, 5e16);
    testValues2.troveId = openMulticollateralTroveNoHints100pctWithIndex(1, A, 0, 100e18, 10000e18, 5e16);
    makeMulticollateralSPDepositAndClaim(1, A, 5000e18);
    testValues3.troveId = openMulticollateralTroveNoHints100pctWithIndex(2, A, 0, 10e18, 10000e18, 5e16);
    makeMulticollateralSPDepositAndClaim(2, A, 9000e18);
    testValues4.troveId = openMulticollateralTroveNoHints100pctWithIndex(3, A, 0, 10e18, 10000e18, 5e16);
    makeMulticollateralSPDepositAndClaim(3, A, 10000e18);
    vm.warp(block.timestamp + 1 days);
    assertEq(boldToken.balanceOf(A), 16000e18, "Wrong Bold balance before redemption");
    testValues1.collInitialBalance = contractsArray[0].collToken.balanceOf(A);
    testValues2.collInitialBalance = contractsArray[1].collToken.balanceOf(A);
    testValues3.collInitialBalance = contractsArray[2].collToken.balanceOf(A);
    testValues4.collInitialBalance = contractsArray[3].collToken.balanceOf(A);
    testValues1.price = contractsArray[0].priceFeed.getPrice();
    testValues2.price = contractsArray[1].priceFeed.getPrice();
    testValues3.price = contractsArray[2].priceFeed.getPrice();
    testValues4.price = contractsArray[3].priceFeed.getPrice();
    testValues1.unbackedPortion = contractsArray[0].troveManager.getTroveEntireDebt(testValues1.troveId);
    testValues2.unbackedPortion = contractsArray[1].troveManager.getTroveEntireDebt(testValues2.troveId) - 5000e18;
    testValues3.unbackedPortion = contractsArray[2].troveManager.getTroveEntireDebt(testValues3.troveId) - 9000e18;
    testValues4.unbackedPortion = contractsArray[3].troveManager.getTroveEntireDebt(testValues4.troveId) - 10000e18;
    uint256 totalUnbacked = ((testValues1.unbackedPortion + testValues2.unbackedPortion) + testValues3.unbackedPortion) + testValues4.unbackedPortion;
    testValues1.redeemAmount = (redeemAmount * testValues1.unbackedPortion) / totalUnbacked;
    testValues2.redeemAmount = (redeemAmount * testValues2.unbackedPortion) / totalUnbacked;
    testValues3.redeemAmount = (redeemAmount * testValues3.unbackedPortion) / totalUnbacked;
    testValues4.redeemAmount = (redeemAmount * testValues4.unbackedPortion) / totalUnbacked;
    uint256 fee = collateralRegistry.getEffectiveRedemptionFeeInBold(redeemAmount);
    testValues1.fee = (((fee * testValues1.redeemAmount) / redeemAmount) * DECIMAL_PRECISION) / testValues1.price;
    testValues2.fee = (((fee * testValues2.redeemAmount) / redeemAmount) * DECIMAL_PRECISION) / testValues2.price;
    testValues3.fee = (((fee * testValues3.redeemAmount) / redeemAmount) * DECIMAL_PRECISION) / testValues3.price;
    testValues4.fee = (((fee * testValues4.redeemAmount) / redeemAmount) * DECIMAL_PRECISION) / testValues4.price;
    assertApproxEqAbs(collateralRegistry.getRedemptionFeeWithDecay(redeemAmount), (redeemAmount * ((INITIAL_BASE_RATE / 16) + REDEMPTION_FEE_FLOOR)) / DECIMAL_PRECISION, 1e7, "Wrong redemption fee with decay");
    uint256 initialBoldSupply = boldToken.totalSupply();
    redeem(A, redeemAmount);
    assertApproxEqAbs(collateralRegistry.getRedemptionRate(), ((INITIAL_BASE_RATE / 16) + REDEMPTION_FEE_FLOOR) + ((redeemAmount * DECIMAL_PRECISION) / initialBoldSupply), 1e5, "Wrong redemption rate");
    assertApproxEqAbs(boldToken.balanceOf(A), 14400e18, 10, "Wrong Bold balance after redemption");
    testValues1.collFinalBalance = contractsArray[0].collToken.balanceOf(A);
    testValues2.collFinalBalance = contractsArray[1].collToken.balanceOf(A);
    testValues3.collFinalBalance = contractsArray[2].collToken.balanceOf(A);
    testValues4.collFinalBalance = contractsArray[3].collToken.balanceOf(A);
    assertApproxEqAbs(testValues1.collFinalBalance - testValues1.collInitialBalance, ((testValues1.redeemAmount * DECIMAL_PRECISION) / testValues1.price) - testValues1.fee, 1e14, "Wrong Collateral 1 balance");
    assertApproxEqAbs(testValues2.collFinalBalance - testValues2.collInitialBalance, ((testValues2.redeemAmount * DECIMAL_PRECISION) / testValues2.price) - testValues2.fee, 1e14, "Wrong Collateral 2 balance");
    assertApproxEqAbs(testValues3.collFinalBalance - testValues3.collInitialBalance, ((testValues3.redeemAmount * DECIMAL_PRECISION) / testValues3.price) - testValues3.fee, 1e13, "Wrong Collateral 3 balance");
    assertApproxEqAbs(testValues4.collFinalBalance - testValues4.collInitialBalance, ((testValues4.redeemAmount * DECIMAL_PRECISION) / testValues4.price) - testValues4.fee, 1e11, "Wrong Collateral 4 balance");
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

## External Calls

- **Vm::warp(uint256)**
- **IBoldToken::balanceOf(address)**
- **IERC20Metadata::balanceOf(address)**
- **IPriceFeedTestnet::getPrice()**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **ICollateralRegistry::getEffectiveRedemptionFeeInBold(uint256)**
- **ICollateralRegistry::getRedemptionFeeWithDecay(uint256)**
- **IBoldToken::totalSupply()**
- **ICollateralRegistry::getRedemptionRate()**

## State Variable Reads

- **contractsArray** (`struct TestDeployer.LiquityContractsDev[]`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MulticollateralTest.testMultiCollateralRedemption() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MulticollateralTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [0, A, 0, 10e18, 10000e18, 5e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 2)
  │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 3)
  │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MulticollateralTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 4)
  │   💬 Args: [1, A, 0, 100e18, 10000e18, 5e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 5)
  │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 6)
  │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MulticollateralTest.makeMulticollateralSPDepositAndClaim(uint256,address,uint256) (NodeID: 7)
  │   💬 Args: [1, A, 5000e18]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MulticollateralTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 8)
  │   💬 Args: [2, A, 0, 10e18, 10000e18, 5e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 9)
  │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 10)
  │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MulticollateralTest.makeMulticollateralSPDepositAndClaim(uint256,address,uint256) (NodeID: 11)
  │   💬 Args: [2, A, 9000e18]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MulticollateralTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 12)
  │   💬 Args: [3, A, 0, 10e18, 10000e18, 5e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 13)
  │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 14)
  │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MulticollateralTest.makeMulticollateralSPDepositAndClaim(uint256,address,uint256) (NodeID: 15)
  │   💬 Args: [3, A, 10000e18]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 16)
  │   💬 Args: [boldToken.balanceOf(A), 16000e18, "Wrong Bold balance before redemption"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 17)
  │   💬 Args: [collateralRegistry.getRedemptionFeeWithDecay(redeemAmount), (redeemAmount * ((INITIAL_BASE_RATE / 16) + REDEMPTION_FEE_FLOOR)) / DECIMAL_PRECISION, 1e7, "Wrong redemption fee with decay"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.redeem(address,uint256) (NodeID: 18)
  │   💬 Args: [A, redeemAmount]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 19)
  │   💬 Args: [collateralRegistry.getRedemptionRate(), ((INITIAL_BASE_RATE / 16) + REDEMPTION_FEE_FLOOR) + ((redeemAmount * DECIMAL_PRECISION) / initialBoldSupply), 1e5, "Wrong redemption rate"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 20)
  │   💬 Args: [boldToken.balanceOf(A), 14400e18, 10, "Wrong Bold balance after redemption"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 21)
  │   💬 Args: [testValues1.collFinalBalance - testValues1.collInitialBalance, ((testValues1.redeemAmount * DECIMAL_PRECISION) / testValues1.price) - testValues1.fee, 1e14, "Wrong Collateral 1 balance"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 22)
  │   💬 Args: [testValues2.collFinalBalance - testValues2.collInitialBalance, ((testValues2.redeemAmount * DECIMAL_PRECISION) / testValues2.price) - testValues2.fee, 1e14, "Wrong Collateral 2 balance"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 23)
  │   💬 Args: [testValues3.collFinalBalance - testValues3.collInitialBalance, ((testValues3.redeemAmount * DECIMAL_PRECISION) / testValues3.price) - testValues3.fee, 1e13, "Wrong Collateral 3 balance"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 24)
      💬 Args: [testValues4.collFinalBalance - testValues4.collInitialBalance, ((testValues4.redeemAmount * DECIMAL_PRECISION) / testValues4.price) - testValues4.fee, 1e11, "Wrong Collateral 4 balance"]
      👁️  Def: internal
```
