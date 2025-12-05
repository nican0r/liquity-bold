# Function: testMultiCollateralRedemptionMaxSPAmount()

**Contract**: [test/multicollateral.t.sol/contract_MulticollateralTest.md]

## Metadata

- **Contract**: MulticollateralTest
- **Signature**: `testMultiCollateralRedemptionMaxSPAmount()`
- **Visibility**: public
- **Source Range**: 12542:377:311

## Implementation

```solidity
function testMultiCollateralRedemptionMaxSPAmount() public {
    uint256 boldAmount = 10000e18;
    uint256 minBoldBalance = 1;
    _testMultiCollateralRedemption(boldAmount, boldAmount, boldAmount, boldAmount, boldAmount - minBoldBalance, DECIMAL_PRECISION / minBoldBalance);
}
```

## Related Implementations

### _testMultiCollateralRedemption(uint256,uint256,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 12925:6247:311
- **Link**: `test/multicollateral.t.sol:MulticollateralTest:_testMultiCollateralRedemption(uint256,uint256,uint256,uint256,uint256,uint256)`

```solidity
function _testMultiCollateralRedemption(uint256 _boldAmount, uint256 _spBoldAmount1, uint256 _spBoldAmount2, uint256 _spBoldAmount3, uint256 _spBoldAmount4, uint256 _redemptionFraction) internal {
    TestValues memory testValues1;
    TestValues memory testValues2;
    TestValues memory testValues3;
    TestValues memory testValues4;
    testValues1.price = contractsArray[0].priceFeed.getPrice();
    testValues2.price = contractsArray[1].priceFeed.getPrice();
    testValues3.price = contractsArray[2].priceFeed.getPrice();
    testValues4.price = contractsArray[3].priceFeed.getPrice();
    openMulticollateralTroveNoHints100pctWithIndex(0, A, 0, 10e18, _boldAmount, 5e16);
    if (_spBoldAmount1 > 0) makeMulticollateralSPDepositAndClaim(0, A, _spBoldAmount1);
    testValues2.troveId = openMulticollateralTroveNoHints100pctWithIndex(1, A, 0, 100e18, _boldAmount, 5e16);
    if (_spBoldAmount2 > 0) makeMulticollateralSPDepositAndClaim(1, A, _spBoldAmount2);
    openMulticollateralTroveNoHints100pctWithIndex(2, A, 0, 10e18, _boldAmount, 5e16);
    if (_spBoldAmount3 > 0) makeMulticollateralSPDepositAndClaim(2, A, _spBoldAmount3);
    openMulticollateralTroveNoHints100pctWithIndex(3, A, 0, 10e18, _boldAmount, 5e16);
    if (_spBoldAmount4 > 0) makeMulticollateralSPDepositAndClaim(3, A, _spBoldAmount4);
    uint256 boldBalance = boldToken.balanceOf(A);
    uint256 redeemAmount = (boldBalance * _redemptionFraction) / DECIMAL_PRECISION;
    testValues1.collInitialBalance = contractsArray[0].collToken.balanceOf(A);
    testValues2.collInitialBalance = contractsArray[1].collToken.balanceOf(A);
    testValues3.collInitialBalance = contractsArray[2].collToken.balanceOf(A);
    testValues4.collInitialBalance = contractsArray[3].collToken.balanceOf(A);
    testValues1.unbackedPortion = contractsArray[0].troveManager.getEntireBranchDebt() - _spBoldAmount1;
    testValues2.unbackedPortion = contractsArray[1].troveManager.getEntireBranchDebt() - _spBoldAmount2;
    testValues3.unbackedPortion = contractsArray[2].troveManager.getEntireBranchDebt() - _spBoldAmount3;
    testValues4.unbackedPortion = contractsArray[3].troveManager.getEntireBranchDebt() - _spBoldAmount4;
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
    console.log(testValues1.fee, "fee1");
    console.log(testValues2.fee, "fee2");
    console.log(testValues3.fee, "fee3");
    console.log(testValues4.fee, "fee4");
    vm.startPrank(A);
    collateralRegistry.redeemCollateral(redeemAmount, 0, 1e18);
    vm.stopPrank();
    assertApproxEqAbs(boldToken.balanceOf(A), boldBalance - redeemAmount, 10, "Wrong Bold balance after redemption");
    testValues1.collFinalBalance = contractsArray[0].collToken.balanceOf(A);
    testValues2.collFinalBalance = contractsArray[1].collToken.balanceOf(A);
    testValues3.collFinalBalance = contractsArray[2].collToken.balanceOf(A);
    testValues4.collFinalBalance = contractsArray[3].collToken.balanceOf(A);
    console.log(redeemAmount, "redeemAmount");
    console.log(testValues1.unbackedPortion, "testValues1.unbackedPortion");
    console.log(totalUnbacked, "totalUnbacked");
    console.log(testValues1.redeemAmount, "partial redeem amount 1");
    assertApproxEqAbs(testValues1.collFinalBalance - testValues1.collInitialBalance, ((testValues1.redeemAmount * DECIMAL_PRECISION) / testValues1.price) - testValues1.fee, 10, "Wrong Collateral 1 balance");
    assertApproxEqAbs(testValues2.collFinalBalance - testValues2.collInitialBalance, ((testValues2.redeemAmount * DECIMAL_PRECISION) / testValues2.price) - testValues2.fee, 10, "Wrong Collateral 2 balance");
    assertApproxEqAbs(testValues3.collFinalBalance - testValues3.collInitialBalance, ((testValues3.redeemAmount * DECIMAL_PRECISION) / testValues3.price) - testValues3.fee, 10, "Wrong Collateral 3 balance");
    assertApproxEqAbs(testValues4.collFinalBalance - testValues4.collInitialBalance, ((testValues4.redeemAmount * DECIMAL_PRECISION) / testValues4.price) - testValues4.fee, 10, "Wrong Collateral 4 balance");
}
```

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

