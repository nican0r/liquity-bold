# Function: testLiquidationsWithLowPAllowFurtherRewardsForExistingDepositors(uint256,uint256)

**Contract**: [test/stabilityPool.t.sol/contract_SPTest.md]

## Metadata

- **Contract**: SPTest
- **Signature**: `testLiquidationsWithLowPAllowFurtherRewardsForExistingDepositors(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 78922:6869:334

## Implementation

```solidity
function testLiquidationsWithLowPAllowFurtherRewardsForExistingDepositors(uint256 _cheatP, uint256 _surplus) public {
    PTestVars memory testVars;
    _cheatP = bound(_cheatP, 1e27, 1e29);
    vm.store(address(stabilityPool), bytes32(uint256(10)), bytes32(uint256(_cheatP)));
    uint256 storedVal = uint256(vm.load(address(stabilityPool), bytes32(uint256(10))));
    assertEq(storedVal, _cheatP, "value of slot 10 is not set");
    assertEq(stabilityPool.P(), _cheatP, "P is not set");
    ABCDEF memory troveIDs = _setupForPTests();
    testVars.initialBoldGainA = stabilityPool.getDepositorYieldGain(A);
    testVars.initialBoldGainB = stabilityPool.getDepositorYieldGain(B);
    uint256 troveDebt = troveManager.getTroveEntireDebt(troveIDs.D);
    uint256 debtDelta = troveDebt - stabilityPool.getTotalBoldDeposits();
    _surplus = bound(_surplus, debtDelta + 1e15, debtDelta + 10e18);
    makeSPDepositAndClaim(B, _surplus);
    testVars.troveDebt_C = troveManager.getTroveEntireDebt(troveIDs.C);
    testVars.totalSPBeforeLiq_C = stabilityPool.getTotalBoldDeposits();
    testVars.deposit1_A = stabilityPool.getCompoundedBoldDeposit(A);
    testVars.deposit1_B = stabilityPool.getCompoundedBoldDeposit(B);
    uint256 spEthBalBefore = collToken.balanceOf(address(stabilityPool));
    liquidate(A, troveIDs.C);
    bool spTooLowAfterLiquidateA = stabilityPool.getTotalBoldDeposits() < DECIMAL_PRECISION;
    uint256 spEthBalAfter = collToken.balanceOf(address(stabilityPool));
    testVars.spEthGain1 = spEthBalAfter - spEthBalBefore;
    testVars.expectedShareOfColl1_A = (testVars.deposit1_A * testVars.spEthGain1) / testVars.totalSPBeforeLiq_C;
    testVars.expectedShareOfColl1_B = (testVars.deposit1_B * testVars.spEthGain1) / testVars.totalSPBeforeLiq_C;
    testVars.scale2 = stabilityPool.currentScale();
    assertGt(stabilityPool.getCompoundedBoldDeposit(A), 0);
    assertGt(stabilityPool.getCompoundedBoldDeposit(B), 0);
    testVars.deposit2_A = stabilityPool.getCompoundedBoldDeposit(A);
    testVars.deposit2_B = stabilityPool.getCompoundedBoldDeposit(B);
    testVars.expectedDeposit1_A = testVars.deposit1_A - ((testVars.deposit1_A * testVars.troveDebt_C) / testVars.totalSPBeforeLiq_C);
    testVars.expectedDeposit1_B = testVars.deposit1_B - ((testVars.deposit1_B * testVars.troveDebt_C) / testVars.totalSPBeforeLiq_C);
    assertApproximatelyEqual(testVars.expectedDeposit1_A, testVars.deposit2_A, 1e18);
    assertApproximatelyEqual(testVars.expectedDeposit1_B, testVars.deposit2_B, 1e18);
    assertGt(stabilityPool.getCompoundedBoldDeposit(A), 0);
    assertGt(stabilityPool.getCompoundedBoldDeposit(B), 0);
    vm.warp(block.timestamp + 1 days);
    uint256 pendingAggInterest1 = activePool.calcPendingAggInterest();
    assertGt(pendingAggInterest1, 0);
    uint256 expectedSpYield1 = (SP_YIELD_SPLIT * pendingAggInterest1) / 1e18;
    testVars.expectedShareOfYield1_A = getShareofSPReward(A, expectedSpYield1);
    testVars.expectedShareOfYield1_B = getShareofSPReward(B, expectedSpYield1);
    testVars.troveDebt_D = troveManager.getTroveEntireDebt(troveIDs.D);
    transferBold(B, D, boldToken.balanceOf(B));
    makeSPDepositAndClaim(D, boldToken.balanceOf(D));
    testVars.totalSPBeforeLiq_D = stabilityPool.getTotalBoldDeposits();
    assertGt(testVars.totalSPBeforeLiq_D, testVars.troveDebt_D);
    if (spTooLowAfterLiquidateA) {
        testVars.expectedShareOfYield1_A = getShareofSPReward(A, expectedSpYield1);
        testVars.expectedShareOfYield1_B = getShareofSPReward(B, expectedSpYield1);
    }
    assertGt(testVars.expectedShareOfYield1_A, 0);
    assertGt(testVars.expectedShareOfYield1_B, 0);
    spEthBalBefore = collToken.balanceOf(address(stabilityPool));
    liquidate(A, troveIDs.D);
    spEthBalAfter = collToken.balanceOf(address(stabilityPool));
    uint256 spEthGain2 = spEthBalAfter - spEthBalBefore;
    assertGt(spEthGain2, 0);
    testVars.expectedDeposit2_A = testVars.deposit2_A - ((testVars.deposit2_A * testVars.troveDebt_D) / testVars.totalSPBeforeLiq_D);
    testVars.expectedDeposit2_B = testVars.deposit2_B - ((testVars.deposit2_B * testVars.troveDebt_D) / testVars.totalSPBeforeLiq_D);
    assertApproximatelyEqual(testVars.expectedDeposit2_A, stabilityPool.getCompoundedBoldDeposit(A), 1e18);
    assertApproximatelyEqual(testVars.expectedDeposit2_B, stabilityPool.getCompoundedBoldDeposit(B), 1e18);
    assertGt(stabilityPool.getCompoundedBoldDeposit(A), 0);
    assertGt(stabilityPool.getCompoundedBoldDeposit(B), 0);
    testVars.expectedShareOfColl2_A = (testVars.deposit2_A * spEthGain2) / testVars.totalSPBeforeLiq_D;
    testVars.expectedShareOfColl2_B = (testVars.deposit2_B * spEthGain2) / testVars.totalSPBeforeLiq_D;
    testVars.boldGainA = stabilityPool.getDepositorYieldGain(A);
    testVars.boldGainB = stabilityPool.getDepositorYieldGain(B);
    assertApproximatelyEqual(testVars.initialBoldGainA + testVars.expectedShareOfYield1_A, testVars.boldGainA, 1e4, "A yield gain mismatch");
    assertApproximatelyEqual(testVars.initialBoldGainB + testVars.expectedShareOfYield1_B, testVars.boldGainB, 1e4, "B yield gain mismatch");
    uint256 ethGainA = stabilityPool.getDepositorCollGain(A);
    uint256 ethGainB = stabilityPool.getDepositorCollGain(B);
    assertApproximatelyEqual(testVars.expectedShareOfColl1_A + testVars.expectedShareOfColl2_A, ethGainA, 1e15);
    assertApproximatelyEqual(testVars.expectedShareOfColl1_B + testVars.expectedShareOfColl2_B, ethGainB, 1e15);
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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### _setupForPTests()

- **Kind**: internal
- **Source**: 7678:352:261
- **Link**: `test/TestContracts/DevTestSetup.sol:DevTestSetup:_setupForPTests()`

```solidity
function _setupForPTests() internal returns (ABCDEF memory) {
    ABCDEF memory troveIDs;
    (troveIDs.A, troveIDs.B, troveIDs.C, troveIDs.D) = _setupForBatchLiquidateTrovesPureOffset(1);
    makeSPWithdrawalAndClaim(B, stabilityPool.getCompoundedBoldDeposit(B));
    return troveIDs;
}
```

### _setupForBatchLiquidateTrovesPureOffset(uint256)

- **Kind**: internal
- **Source**: 4424:1477:261
- **Link**: `test/TestContracts/DevTestSetup.sol:DevTestSetup:_setupForBatchLiquidateTrovesPureOffset(uint256)`

```solidity
function _setupForBatchLiquidateTrovesPureOffset(uint256 _magnitude) internal returns (uint256, uint256, uint256, uint256) {
    uint256 troveDebtRequest_A = 2200e18 * _magnitude;
    uint256 troveDebtRequest_B = 3200e18 * _magnitude;
    uint256 troveDebtRequest_C = 2450e18 * _magnitude;
    uint256 troveDebtRequest_D = 2450e18 * _magnitude;
    uint256 interestRate = 5e16;
    ABCDEF memory troveIDs;
    uint256 price = 2000e18;
    priceFeed.setPrice(price);
    troveIDs.A = openTroveNoHints100pct(A, 5 ether * _magnitude, troveDebtRequest_A, interestRate);
    troveIDs.B = openTroveNoHints100pct(B, 5 ether * _magnitude, troveDebtRequest_B, interestRate);
    troveIDs.C = openTroveNoHints100pct(C, 25e17 * _magnitude, troveDebtRequest_C, interestRate);
    troveIDs.D = openTroveNoHints100pct(D, 25e17 * _magnitude, troveDebtRequest_D, interestRate);
    makeSPDepositAndClaim(A, troveDebtRequest_A);
    makeSPDepositAndClaim(B, troveDebtRequest_B);
    price = 1050e18;
    priceFeed.setPrice(price);
    assertFalse(troveManager.checkBelowCriticalThreshold(price));
    assertLt(troveManager.getCurrentICR(troveIDs.C, price), MCR);
    assertLt(troveManager.getCurrentICR(troveIDs.D, price), MCR);
    return (troveIDs.A, troveIDs.B, troveIDs.C, troveIDs.D);
}
```

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

### makeSPDepositAndClaim(address,uint256)

- **Kind**: internal
- **Source**: 11155:187:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:makeSPDepositAndClaim(address,uint256)`

```solidity
function makeSPDepositAndClaim(address _account, uint256 _amount) public {
    vm.startPrank(_account);
    stabilityPool.provideToSP(_amount, true);
    vm.stopPrank();
}
```

### assertFalse(bool)

- **Kind**: internal
- **Source**: 1808:91:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool)`

```solidity
function assertFalse(bool data) virtual internal pure {
    vm.assertFalse(data);
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

### makeSPWithdrawalAndClaim(address,uint256)

- **Kind**: internal
- **Source**: 11541:193:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:makeSPWithdrawalAndClaim(address,uint256)`

```solidity
function makeSPWithdrawalAndClaim(address _account, uint256 _amount) public {
    vm.startPrank(_account);
    stabilityPool.withdrawFromSP(_amount, true);
    vm.stopPrank();
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

### assertGt(uint256,uint256)

- **Kind**: internal
- **Source**: 13112:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256)`

```solidity
function assertGt(uint256 left, uint256 right) virtual internal pure {
    vm.assertGt(left, right);
}
```

### assertApproximatelyEqual(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 20022:142:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:assertApproximatelyEqual(uint256,uint256,uint256)`

```solidity
function assertApproximatelyEqual(uint256 _x, uint256 _y, uint256 _margin) public pure {
    assertApproxEqAbs(_x, _y, _margin, "");
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

### getShareofSPReward(address,uint256)

- **Kind**: internal
- **Source**: 14174:218:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:getShareofSPReward(address,uint256)`

```solidity
function getShareofSPReward(address _depositor, uint256 _reward) public view returns (uint256) {
    return (_reward * stabilityPool.getCompoundedBoldDeposit(_depositor)) / stabilityPool.getTotalBoldDeposits();
}
```

### transferBold(address,address,uint256)

- **Kind**: internal
- **Source**: 13415:177:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:transferBold(address,address,uint256)`

```solidity
function transferBold(address _from, address _to, uint256 _amount) public {
    vm.startPrank(_from);
    boldToken.transfer(_to, _amount);
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

## External Calls

- **Vm::store(address,bytes32,bytes32)**
- **Vm::load(address,bytes32)**
- **IStabilityPool::P()**
- **IStabilityPool::getDepositorYieldGain(address)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **IStabilityPool::getTotalBoldDeposits()**
- **IStabilityPool::getCompoundedBoldDeposit(address)**
- **IERC20::balanceOf(address)**
- **IStabilityPool::currentScale()**
- **Vm::warp(uint256)**
- **IActivePool::calcPendingAggInterest()**
- **IBoldToken::balanceOf(address)**
- **IStabilityPool::getDepositorCollGain(address)**

## State Variable Reads

- **UINT256_MAX** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **troveManager** (`contract ITroveManagerTester`) [test/TestContracts/Interfaces/ITroveManagerTester.sol/interface_ITroveManagerTester.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SPTest.testLiquidationsWithLowPAllowFurtherRewardsForExistingDepositors(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [_cheatP, 1e27, 1e29]
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
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
  │   💬 Args: [storedVal, _cheatP, "value of slot 10 is not set"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [stabilityPool.P(), _cheatP, "P is not set"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: DevTestSetup._setupForPTests() (NodeID: 8)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: DevTestSetup._setupForBatchLiquidateTrovesPureOffset(uint256) (NodeID: 9)
  │ │   💬 Args: [1]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 10)
  │ │ │   💬 Args: [A, 5 ether * _magnitude, troveDebtRequest_A, interestRate]
  │ │ │   👁️  Def: public
  │ │ │ └─ [4] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 11)
  │ │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │ │     👁️  Def: public
  │ │ │   └─ [5] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 12)
  │ │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 13)
  │ │ │   💬 Args: [B, 5 ether * _magnitude, troveDebtRequest_B, interestRate]
  │ │ │   👁️  Def: public
  │ │ │ └─ [4] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 14)
  │ │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │ │     👁️  Def: public
  │ │ │   └─ [5] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 15)
  │ │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 16)
  │ │ │   💬 Args: [C, 25e17 * _magnitude, troveDebtRequest_C, interestRate]
  │ │ │   👁️  Def: public
  │ │ │ └─ [4] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 17)
  │ │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │ │     👁️  Def: public
  │ │ │   └─ [5] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 18)
  │ │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 19)
  │ │ │   💬 Args: [D, 25e17 * _magnitude, troveDebtRequest_D, interestRate]
  │ │ │   👁️  Def: public
  │ │ │ └─ [4] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 20)
  │ │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │ │     👁️  Def: public
  │ │ │   └─ [5] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 21)
  │ │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 22)
  │ │ │   💬 Args: [A, troveDebtRequest_A]
  │ │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 23)
  │ │ │   💬 Args: [B, troveDebtRequest_B]
  │ │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: StdAssertions.assertFalse(bool) (NodeID: 24)
  │ │ │   💬 Args: [troveManager.checkBelowCriticalThreshold(price)]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 25)
  │ │ │   💬 Args: [troveManager.getCurrentICR(troveIDs.C, price), MCR]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 26)
  │ │     💬 Args: [troveManager.getCurrentICR(troveIDs.D, price), MCR]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.makeSPWithdrawalAndClaim(address,uint256) (NodeID: 27)
  │     💬 Args: [B, stabilityPool.getCompoundedBoldDeposit(B)]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 28)
  │   💬 Args: [_surplus, debtDelta + 1e15, debtDelta + 10e18]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 29)
  │ │   💬 Args: [x, min, max]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 30)
  │     💬 Args: ["Bound result", result]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 31)
  │       💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 32)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 33)
  │   💬 Args: [B, _surplus]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.liquidate(address,uint256) (NodeID: 34)
  │   💬 Args: [A, troveIDs.C]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 35)
  │   💬 Args: [stabilityPool.getCompoundedBoldDeposit(A), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 36)
  │   💬 Args: [stabilityPool.getCompoundedBoldDeposit(B), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256) (NodeID: 37)
  │   💬 Args: [testVars.expectedDeposit1_A, testVars.deposit2_A, 1e18]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 38)
  │     💬 Args: [_x, _y, _margin, ""]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256) (NodeID: 39)
  │   💬 Args: [testVars.expectedDeposit1_B, testVars.deposit2_B, 1e18]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 40)
  │     💬 Args: [_x, _y, _margin, ""]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 41)
  │   💬 Args: [stabilityPool.getCompoundedBoldDeposit(A), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 42)
  │   💬 Args: [stabilityPool.getCompoundedBoldDeposit(B), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 43)
  │   💬 Args: [pendingAggInterest1, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.getShareofSPReward(address,uint256) (NodeID: 44)
  │   💬 Args: [A, expectedSpYield1]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.getShareofSPReward(address,uint256) (NodeID: 45)
  │   💬 Args: [B, expectedSpYield1]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.transferBold(address,address,uint256) (NodeID: 46)
  │   💬 Args: [B, D, boldToken.balanceOf(B)]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 47)
  │   💬 Args: [D, boldToken.balanceOf(D)]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 48)
  │   💬 Args: [testVars.totalSPBeforeLiq_D, testVars.troveDebt_D]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.getShareofSPReward(address,uint256) (NodeID: 49)
  │   💬 Args: [A, expectedSpYield1]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.getShareofSPReward(address,uint256) (NodeID: 50)
  │   💬 Args: [B, expectedSpYield1]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 51)
  │   💬 Args: [testVars.expectedShareOfYield1_A, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 52)
  │   💬 Args: [testVars.expectedShareOfYield1_B, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.liquidate(address,uint256) (NodeID: 53)
  │   💬 Args: [A, troveIDs.D]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 54)
  │   💬 Args: [spEthGain2, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256) (NodeID: 55)
  │   💬 Args: [testVars.expectedDeposit2_A, stabilityPool.getCompoundedBoldDeposit(A), 1e18]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 56)
  │     💬 Args: [_x, _y, _margin, ""]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256) (NodeID: 57)
  │   💬 Args: [testVars.expectedDeposit2_B, stabilityPool.getCompoundedBoldDeposit(B), 1e18]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 58)
  │     💬 Args: [_x, _y, _margin, ""]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 59)
  │   💬 Args: [stabilityPool.getCompoundedBoldDeposit(A), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 60)
  │   💬 Args: [stabilityPool.getCompoundedBoldDeposit(B), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256,string) (NodeID: 61)
  │   💬 Args: [testVars.initialBoldGainA + testVars.expectedShareOfYield1_A, testVars.boldGainA, 1e4, "A yield gain mismatch"]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 62)
  │     💬 Args: [_x, _y, _margin, _reason]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256,string) (NodeID: 63)
  │   💬 Args: [testVars.initialBoldGainB + testVars.expectedShareOfYield1_B, testVars.boldGainB, 1e4, "B yield gain mismatch"]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 64)
  │     💬 Args: [_x, _y, _margin, _reason]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256) (NodeID: 65)
  │   💬 Args: [testVars.expectedShareOfColl1_A + testVars.expectedShareOfColl2_A, ethGainA, 1e15]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 66)
  │     💬 Args: [_x, _y, _margin, ""]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256) (NodeID: 67)
      💬 Args: [testVars.expectedShareOfColl1_B + testVars.expectedShareOfColl2_B, ethGainB, 1e15]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 68)
        💬 Args: [_x, _y, _margin, ""]
        👁️  Def: internal
```
