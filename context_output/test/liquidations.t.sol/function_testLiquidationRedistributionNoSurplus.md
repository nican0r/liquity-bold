# Function: testLiquidationRedistributionNoSurplus()

**Contract**: [test/liquidations.t.sol/contract_LiquidationsTest.md]

## Metadata

- **Contract**: LiquidationsTest
- **Signature**: `testLiquidationRedistributionNoSurplus()`
- **Visibility**: public
- **Source Range**: 7246:2925:309

## Implementation

```solidity
function testLiquidationRedistributionNoSurplus() public {
    uint256 liquidationAmount = 2000e18;
    uint256 collAmount = 2e18;
    priceFeed.setPrice(2000e18);
    vm.startPrank(A);
    uint256 ATroveId = borrowerOperations.openTrove(A, 0, collAmount, liquidationAmount, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    vm.stopPrank();
    vm.startPrank(B);
    uint256 BTroveId = borrowerOperations.openTrove(B, 0, 2 * collAmount, liquidationAmount, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    priceFeed.setPrice(1100e18 - 1);
    (uint256 price, ) = priceFeed.fetchPrice();
    uint256 BInitialDebt = troveManager.getTroveEntireDebt(BTroveId);
    uint256 BInitialColl = troveManager.getTroveEntireColl(BTroveId);
    assertEq(troveManager.checkBelowCriticalThreshold(price), false, "System should not be below CT");
    assertLt(troveManager.getCurrentICR(ATroveId, price), MCR);
    assertGt(troveManager.getTCR(price), CCR);
    assertEq(stabilityPool.getTotalBoldDeposits(), 0, "SP should be empty");
    uint256 trovesCount = troveManager.getTroveIdsCount();
    assertEq(trovesCount, 2);
    uint256 AInterest = troveManager.getTroveEntireDebt(ATroveId) - liquidationAmount;
    troveManager.liquidate(ATroveId);
    trovesCount = troveManager.getTroveIdsCount();
    assertEq(trovesCount, 1);
    assertEq(stabilityPool.getTotalBoldDeposits(), 0, "SP should be empty");
    assertEq(stabilityPool.getCollBalance(), 0, "SP should not have Coll rewards");
    assertApproxEqAbs(troveManager.getTroveEntireDebt(BTroveId) - BInitialDebt, liquidationAmount + AInterest, 3, "B debt mismatch");
    assertApproxEqAbs(troveManager.getTroveEntireColl(BTroveId) - BInitialColl, collAmount, 10, "B trove coll mismatch");
    assertEq(collToken.balanceOf(address(collSurplusPool)), 0, "CollSurplusPool should be empty");
    assertEq(collToken.balanceOf(address(collSurplusPool)), collSurplusPool.getCollBalance(), "CollSurplusPool balance and getter should match");
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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
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
- **IPriceFeedTestnet::fetchPrice()**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **ITroveManagerTester::getTroveEntireColl(uint256)**
- **ITroveManagerTester::checkBelowCriticalThreshold(uint256)**
- **ITroveManagerTester::getCurrentICR(uint256,uint256)**
- **ITroveManagerTester::getTCR(uint256)**
- **IStabilityPool::getTotalBoldDeposits()**
- **ITroveManagerTester::getTroveIdsCount()**
- **ITroveManagerTester::liquidate(uint256)**
- **IStabilityPool::getCollBalance()**
- **IERC20::balanceOf(address)**
- **ICollSurplusPool::getCollBalance()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LiquidationsTest.testLiquidationRedistributionNoSurplus() (NodeID: 0)
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
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [stabilityPool.getTotalBoldDeposits(), 0, "SP should be empty"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [trovesCount, 2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
  │   💬 Args: [trovesCount, 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [stabilityPool.getTotalBoldDeposits(), 0, "SP should be empty"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 8)
  │   💬 Args: [stabilityPool.getCollBalance(), 0, "SP should not have Coll rewards"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 9)
  │   💬 Args: [troveManager.getTroveEntireDebt(BTroveId) - BInitialDebt, liquidationAmount + AInterest, 3, "B debt mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 10)
  │   💬 Args: [troveManager.getTroveEntireColl(BTroveId) - BInitialColl, collAmount, 10, "B trove coll mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 11)
  │   💬 Args: [collToken.balanceOf(address(collSurplusPool)), 0, "CollSurplusPool should be empty"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 12)
      💬 Args: [collToken.balanceOf(address(collSurplusPool)), collSurplusPool.getCollBalance(), "CollSurplusPool balance and getter should match"]
      👁️  Def: internal
```
