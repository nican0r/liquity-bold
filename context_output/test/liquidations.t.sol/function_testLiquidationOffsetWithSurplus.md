# Function: testLiquidationOffsetWithSurplus()

**Contract**: [test/liquidations.t.sol/contract_LiquidationsTest.md]

## Metadata

- **Contract**: LiquidationsTest
- **Signature**: `testLiquidationOffsetWithSurplus()`
- **Visibility**: public
- **Source Range**: 522:3699:309

## Implementation

```solidity
function testLiquidationOffsetWithSurplus() public {
    uint256 liquidationAmount = 2000e18;
    uint256 collAmount = 2e18;
    priceFeed.setPrice(2000e18);
    vm.startPrank(A);
    uint256 ATroveId = borrowerOperations.openTrove(A, 0, collAmount, liquidationAmount, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    vm.stopPrank();
    vm.startPrank(B);
    borrowerOperations.openTrove(B, 0, 2 * collAmount, liquidationAmount + 100e18, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    vm.stopPrank();
    makeSPDepositAndClaim(B, liquidationAmount + 100e18);
    priceFeed.setPrice(1100e18 - 1);
    (uint256 price, ) = priceFeed.fetchPrice();
    LiquidationsTestVars memory initialValues;
    initialValues.spBoldBalance = stabilityPool.getTotalBoldDeposits();
    initialValues.spCollBalance = stabilityPool.getCollBalance();
    initialValues.ACollBalance = collToken.balanceOf(A);
    assertEq(troveManager.checkBelowCriticalThreshold(price), false, "System should not be below CT");
    assertLt(troveManager.getCurrentICR(ATroveId, price), MCR);
    assertGt(troveManager.getTCR(price), CCR);
    uint256 trovesCount = troveManager.getTroveIdsCount();
    assertEq(trovesCount, 2);
    initialValues.AInterest = troveManager.getTroveEntireDebt(ATroveId) - liquidationAmount;
    troveManager.liquidate(ATroveId);
    trovesCount = troveManager.getTroveIdsCount();
    assertEq(trovesCount, 1);
    uint256 finalSPBoldBalance = stabilityPool.getTotalBoldDeposits();
    assertEq(initialValues.spBoldBalance - finalSPBoldBalance, liquidationAmount + initialValues.AInterest, "SP Bold balance mismatch");
    uint256 finalSPCollBalance = stabilityPool.getCollBalance();
    assertApproxEqAbs(finalSPCollBalance - initialValues.spCollBalance, ((((liquidationAmount + initialValues.AInterest) * DECIMAL_PRECISION) / price) * 105) / 100, 10, "SP Coll balance mismatch");
    uint256 collSurplusAmount = ((collAmount * 995) / 1000) - (((((liquidationAmount + initialValues.AInterest) * DECIMAL_PRECISION) / price) * 105) / 100);
    assertApproxEqAbs(collToken.balanceOf(address(collSurplusPool)), collSurplusAmount, 1, "CollSurplusPool should have received collateral");
    assertEq(collToken.balanceOf(address(collSurplusPool)), collSurplusPool.getCollBalance(), "CollSurplusPool balance and getter should match");
    vm.startPrank(A);
    borrowerOperations.claimCollateral();
    vm.stopPrank();
    assertApproxEqAbs(collToken.balanceOf(A) - initialValues.ACollBalance, collSurplusAmount, 1, "A collateral balance mismatch");
}
```

## Related Implementations

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
- **IPriceFeedTestnet::fetchPrice()**
- **IStabilityPool::getTotalBoldDeposits()**
- **IStabilityPool::getCollBalance()**
- **IERC20::balanceOf(address)**
- **ITroveManagerTester::checkBelowCriticalThreshold(uint256)**
- **ITroveManagerTester::getCurrentICR(uint256,uint256)**
- **ITroveManagerTester::getTCR(uint256)**
- **ITroveManagerTester::getTroveIdsCount()**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **ITroveManagerTester::liquidate(uint256)**
- **ICollSurplusPool::getCollBalance()**
- **IBorrowerOperationsTester::claimCollateral()**

## State Variable Reads

- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LiquidationsTest.testLiquidationOffsetWithSurplus() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 1)
  │   💬 Args: [B, liquidationAmount + 100e18]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 2)
  │   💬 Args: [troveManager.checkBelowCriticalThreshold(price), false, "System should not be below CT"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 3)
  │   💬 Args: [troveManager.getCurrentICR(ATroveId, price), MCR]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 4)
  │   💬 Args: [troveManager.getTCR(price), CCR]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [trovesCount, 2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
  │   💬 Args: [trovesCount, 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [initialValues.spBoldBalance - finalSPBoldBalance, liquidationAmount + initialValues.AInterest, "SP Bold balance mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 8)
  │   💬 Args: [finalSPCollBalance - initialValues.spCollBalance, ((((liquidationAmount + initialValues.AInterest) * DECIMAL_PRECISION) / price) * 105) / 100, 10, "SP Coll balance mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 9)
  │   💬 Args: [collToken.balanceOf(address(collSurplusPool)), collSurplusAmount, 1, "CollSurplusPool should have received collateral"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 10)
  │   💬 Args: [collToken.balanceOf(address(collSurplusPool)), collSurplusPool.getCollBalance(), "CollSurplusPool balance and getter should match"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 11)
      💬 Args: [collToken.balanceOf(A) - initialValues.ACollBalance, collSurplusAmount, 1, "A collateral balance mismatch"]
      👁️  Def: internal
```
