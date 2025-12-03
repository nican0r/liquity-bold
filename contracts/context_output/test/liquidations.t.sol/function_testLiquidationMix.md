# Function: testLiquidationMix()

**Contract**: [test/liquidations.t.sol/contract_LiquidationsTest.md]

## Metadata

- **Contract**: LiquidationsTest
- **Signature**: `testLiquidationMix()`
- **Visibility**: public
- **Source Range**: 10210:5102:309

## Implementation

```solidity
function testLiquidationMix() public {
    LiquidationsTestVars memory vars;
    vars.liquidationAmount = 2000e18;
    vars.collAmount = 2e18;
    priceFeed.setPrice(2000e18);
    vm.startPrank(A);
    vars.ATroveId = borrowerOperations.openTrove(A, 0, vars.collAmount, vars.liquidationAmount, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    vm.stopPrank();
    vm.startPrank(B);
    vars.BTroveId = borrowerOperations.openTrove(B, 0, 2 * vars.collAmount, vars.liquidationAmount, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    vm.stopPrank();
    makeSPDepositAndClaim(B, vars.liquidationAmount / 2);
    priceFeed.setPrice(1100e18 - 1);
    (vars.price, ) = priceFeed.fetchPrice();
    vars.spBoldBalance = stabilityPool.getTotalBoldDeposits();
    vars.spCollBalance = stabilityPool.getCollBalance();
    vars.ACollBalance = collToken.balanceOf(A);
    vars.BDebt = troveManager.getTroveEntireDebt(vars.BTroveId);
    vars.BColl = troveManager.getTroveEntireColl(vars.BTroveId);
    assertEq(troveManager.checkBelowCriticalThreshold(vars.price), false, "System should not be below CT");
    assertLt(troveManager.getCurrentICR(vars.ATroveId, vars.price), MCR);
    assertGt(troveManager.getTCR(vars.price), CCR);
    uint256 trovesCount = troveManager.getTroveIdsCount();
    assertEq(trovesCount, 2);
    vars.AInterest = troveManager.getTroveEntireDebt(vars.ATroveId) - vars.liquidationAmount;
    troveManager.liquidate(vars.ATroveId);
    trovesCount = troveManager.getTroveIdsCount();
    assertEq(trovesCount, 1);
    uint256 finalSPBoldBalance = stabilityPool.getTotalBoldDeposits();
    assertEq(vars.spBoldBalance - finalSPBoldBalance, (vars.liquidationAmount / 2) - 1e18, "SP Bold balance mismatch");
    uint256 finalSPCollBalance = stabilityPool.getCollBalance();
    assertApproxEqAbs(finalSPCollBalance - vars.spCollBalance, (((((vars.liquidationAmount / 2) - 1e18) * DECIMAL_PRECISION) / vars.price) * 105) / 100, 10, "SP Coll balance mismatch");
    assertApproxEqAbs(troveManager.getTroveEntireDebt(vars.BTroveId) - vars.BDebt, ((vars.liquidationAmount / 2) + 1e18) + vars.AInterest, 3, "B debt mismatch");
    assertApproxEqAbs(troveManager.getTroveEntireColl(vars.BTroveId) - vars.BColl, ((((((vars.liquidationAmount / 2) + 1e18) + vars.AInterest) * DECIMAL_PRECISION) / vars.price) * 110) / 100, 10, "B trove coll mismatch");
    uint256 collSurplusAmount = ((((((vars.collAmount * ((vars.liquidationAmount / 2) - 1e18)) / (vars.liquidationAmount + vars.AInterest)) * 995) / 1000) - ((((((vars.liquidationAmount / 2) - 1e18) * DECIMAL_PRECISION) / vars.price) * 105) / 100)) + ((vars.collAmount * (((vars.liquidationAmount / 2) + 1e18) + vars.AInterest)) / (vars.liquidationAmount + vars.AInterest))) - (((((((vars.liquidationAmount / 2) + 1e18) + vars.AInterest) * DECIMAL_PRECISION) / vars.price) * 110) / 100);
    assertApproxEqAbs(collToken.balanceOf(address(collSurplusPool)), collSurplusAmount, 10, "CollSurplusPool should have received collateral");
    assertEq(collToken.balanceOf(address(collSurplusPool)), collSurplusPool.getCollBalance(), "CollSurplusPool balance and getter should match");
    vm.startPrank(A);
    borrowerOperations.claimCollateral();
    vm.stopPrank();
    assertApproxEqAbs(collToken.balanceOf(A) - vars.ACollBalance, collSurplusAmount, 10, "A collateral balance mismatch");
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

- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LiquidationsTest.testLiquidationMix() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 1)
  │   💬 Args: [B, vars.liquidationAmount / 2]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 2)
  │   💬 Args: [troveManager.checkBelowCriticalThreshold(vars.price), false, "System should not be below CT"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 3)
  │   💬 Args: [troveManager.getCurrentICR(vars.ATroveId, vars.price), MCR]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 4)
  │   💬 Args: [troveManager.getTCR(vars.price), CCR]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [trovesCount, 2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
  │   💬 Args: [trovesCount, 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [vars.spBoldBalance - finalSPBoldBalance, (vars.liquidationAmount / 2) - 1e18, "SP Bold balance mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 8)
  │   💬 Args: [finalSPCollBalance - vars.spCollBalance, (((((vars.liquidationAmount / 2) - 1e18) * DECIMAL_PRECISION) / vars.price) * 105) / 100, 10, "SP Coll balance mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 9)
  │   💬 Args: [troveManager.getTroveEntireDebt(vars.BTroveId) - vars.BDebt, ((vars.liquidationAmount / 2) + 1e18) + vars.AInterest, 3, "B debt mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 10)
  │   💬 Args: [troveManager.getTroveEntireColl(vars.BTroveId) - vars.BColl, ((((((vars.liquidationAmount / 2) + 1e18) + vars.AInterest) * DECIMAL_PRECISION) / vars.price) * 110) / 100, 10, "B trove coll mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 11)
  │   💬 Args: [collToken.balanceOf(address(collSurplusPool)), collSurplusAmount, 10, "CollSurplusPool should have received collateral"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 12)
  │   💬 Args: [collToken.balanceOf(address(collSurplusPool)), collSurplusPool.getCollBalance(), "CollSurplusPool balance and getter should match"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 13)
      💬 Args: [collToken.balanceOf(A) - vars.ACollBalance, collSurplusAmount, 10, "A collateral balance mismatch"]
      👁️  Def: internal
```
