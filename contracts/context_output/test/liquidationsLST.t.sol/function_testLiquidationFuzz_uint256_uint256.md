# Function: testLiquidationFuzz(uint256,uint256)

**Contract**: [test/liquidationsLST.t.sol/contract_LiquidationsLSTTest.md]

## Metadata

- **Contract**: LiquidationsLSTTest
- **Signature**: `testLiquidationFuzz(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 5955:6105:310

## Implementation

```solidity
function testLiquidationFuzz(uint256 _finalPrice, uint256 _spAmount) public {
    uint256 liquidationAmount = 2000e18;
    uint256 collAmount = 2e18;
    uint256 initialPrice = 2000e18;
    _finalPrice = bound(_finalPrice, 1000e18, 1200e18 - 1);
    _spAmount = bound(_spAmount, 0, liquidationAmount);
    priceFeed.setPrice(initialPrice);
    vm.startPrank(A);
    uint256 ATroveId = borrowerOperations.openTrove(A, 0, collAmount, liquidationAmount, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    vm.stopPrank();
    makeSPDepositAndClaim(A, MIN_BOLD_IN_SP);
    vm.startPrank(B);
    uint256 BTroveId = borrowerOperations.openTrove(B, 0, 3 * collAmount, liquidationAmount, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    vm.stopPrank();
    if (_spAmount > 0) {
        makeSPDepositAndClaim(B, _spAmount);
    }
    priceFeed.setPrice(_finalPrice);
    InitialValues memory initialValues;
    initialValues.spBoldBalance = stabilityPool.getTotalBoldDeposits();
    initialValues.spCollBalance = stabilityPool.getCollBalance();
    initialValues.ACollBalance = collToken.balanceOf(A);
    initialValues.BDebt = troveManager.getTroveEntireDebt(BTroveId);
    initialValues.BColl = troveManager.getTroveEntireColl(BTroveId);
    assertEq(troveManager.checkBelowCriticalThreshold(_finalPrice), false, "System should not be below CT");
    assertLt(troveManager.getCurrentICR(ATroveId, _finalPrice), MCR);
    assertGt(troveManager.getTCR(_finalPrice), CCR);
    uint256 trovesCount = troveManager.getTroveIdsCount();
    assertEq(trovesCount, 2);
    uint256 AInterest = troveManager.getTroveEntireDebt(ATroveId) - liquidationAmount;
    troveManager.liquidate(ATroveId);
    trovesCount = troveManager.getTroveIdsCount();
    assertEq(trovesCount, 1);
    FinalValues memory finalValues;
    uint256 collToOffset = (collAmount * _spAmount) / (liquidationAmount + AInterest);
    finalValues.collSPPortion = (collToOffset * 995) / 1000;
    finalValues.collPenaltySP = (((_spAmount * DECIMAL_PRECISION) / _finalPrice) * 105) / 100;
    finalValues.collToSendToSP = LiquityMath._min(finalValues.collPenaltySP, finalValues.collSPPortion);
    finalValues.spBoldBalance = stabilityPool.getTotalBoldDeposits();
    assertEq(initialValues.spBoldBalance - finalValues.spBoldBalance, _spAmount, "SP Bold balance mismatch");
    finalValues.spCollBalance = stabilityPool.getCollBalance();
    assertApproxEqAbs(finalValues.spCollBalance - initialValues.spCollBalance, finalValues.collToSendToSP, 1000, "SP Coll balance mismatch");
    finalValues.collRedistributionPortion = collAmount - collToOffset;
    finalValues.collPenaltyRedistribution = (((((liquidationAmount - _spAmount) + AInterest) * DECIMAL_PRECISION) / _finalPrice) * 110) / 100;
    finalValues.collToLiquidate = finalValues.collSPPortion + finalValues.collRedistributionPortion;
    assertApproxEqAbs(troveManager.getTroveEntireDebt(BTroveId) - initialValues.BDebt, (liquidationAmount - _spAmount) + AInterest, 10, "B debt mismatch");
    assertApproxEqAbs(troveManager.getTroveEntireColl(BTroveId) - initialValues.BColl, LiquityMath._min(finalValues.collPenaltyRedistribution, (finalValues.collRedistributionPortion + finalValues.collSPPortion) - finalValues.collToSendToSP), 1000, "B trove coll mismatch");
    uint256 collPenalty = finalValues.collToSendToSP + finalValues.collPenaltyRedistribution;
    uint256 collSurplusAmount;
    if (collPenalty < finalValues.collToLiquidate) {
        collSurplusAmount = finalValues.collToLiquidate - collPenalty;
    }
    assertApproxEqAbs(collToken.balanceOf(address(collSurplusPool)), collSurplusAmount, 1e9, "CollSurplusPool mismatch");
    assertEq(collToken.balanceOf(address(collSurplusPool)), collSurplusPool.getCollBalance(), "CollSurplusPool balance and getter should match");
    if (collSurplusAmount > 0) {
        vm.startPrank(A);
        borrowerOperations.claimCollateral();
        vm.stopPrank();
        assertApproxEqAbs(collToken.balanceOf(A) - initialValues.ACollBalance, collSurplusAmount, 1e9, "A collateral balance mismatch");
    }
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

### assertEq(bool,bool,string)

- **Kind**: internal
- **Source**: 2136:128:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bool,bool,string)`

```solidity
function assertEq(bool left, bool right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
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

### assertGt(uint256,uint256)

- **Kind**: internal
- **Source**: 13112:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256)`

```solidity
function assertGt(uint256 left, uint256 right) virtual internal pure {
    vm.assertGt(left, right);
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

### _min(uint256,uint256)

- **Kind**: internal
- **Source**: 136:113:137
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_min(uint256,uint256)`

```solidity
function _min(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a < _b) ? _a : _b;
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

## External Calls

- **IPriceFeedTestnet::setPrice(uint256)**
- **Vm::startPrank(address)**
- **IBorrowerOperationsTester::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**
- **Vm::stopPrank()**
- **IStabilityPool::getTotalBoldDeposits()**
- **IStabilityPool::getCollBalance()**
- **IERC20::balanceOf(address)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **ITroveManagerTester::getTroveEntireColl(uint256)**
- **ITroveManagerTester::checkBelowCriticalThreshold(uint256)**
- **ITroveManagerTester::getCurrentICR(uint256,uint256)**
- **ITroveManagerTester::getTCR(uint256)**
- **ITroveManagerTester::getTroveIdsCount()**
- **ITroveManagerTester::liquidate(uint256)**
- **ICollSurplusPool::getCollBalance()**
- **IBorrowerOperationsTester::claimCollateral()**

## State Variable Reads

- **UINT256_MAX** (`uint256`)
- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LiquidationsLSTTest.testLiquidationFuzz(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [_finalPrice, 1000e18, 1200e18 - 1]
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
  │   💬 Args: [_spAmount, 0, liquidationAmount]
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
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 11)
  │   💬 Args: [A, MIN_BOLD_IN_SP]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 12)
  │   💬 Args: [B, _spAmount]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 13)
  │   💬 Args: [troveManager.checkBelowCriticalThreshold(_finalPrice), false, "System should not be below CT"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 14)
  │   💬 Args: [troveManager.getCurrentICR(ATroveId, _finalPrice), MCR]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 15)
  │   💬 Args: [troveManager.getTCR(_finalPrice), CCR]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 16)
  │   💬 Args: [trovesCount, 2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 17)
  │   💬 Args: [trovesCount, 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 18)
  │   💬 Args: [finalValues.collPenaltySP, finalValues.collSPPortion]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 19)
  │   💬 Args: [initialValues.spBoldBalance - finalValues.spBoldBalance, _spAmount, "SP Bold balance mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 20)
  │   💬 Args: [finalValues.spCollBalance - initialValues.spCollBalance, finalValues.collToSendToSP, 1000, "SP Coll balance mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 21)
  │   💬 Args: [troveManager.getTroveEntireDebt(BTroveId) - initialValues.BDebt, (liquidationAmount - _spAmount) + AInterest, 10, "B debt mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 22)
  │   💬 Args: [troveManager.getTroveEntireColl(BTroveId) - initialValues.BColl, LiquityMath._min(finalValues.collPenaltyRedistribution, (finalValues.collRedistributionPortion + finalValues.collSPPortion) - finalValues.collToSendToSP), 1000, "B trove coll mismatch"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 23)
  │     💬 Args: [finalValues.collPenaltyRedistribution, (finalValues.collRedistributionPortion + finalValues.collSPPortion) - finalValues.collToSendToSP]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 24)
  │   💬 Args: [collToken.balanceOf(address(collSurplusPool)), collSurplusAmount, 1e9, "CollSurplusPool mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 25)
  │   💬 Args: [collToken.balanceOf(address(collSurplusPool)), collSurplusPool.getCollBalance(), "CollSurplusPool balance and getter should match"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 26)
      💬 Args: [collToken.balanceOf(A) - initialValues.ACollBalance, collSurplusAmount, 1e9, "A collateral balance mismatch"]
      👁️  Def: internal
```