### log(uint256,string)

- **Kind**: internal
- **Source**: 6702:145:61
- **Link**: `lib/forge-std/src/console.sol:console:log(uint256,string)`

```solidity
function log(uint256 p0, string memory p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(uint256,string)", p0, p1));
}
```

### _sendLogPayload(bytes)

- **Kind**: internal
- **Source**: 9648:133:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_sendLogPayload(bytes)`

```solidity
function _sendLogPayload(bytes memory payload) internal pure {
    _castLogPayloadViewToPure(_sendLogPayloadView)(payload);
}
```

### _castLogPayloadViewToPure(function (bytes)

- **Kind**: internal
- **Source**: 9407:235:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_castLogPayloadViewToPure(function (bytes) view)`

```solidity
function _castLogPayloadViewToPure(function(bytes memory) internal view fnIn) internal pure returns (function(bytes memory) internal pure fnOut) {
    assembly {
        fnOut := fnIn
    }
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

## State Variable Reads

- **contractsArray** (`struct TestDeployer.LiquityContractsDev[]`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MulticollateralTest.testMultiCollateralRedemptionMaxSPAmount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: MulticollateralTest._testMultiCollateralRedemption(uint256,uint256,uint256,uint256,uint256,uint256) (NodeID: 1)
      💬 Args: [boldAmount, boldAmount, boldAmount, boldAmount, boldAmount - minBoldBalance, DECIMAL_PRECISION / minBoldBalance]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MulticollateralTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 2)
    │   💬 Args: [0, A, 0, 10e18, _boldAmount, 5e16]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 3)
    │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 4)
    │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MulticollateralTest.makeMulticollateralSPDepositAndClaim(uint256,address,uint256) (NodeID: 5)
    │   💬 Args: [0, A, _spBoldAmount1]
    │   👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: MulticollateralTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 6)
    │   💬 Args: [1, A, 0, 100e18, _boldAmount, 5e16]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 7)
    │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 8)
    │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MulticollateralTest.makeMulticollateralSPDepositAndClaim(uint256,address,uint256) (NodeID: 9)
    │   💬 Args: [1, A, _spBoldAmount2]
    │   👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: MulticollateralTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 10)
    │   💬 Args: [2, A, 0, 10e18, _boldAmount, 5e16]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 11)
    │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 12)
    │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MulticollateralTest.makeMulticollateralSPDepositAndClaim(uint256,address,uint256) (NodeID: 13)
    │   💬 Args: [2, A, _spBoldAmount3]
    │   👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: MulticollateralTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 14)
    │   💬 Args: [3, A, 0, 10e18, _boldAmount, 5e16]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 15)
    │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 16)
    │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MulticollateralTest.makeMulticollateralSPDepositAndClaim(uint256,address,uint256) (NodeID: 17)
    │   💬 Args: [3, A, _spBoldAmount4]
    │   👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 18)
    │   💬 Args: [testValues1.fee, "fee1"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 19)
    │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 20)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 21)
    │   💬 Args: [testValues2.fee, "fee2"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 22)
    │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 23)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 24)
    │   💬 Args: [testValues3.fee, "fee3"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 25)
    │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 26)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 27)
    │   💬 Args: [testValues4.fee, "fee4"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 28)
    │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 29)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 30)
    │   💬 Args: [boldToken.balanceOf(A), boldBalance - redeemAmount, 10, "Wrong Bold balance after redemption"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 31)
    │   💬 Args: [redeemAmount, "redeemAmount"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 32)
    │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 33)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 34)
    │   💬 Args: [testValues1.unbackedPortion, "testValues1.unbackedPortion"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 35)
    │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 36)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 37)
    │   💬 Args: [totalUnbacked, "totalUnbacked"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 38)
    │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 39)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 40)
    │   💬 Args: [testValues1.redeemAmount, "partial redeem amount 1"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 41)
    │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 42)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 43)
    │   💬 Args: [testValues1.collFinalBalance - testValues1.collInitialBalance, ((testValues1.redeemAmount * DECIMAL_PRECISION) / testValues1.price) - testValues1.fee, 10, "Wrong Collateral 1 balance"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 44)
    │   💬 Args: [testValues2.collFinalBalance - testValues2.collInitialBalance, ((testValues2.redeemAmount * DECIMAL_PRECISION) / testValues2.price) - testValues2.fee, 10, "Wrong Collateral 2 balance"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 45)
    │   💬 Args: [testValues3.collFinalBalance - testValues3.collInitialBalance, ((testValues3.redeemAmount * DECIMAL_PRECISION) / testValues3.price) - testValues3.fee, 10, "Wrong Collateral 3 balance"]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 46)
        💬 Args: [testValues4.collFinalBalance - testValues4.collInitialBalance, ((testValues4.redeemAmount * DECIMAL_PRECISION) / testValues4.price) - testValues4.fee, 10, "Wrong Collateral 4 balance"]
        👁️  Def: internal
```
