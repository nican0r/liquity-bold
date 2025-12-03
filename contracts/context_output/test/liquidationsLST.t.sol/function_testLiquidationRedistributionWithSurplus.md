# Function: testLiquidationRedistributionWithSurplus()

**Contract**: [test/liquidationsLST.t.sol/contract_LiquidationsLSTTest.md]

## Metadata

- **Contract**: LiquidationsLSTTest
- **Signature**: `testLiquidationRedistributionWithSurplus()`
- **Visibility**: public
- **Source Range**: 1945:3697:310

## Implementation

```solidity
function testLiquidationRedistributionWithSurplus() public {
    uint256 liquidationAmount = 2000e18;
    uint256 collAmount = 2e18;
    priceFeed.setPrice(2000e18);
    vm.startPrank(A);
    uint256 ATroveId = borrowerOperations.openTrove(A, 0, collAmount, liquidationAmount, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    vm.stopPrank();
    vm.startPrank(B);
    uint256 BTroveId = borrowerOperations.openTrove(B, 0, 2 * collAmount, liquidationAmount, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    priceFeed.setPrice(1200e18 - 1);
    (uint256 price, ) = priceFeed.fetchPrice();
    InitialValues memory initialValues;
    initialValues.BDebt = troveManager.getTroveEntireDebt(BTroveId);
    initialValues.BColl = troveManager.getTroveEntireColl(BTroveId);
    initialValues.ACollBalance = collToken.balanceOf(A);
    assertEq(troveManager.checkBelowCriticalThreshold(price), false, "System should not be below CT");
    assertLt(troveManager.getCurrentICR(ATroveId, price), MCR);
    assertGt(troveManager.getTCR(price), CCR);
    assertEq(troveManager.getTroveIdsCount(), 2);
    initialValues.AInterest = troveManager.getTroveEntireDebt(ATroveId) - liquidationAmount;
    troveManager.liquidate(ATroveId);
    assertEq(troveManager.getTroveIdsCount(), 1);
    assertEq(stabilityPool.getTotalBoldDeposits(), 0, "SP should be empty");
    assertEq(stabilityPool.getCollBalance(), 0, "SP should not have Coll rewards");
    assertApproxEqAbs(troveManager.getTroveEntireDebt(BTroveId) - initialValues.BDebt, liquidationAmount + initialValues.AInterest, 3, "B debt mismatch");
    assertApproxEqAbs(troveManager.getTroveEntireColl(BTroveId) - initialValues.BColl, LiquityMath._min(collAmount, ((((liquidationAmount + initialValues.AInterest) * DECIMAL_PRECISION) / price) * 110) / 100), 10, "B trove coll mismatch");
    uint256 collSurplusAmount = collAmount - (((((liquidationAmount + initialValues.AInterest) * DECIMAL_PRECISION) / price) * 110) / 100);
    assertApproxEqAbs(collToken.balanceOf(address(collSurplusPool)), collSurplusAmount, 10, "CollSurplusPool should have received collateral");
    assertEq(collToken.balanceOf(address(collSurplusPool)), collSurplusPool.getCollBalance(), "CollSurplusPool balance and getter should match");
    vm.startPrank(A);
    borrowerOperations.claimCollateral();
    vm.stopPrank();
    assertApproxEqAbs(collToken.balanceOf(A) - initialValues.ACollBalance, collSurplusAmount, 10, "A collateral balance mismatch");
}
```

## Related Implementations

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

### _min(uint256,uint256)

- **Kind**: internal
- **Source**: 136:113:137
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_min(uint256,uint256)`

```solidity
function _min(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a < _b) ? _a : _b;
}
```

## External Calls

- **IPriceFeedTestnet::setPrice(uint256)**
- **Vm::startPrank(address)**
- **IBorrowerOperationsTester::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**
- **Vm::stopPrank()**
- **IPriceFeedTestnet::fetchPrice()**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **ITroveManagerTester::getTroveEntireColl(uint256)**
- **IERC20::balanceOf(address)**
- **ITroveManagerTester::checkBelowCriticalThreshold(uint256)**
- **ITroveManagerTester::getCurrentICR(uint256,uint256)**
- **ITroveManagerTester::getTCR(uint256)**
- **ITroveManagerTester::getTroveIdsCount()**
- **ITroveManagerTester::liquidate(uint256)**
- **IStabilityPool::getTotalBoldDeposits()**
- **IStabilityPool::getCollBalance()**
- **ICollSurplusPool::getCollBalance()**
- **IBorrowerOperationsTester::claimCollateral()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LiquidationsLSTTest.testLiquidationRedistributionWithSurplus() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 1)
  │   💬 Args: [troveManager.checkBelowCriticalThreshold(price), false, "System should not be below CT"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 2)
  │   💬 Args: [troveManager.getCurrentICR(ATroveId, price), MCR]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 3)
  │   💬 Args: [troveManager.getTCR(price), CCR]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [troveManager.getTroveIdsCount(), 2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [troveManager.getTroveIdsCount(), 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
  │   💬 Args: [stabilityPool.getTotalBoldDeposits(), 0, "SP should be empty"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [stabilityPool.getCollBalance(), 0, "SP should not have Coll rewards"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 8)
  │   💬 Args: [troveManager.getTroveEntireDebt(BTroveId) - initialValues.BDebt, liquidationAmount + initialValues.AInterest, 3, "B debt mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 9)
  │   💬 Args: [troveManager.getTroveEntireColl(BTroveId) - initialValues.BColl, LiquityMath._min(collAmount, ((((liquidationAmount + initialValues.AInterest) * DECIMAL_PRECISION) / price) * 110) / 100), 10, "B trove coll mismatch"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 10)
  │     💬 Args: [collAmount, ((((liquidationAmount + initialValues.AInterest) * DECIMAL_PRECISION) / price) * 110) / 100]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 11)
  │   💬 Args: [collToken.balanceOf(address(collSurplusPool)), collSurplusAmount, 10, "CollSurplusPool should have received collateral"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 12)
  │   💬 Args: [collToken.balanceOf(address(collSurplusPool)), collSurplusPool.getCollBalance(), "CollSurplusPool balance and getter should match"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 13)
      💬 Args: [collToken.balanceOf(A) - initialValues.ACollBalance, collSurplusAmount, 10, "A collateral balance mismatch"]
      👁️  Def: internal
```
