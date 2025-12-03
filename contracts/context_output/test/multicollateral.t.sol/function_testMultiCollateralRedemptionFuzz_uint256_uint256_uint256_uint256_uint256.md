# Function: testMultiCollateralRedemptionFuzz(uint256,uint256,uint256,uint256,uint256)

**Contract**: [test/multicollateral.t.sol/contract_MulticollateralTest.md]

## Metadata

- **Contract**: MulticollateralTest
- **Signature**: `testMultiCollateralRedemptionFuzz(uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 11650:886:311

## Implementation

```solidity
function testMultiCollateralRedemptionFuzz(uint256 _spBoldAmount1, uint256 _spBoldAmount2, uint256 _spBoldAmount3, uint256 _spBoldAmount4, uint256 _redemptionFraction) public {
    uint256 boldAmount = 10000e18;
    uint256 minBoldBalance = 1;
    _spBoldAmount1 = bound(_spBoldAmount1, 0, boldAmount);
    _spBoldAmount2 = bound(_spBoldAmount2, 0, boldAmount);
    _spBoldAmount3 = bound(_spBoldAmount3, 0, boldAmount);
    _spBoldAmount4 = bound(_spBoldAmount4, 0, boldAmount - minBoldBalance);
    _redemptionFraction = bound(_redemptionFraction, DECIMAL_PRECISION / minBoldBalance, DECIMAL_PRECISION);
    _testMultiCollateralRedemption(boldAmount, _spBoldAmount1, _spBoldAmount2, _spBoldAmount3, _spBoldAmount4, _redemptionFraction);
}
```

## Related Implementations

### bound(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 2915:199:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:bound(uint256,uint256,uint256)`

```solidity
function bound(uint256 x, uint256 min, uint256 max) virtual internal pure returns (uint256 result) {
    result = _bound(x, min, max);
    console2_log_StdUtils("Bound result", result);
}
```

### _bound(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 1646:1263:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_bound(uint256,uint256,uint256)`

```solidity
function _bound(uint256 x, uint256 min, uint256 max) virtual internal pure returns (uint256 result) {
    require(min <= max, "StdUtils bound(uint256,uint256,uint256): Max is less than min.");
    if ((x >= min) && (x <= max)) return x;
    uint256 size = (max - min) + 1;
    if ((x <= 3) && (size > x)) return min + x;
    if ((x >= (UINT256_MAX - 3)) && (size > (UINT256_MAX - x))) return max - (UINT256_MAX - x);
    if (x > max) {
        uint256 diff = x - max;
        uint256 rem = diff % size;
        if (rem == 0) return max;
        result = (min + rem) - 1;
    } else if (x < min) {
        uint256 diff = min - x;
        uint256 rem = diff % size;
        if (rem == 0) return min;
        result = (max - rem) + 1;
    }
}
```

### console2_log_StdUtils(string,uint256)

- **Kind**: internal
- **Source**: 10318:162:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:console2_log_StdUtils(string,uint256)`

```solidity
function console2_log_StdUtils(string memory p0, uint256 p1) private pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
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

