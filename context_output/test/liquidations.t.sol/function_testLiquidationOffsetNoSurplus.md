# Function: testLiquidationOffsetNoSurplus()

**Contract**: [test/liquidations.t.sol/contract_LiquidationsTest.md]

## Metadata

- **Contract**: LiquidationsTest
- **Signature**: `testLiquidationOffsetNoSurplus()`
- **Visibility**: public
- **Source Range**: 4227:3013:309

## Implementation

```solidity
function testLiquidationOffsetNoSurplus() public {
    uint256 liquidationAmount = 10000e18;
    uint256 collAmount = 10e18;
    priceFeed.setPrice(2000e18);
    vm.startPrank(A);
    uint256 ATroveId = borrowerOperations.openTrove(A, 0, collAmount, liquidationAmount, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    vm.stopPrank();
    vm.startPrank(B);
    borrowerOperations.openTrove(B, 0, 3 * collAmount, liquidationAmount + 100e18, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    vm.stopPrank();
    makeSPDepositAndClaim(B, liquidationAmount + 100e18);
    priceFeed.setPrice(1030e18);
    (uint256 price, ) = priceFeed.fetchPrice();
    uint256 initialSPBoldBalance = stabilityPool.getTotalBoldDeposits();
    uint256 initialSPCollBalance = stabilityPool.getCollBalance();
    assertEq(troveManager.checkBelowCriticalThreshold(price), false, "System should not be below CT");
    assertLt(troveManager.getCurrentICR(ATroveId, price), MCR, "ICR too high");
    assertGe(troveManager.getTCR(price), CCR, "TCR too low");
    uint256 trovesCount = troveManager.getTroveIdsCount();
    assertEq(trovesCount, 2);
    uint256 AInterest = troveManager.getTroveEntireDebt(ATroveId) - liquidationAmount;
    troveManager.liquidate(ATroveId);
    trovesCount = troveManager.getTroveIdsCount();
    assertEq(trovesCount, 1);
    uint256 finalSPBoldBalance = stabilityPool.getTotalBoldDeposits();
    assertEq(initialSPBoldBalance - finalSPBoldBalance, liquidationAmount + AInterest, "SP Bold balance mismatch");
    uint256 finalSPCollBalance = stabilityPool.getCollBalance();
    assertApproxEqAbs(finalSPCollBalance - initialSPCollBalance, (collAmount * 995) / 1000, 10, "SP Coll balance mismatch");
    assertEq(collToken.balanceOf(address(collSurplusPool)), 0, "CollSurplusPool should be empty");
    assertEq(collToken.balanceOf(address(collSurplusPool)), collSurplusPool.getCollBalance(), "CollSurplusPool balance and getter should match");
    vm.startPrank(A);
    vm.expectRevert("CollSurplusPool: No collateral available to claim");
    borrowerOperations.claimCollateral();
    vm.stopPrank();
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

### assertLt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 12044:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLt(uint256,uint256,string)`

```solidity
function assertLt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertLt(left, right, err);
}
```

### assertGe(uint256,uint256,string)

- **Kind**: internal
- **Source**: 15596:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGe(uint256,uint256,string)`

```solidity
function assertGe(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertGe(left, right, err);
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
- **ITroveManagerTester::checkBelowCriticalThreshold(uint256)**
- **ITroveManagerTester::getCurrentICR(uint256,uint256)**
- **ITroveManagerTester::getTCR(uint256)**
- **ITroveManagerTester::getTroveIdsCount()**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **ITroveManagerTester::liquidate(uint256)**
- **IERC20::balanceOf(address)**
- **ICollSurplusPool::getCollBalance()**
- **Vm::expectRevert(bytes)**
- **IBorrowerOperationsTester::claimCollateral()**

## State Variable Reads

- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LiquidationsTest.testLiquidationOffsetNoSurplus() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 1)
  │   💬 Args: [B, liquidationAmount + 100e18]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 2)
  │   💬 Args: [troveManager.checkBelowCriticalThreshold(price), false, "System should not be below CT"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [troveManager.getCurrentICR(ATroveId, price), MCR, "ICR too high"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [troveManager.getTCR(price), CCR, "TCR too low"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [trovesCount, 2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
  │   💬 Args: [trovesCount, 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [initialSPBoldBalance - finalSPBoldBalance, liquidationAmount + AInterest, "SP Bold balance mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 8)
  │   💬 Args: [finalSPCollBalance - initialSPCollBalance, (collAmount * 995) / 1000, 10, "SP Coll balance mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 9)
  │   💬 Args: [collToken.balanceOf(address(collSurplusPool)), 0, "CollSurplusPool should be empty"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 10)
      💬 Args: [collToken.balanceOf(address(collSurplusPool)), collSurplusPool.getCollBalance(), "CollSurplusPool balance and getter should match"]
      👁️  Def: internal
```
