# Function: testLiquidationsWithLowPAllowFurtherRewardsForAllFreshDepositors_Cheat_Fuzz(uint256,uint256)

**Contract**: [test/stabilityPool.t.sol/contract_SPTest.md]

## Metadata

- **Contract**: SPTest
- **Signature**: `testLiquidationsWithLowPAllowFurtherRewardsForAllFreshDepositors_Cheat_Fuzz(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 73194:5267:334

## Implementation

```solidity
function testLiquidationsWithLowPAllowFurtherRewardsForAllFreshDepositors_Cheat_Fuzz(uint256 _cheatP, uint256 _surplus) public {
    PTestVars memory testVars;
    _cheatP = bound(_cheatP, 1e27, 1e29);
    vm.store(address(stabilityPool), bytes32(uint256(10)), bytes32(uint256(_cheatP)));
    uint256 storedVal = uint256(vm.load(address(stabilityPool), bytes32(uint256(10))));
    assertEq(storedVal, _cheatP, "value of slot 10 is not set");
    assertEq(stabilityPool.P(), _cheatP, "P is not set");
    ABCDEF memory troveIDs = _setupForPTests();
    uint256 scale1 = stabilityPool.currentScale();
    assertApproximatelyEqual(stabilityPool.getTotalBoldDeposits(), stabilityPool.getCompoundedBoldDeposit(A), 1e14, "A should own all SP");
    uint256 troveDebt = troveManager.getTroveEntireDebt(troveIDs.D);
    uint256 debtDelta = troveDebt - stabilityPool.getTotalBoldDeposits();
    _surplus = bound(_surplus, debtDelta + 1e9, debtDelta + 10e18);
    transferBold(B, A, boldToken.balanceOf(B) / 2);
    makeSPDepositAndClaim(A, _surplus);
    assertEq(stabilityPool.getDepositorYieldGain(A), 0);
    assertEq(activePool.calcPendingAggInterest(), 0);
    liquidate(A, troveIDs.C);
    uint256 scale2 = stabilityPool.currentScale();
    assertGt(scale2, scale1, "scale didnt change");
    uint256 freshDeposit = boldToken.balanceOf(D) / 2;
    assertGt(freshDeposit, 0);
    transferBold(D, C, freshDeposit);
    makeSPDepositAndClaim(C, freshDeposit);
    makeSPDepositAndClaim(D, freshDeposit);
    makeSPWithdrawalAndClaim(A, stabilityPool.getCompoundedBoldDeposit(A));
    assertEq(stabilityPool.getCompoundedBoldDeposit(A), 0, "A deposit should be zero");
    vm.warp(block.timestamp + 1 days);
    uint256 pendingAggInterest = activePool.calcPendingAggInterest();
    assertGt(pendingAggInterest, 0);
    testVars.expectedSpYield1 = (SP_YIELD_SPLIT * pendingAggInterest) / 1e18;
    testVars.expectedShareOfYield1_C = getShareofSPReward(C, testVars.expectedSpYield1);
    testVars.expectedShareOfYield1_D = getShareofSPReward(D, testVars.expectedSpYield1);
    assertGt(testVars.expectedShareOfYield1_C, 0);
    assertGt(testVars.expectedShareOfYield1_D, 0);
    assertEq(testVars.expectedShareOfYield1_C, testVars.expectedShareOfYield1_D);
    testVars.totalDepositsBefore = stabilityPool.getTotalBoldDeposits();
    testVars.spEthBal1 = collToken.balanceOf(address(stabilityPool));
    liquidate(A, troveIDs.D);
    testVars.spEthBal2 = collToken.balanceOf(address(stabilityPool));
    testVars.spEthGain = testVars.spEthBal2 - testVars.spEthBal1;
    assertGt(testVars.spEthGain, 0);
    testVars.expectedShareOfColl = (freshDeposit * testVars.spEthGain) / testVars.totalDepositsBefore;
    assertGt(testVars.expectedShareOfColl, 0);
    testVars.boldGainC = stabilityPool.getDepositorYieldGain(C);
    testVars.boldGainD = stabilityPool.getDepositorYieldGain(D);
    assertApproximatelyEqual(testVars.expectedShareOfYield1_C, testVars.boldGainC, 1e6, "C share of yield mismatch");
    assertApproximatelyEqual(testVars.expectedShareOfYield1_D, testVars.boldGainD, 1e6, "D share of yield mismatch");
    testVars.ethGainC = stabilityPool.getDepositorCollGain(C);
    testVars.ethGainD = stabilityPool.getDepositorCollGain(D);
    assertApproximatelyEqual(testVars.expectedShareOfColl, testVars.ethGainC, 1e7, "C share of coll mismatch");
    assertApproximatelyEqual(testVars.expectedShareOfColl, testVars.ethGainD, 1e7, "D share of coll mismatch");
    transferBold(C, E, boldToken.balanceOf(C));
    makeSPDepositAndClaim(E, boldToken.balanceOf(E));
    vm.warp(block.timestamp + 90 days);
    uint256 pendingAggInterest2 = activePool.calcPendingAggInterest();
    assertGt(pendingAggInterest2, 0);
    uint256 expectedSpYield2 = (SP_YIELD_SPLIT * pendingAggInterest2) / 1e18;
    uint256 expectedShareOfYield2_E = getShareofSPReward(E, expectedSpYield2);
    assertGt(expectedShareOfYield2_E, 0);
    applyPendingDebt(A, troveIDs.A);
    uint256 boldGainE = stabilityPool.getDepositorYieldGain(E);
    assertApproximatelyEqual(expectedShareOfYield2_E, boldGainE, 1e9, "E share of yield mismatch");
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

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
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

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 13228:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertGt(left, right, err);
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

### getShareofSPReward(address,uint256)

- **Kind**: internal
- **Source**: 14174:218:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:getShareofSPReward(address,uint256)`

```solidity
function getShareofSPReward(address _depositor, uint256 _reward) public view returns (uint256) {
    return (_reward * stabilityPool.getCompoundedBoldDeposit(_depositor)) / stabilityPool.getTotalBoldDeposits();
}
```

### applyPendingDebt(address,uint256)

- **Kind**: internal
- **Source**: 13227:182:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:applyPendingDebt(address,uint256)`

```solidity
function applyPendingDebt(address _from, uint256 _troveId) public {
    vm.startPrank(_from);
    borrowerOperations.applyPendingDebt(_troveId);
    vm.stopPrank();
}
```

## External Calls

- **Vm::store(address,bytes32,bytes32)**
- **Vm::load(address,bytes32)**
- **IStabilityPool::P()**
- **IStabilityPool::currentScale()**
- **IStabilityPool::getTotalBoldDeposits()**
- **IStabilityPool::getCompoundedBoldDeposit(address)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **IBoldToken::balanceOf(address)**
- **IStabilityPool::getDepositorYieldGain(address)**
- **IActivePool::calcPendingAggInterest()**
- **Vm::warp(uint256)**
- **IERC20::balanceOf(address)**
- **IStabilityPool::getDepositorCollGain(address)**

## State Variable Reads

- **UINT256_MAX** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **troveManager** (`contract ITroveManagerTester`) [test/TestContracts/Interfaces/ITroveManagerTester.sol/interface_ITroveManagerTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SPTest.testLiquidationsWithLowPAllowFurtherRewardsForAllFreshDepositors_Cheat_Fuzz(uint256,uint256) (NodeID: 0)
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
  ├─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256,string) (NodeID: 28)
  │   💬 Args: [stabilityPool.getTotalBoldDeposits(), stabilityPool.getCompoundedBoldDeposit(A), 1e14, "A should own all SP"]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 29)
  │     💬 Args: [_x, _y, _margin, _reason]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 30)
  │   💬 Args: [_surplus, debtDelta + 1e9, debtDelta + 10e18]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 31)
  │ │   💬 Args: [x, min, max]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 32)
  │     💬 Args: ["Bound result", result]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 33)
  │       💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 34)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.transferBold(address,address,uint256) (NodeID: 35)
  │   💬 Args: [B, A, boldToken.balanceOf(B) / 2]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 36)
  │   💬 Args: [A, _surplus]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 37)
  │   💬 Args: [stabilityPool.getDepositorYieldGain(A), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 38)
  │   💬 Args: [activePool.calcPendingAggInterest(), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.liquidate(address,uint256) (NodeID: 39)
  │   💬 Args: [A, troveIDs.C]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 40)
  │   💬 Args: [scale2, scale1, "scale didnt change"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 41)
  │   💬 Args: [freshDeposit, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.transferBold(address,address,uint256) (NodeID: 42)
  │   💬 Args: [D, C, freshDeposit]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 43)
  │   💬 Args: [C, freshDeposit]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 44)
  │   💬 Args: [D, freshDeposit]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPWithdrawalAndClaim(address,uint256) (NodeID: 45)
  │   💬 Args: [A, stabilityPool.getCompoundedBoldDeposit(A)]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 46)
  │   💬 Args: [stabilityPool.getCompoundedBoldDeposit(A), 0, "A deposit should be zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 47)
  │   💬 Args: [pendingAggInterest, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.getShareofSPReward(address,uint256) (NodeID: 48)
  │   💬 Args: [C, testVars.expectedSpYield1]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.getShareofSPReward(address,uint256) (NodeID: 49)
  │   💬 Args: [D, testVars.expectedSpYield1]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 50)
  │   💬 Args: [testVars.expectedShareOfYield1_C, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 51)
  │   💬 Args: [testVars.expectedShareOfYield1_D, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 52)
  │   💬 Args: [testVars.expectedShareOfYield1_C, testVars.expectedShareOfYield1_D]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.liquidate(address,uint256) (NodeID: 53)
  │   💬 Args: [A, troveIDs.D]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 54)
  │   💬 Args: [testVars.spEthGain, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 55)
  │   💬 Args: [testVars.expectedShareOfColl, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256,string) (NodeID: 56)
  │   💬 Args: [testVars.expectedShareOfYield1_C, testVars.boldGainC, 1e6, "C share of yield mismatch"]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 57)
  │     💬 Args: [_x, _y, _margin, _reason]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256,string) (NodeID: 58)
  │   💬 Args: [testVars.expectedShareOfYield1_D, testVars.boldGainD, 1e6, "D share of yield mismatch"]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 59)
  │     💬 Args: [_x, _y, _margin, _reason]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256,string) (NodeID: 60)
  │   💬 Args: [testVars.expectedShareOfColl, testVars.ethGainC, 1e7, "C share of coll mismatch"]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 61)
  │     💬 Args: [_x, _y, _margin, _reason]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256,string) (NodeID: 62)
  │   💬 Args: [testVars.expectedShareOfColl, testVars.ethGainD, 1e7, "D share of coll mismatch"]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 63)
  │     💬 Args: [_x, _y, _margin, _reason]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.transferBold(address,address,uint256) (NodeID: 64)
  │   💬 Args: [C, E, boldToken.balanceOf(C)]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 65)
  │   💬 Args: [E, boldToken.balanceOf(E)]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 66)
  │   💬 Args: [pendingAggInterest2, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.getShareofSPReward(address,uint256) (NodeID: 67)
  │   💬 Args: [E, expectedSpYield2]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 68)
  │   💬 Args: [expectedShareOfYield2_E, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.applyPendingDebt(address,uint256) (NodeID: 69)
  │   💬 Args: [A, troveIDs.A]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256,string) (NodeID: 70)
      💬 Args: [expectedShareOfYield2_E, boldGainE, 1e9, "E share of yield mismatch"]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 71)
        💬 Args: [_x, _y, _margin, _reason]
        👁️  Def: internal
```