- **UINT256_MAX** (`uint256`)
- **contractsArray** (`struct TestDeployer.LiquityContractsDev[]`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MulticollateralTest.testMultiCollateralRedemptionFuzz(uint256,uint256,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [_spBoldAmount1, 0, boldAmount]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 2)
  │ │   💬 Args: [x, min, max]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 3)
  │     💬 Args: ["Bound result", result]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 4)
  │       💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 5)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 6)
  │   💬 Args: [_spBoldAmount2, 0, boldAmount]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 7)
  │ │   💬 Args: [x, min, max]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 8)
  │     💬 Args: ["Bound result", result]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 9)
  │       💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 10)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 11)
  │   💬 Args: [_spBoldAmount3, 0, boldAmount]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 12)
  │ │   💬 Args: [x, min, max]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 13)
  │     💬 Args: ["Bound result", result]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 14)
  │       💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 15)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 16)
  │   💬 Args: [_spBoldAmount4, 0, boldAmount - minBoldBalance]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 17)
  │ │   💬 Args: [x, min, max]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 18)
  │     💬 Args: ["Bound result", result]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 19)
  │       💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 20)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 21)
  │   💬 Args: [_redemptionFraction, DECIMAL_PRECISION / minBoldBalance, DECIMAL_PRECISION]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 22)
  │ │   💬 Args: [x, min, max]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 23)
  │     💬 Args: ["Bound result", result]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 24)
  │       💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 25)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: MulticollateralTest._testMultiCollateralRedemption(uint256,uint256,uint256,uint256,uint256,uint256) (NodeID: 26)
      💬 Args: [boldAmount, _spBoldAmount1, _spBoldAmount2, _spBoldAmount3, _spBoldAmount4, _redemptionFraction]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MulticollateralTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 27)
    │   💬 Args: [0, A, 0, 10e18, _boldAmount, 5e16]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 28)
    │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 29)
    │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MulticollateralTest.makeMulticollateralSPDepositAndClaim(uint256,address,uint256) (NodeID: 30)
    │   💬 Args: [0, A, _spBoldAmount1]
    │   👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: MulticollateralTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 31)
    │   💬 Args: [1, A, 0, 100e18, _boldAmount, 5e16]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 32)
    │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 33)
    │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MulticollateralTest.makeMulticollateralSPDepositAndClaim(uint256,address,uint256) (NodeID: 34)
    │   💬 Args: [1, A, _spBoldAmount2]
    │   👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: MulticollateralTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 35)
    │   💬 Args: [2, A, 0, 10e18, _boldAmount, 5e16]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 36)
    │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 37)
    │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MulticollateralTest.makeMulticollateralSPDepositAndClaim(uint256,address,uint256) (NodeID: 38)
    │   💬 Args: [2, A, _spBoldAmount3]
    │   👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: MulticollateralTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 39)
    │   💬 Args: [3, A, 0, 10e18, _boldAmount, 5e16]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 40)
    │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 41)
    │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MulticollateralTest.makeMulticollateralSPDepositAndClaim(uint256,address,uint256) (NodeID: 42)
    │   💬 Args: [3, A, _spBoldAmount4]
    │   👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 43)
    │   💬 Args: [testValues1.fee, "fee1"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 44)
    │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 45)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 46)
    │   💬 Args: [testValues2.fee, "fee2"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 47)
    │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 48)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 49)
    │   💬 Args: [testValues3.fee, "fee3"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 50)
    │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 51)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 52)
    │   💬 Args: [testValues4.fee, "fee4"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 53)
    │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 54)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 55)
    │   💬 Args: [boldToken.balanceOf(A), boldBalance - redeemAmount, 10, "Wrong Bold balance after redemption"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 56)
    │   💬 Args: [redeemAmount, "redeemAmount"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 57)
    │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 58)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 59)
    │   💬 Args: [testValues1.unbackedPortion, "testValues1.unbackedPortion"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 60)
    │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 61)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 62)
    │   💬 Args: [totalUnbacked, "totalUnbacked"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 63)
    │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 64)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 65)
    │   💬 Args: [testValues1.redeemAmount, "partial redeem amount 1"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 66)
    │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 67)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 68)
    │   💬 Args: [testValues1.collFinalBalance - testValues1.collInitialBalance, ((testValues1.redeemAmount * DECIMAL_PRECISION) / testValues1.price) - testValues1.fee, 10, "Wrong Collateral 1 balance"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 69)
    │   💬 Args: [testValues2.collFinalBalance - testValues2.collInitialBalance, ((testValues2.redeemAmount * DECIMAL_PRECISION) / testValues2.price) - testValues2.fee, 10, "Wrong Collateral 2 balance"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 70)
    │   💬 Args: [testValues3.collFinalBalance - testValues3.collInitialBalance, ((testValues3.redeemAmount * DECIMAL_PRECISION) / testValues3.price) - testValues3.fee, 10, "Wrong Collateral 3 balance"]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 71)
        💬 Args: [testValues4.collFinalBalance - testValues4.collInitialBalance, ((testValues4.redeemAmount * DECIMAL_PRECISION) / testValues4.price) - testValues4.fee, 10, "Wrong Collateral 4 balance"]
        👁️  Def: internal
```
