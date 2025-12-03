# Function: testGetDepositorBoldGain_2SPDepositor1LiqFreshDeposit_EarnFairShareOfSPYield()

**Contract**: [test/stabilityPool.t.sol/contract_SPTest.md]

## Metadata

- **Contract**: SPTest
- **Signature**: `testGetDepositorBoldGain_2SPDepositor1LiqFreshDeposit_EarnFairShareOfSPYield()`
- **Visibility**: public
- **Source Range**: 56500:5269:334

## Implementation

```solidity
function testGetDepositorBoldGain_2SPDepositor1LiqFreshDeposit_EarnFairShareOfSPYield() public {
    ABCDEF memory troveIDs = _setupForSPDepositAdjustments();
    ABCDEF[3] memory expectedShareOfReward;
    vm.warp((block.timestamp + 90 days) + 1);
    uint256 pendingAggInterest_0 = activePool.calcPendingAggInterest();
    assertGt(pendingAggInterest_0, 0);
    uint256 expectedSpYield_0 = (SP_YIELD_SPLIT * pendingAggInterest_0) / 1e18;
    expectedShareOfReward[0].A = getShareofSPReward(A, expectedSpYield_0);
    expectedShareOfReward[0].B = getShareofSPReward(B, expectedSpYield_0);
    assertGt(expectedShareOfReward[0].A, 0);
    assertGt(expectedShareOfReward[0].B, 0);
    uint256 totalSPDeposits_0 = stabilityPool.getTotalBoldDeposits();
    assertApproximatelyEqual(expectedShareOfReward[0].A + expectedShareOfReward[0].B, expectedSpYield_0, 1e3);
    makeSPWithdrawalAndClaim(A, 500e18);
    assertEq(stabilityPool.getDepositorYieldGain(A), 0, "A yield gain should be 0");
    assertEq(activePool.calcPendingAggInterest(), 0, "Pending agg interest should be 0");
    liquidate(A, troveIDs.D);
    assertEq(stabilityPool.getTotalBoldDeposits(), 1e18, "SP total bold deposits should be 1e18");
    assertLt(stabilityPool.getCompoundedBoldDeposit(A), 1e18, "A should have <1e18 deposit");
    assertLt(stabilityPool.getCompoundedBoldDeposit(B), 1e18, "B should have <1e18 deposit");
    assertLe(stabilityPool.getCompoundedBoldDeposit(B) + stabilityPool.getCompoundedBoldDeposit(A), 1e18, "A & B deposits should sum to <=1e18");
    uint256 deposit_C = 1e18;
    uint256 deposit_D = 1e18;
    makeSPDepositAndClaim(C, deposit_C);
    transferBold(C, D, deposit_D);
    makeSPDepositAndClaim(D, deposit_D);
    uint256 totalSPDeposits_1 = stabilityPool.getTotalBoldDeposits();
    assertGt(totalSPDeposits_1, 0);
    assertLt(totalSPDeposits_1, totalSPDeposits_0);
    vm.warp((block.timestamp + STALE_TROVE_DURATION) + 1);
    uint256 pendingAggInterest_1 = activePool.calcPendingAggInterest();
    assertGt(pendingAggInterest_1, 0);
    uint256 expectedSpYield_1 = (SP_YIELD_SPLIT * pendingAggInterest_1) / 1e18;
    expectedShareOfReward[1].A = getShareofSPReward(A, expectedSpYield_1);
    expectedShareOfReward[1].B = getShareofSPReward(B, expectedSpYield_1);
    expectedShareOfReward[1].C = getShareofSPReward(C, expectedSpYield_1);
    expectedShareOfReward[1].D = getShareofSPReward(D, expectedSpYield_1);
    assertGt(expectedShareOfReward[1].A, 0);
    assertGt(expectedShareOfReward[1].B, 0);
    assertGt(expectedShareOfReward[1].C, 0);
    assertGt(expectedShareOfReward[1].D, 0);
    assertLt(expectedShareOfReward[1].A, expectedShareOfReward[1].C);
    assertLt(expectedShareOfReward[1].A, expectedShareOfReward[1].D);
    assertLt(expectedShareOfReward[1].B, expectedShareOfReward[1].C);
    assertLt(expectedShareOfReward[1].B, expectedShareOfReward[1].D);
    assertApproximatelyEqual(((expectedShareOfReward[1].A + expectedShareOfReward[1].B) + expectedShareOfReward[1].C) + expectedShareOfReward[1].D, expectedSpYield_1, 1e4, "expected shares should sum up to the total expected yield");
    applyPendingDebt(B, troveIDs.A);
    assertApproximatelyEqual(stabilityPool.getDepositorYieldGain(A), expectedShareOfReward[1].A, 1e4, "A should receive only 2nd reward");
    assertApproximatelyEqual(stabilityPool.getDepositorYieldGain(B), expectedShareOfReward[0].B + expectedShareOfReward[1].B, 1e4, "B should receive only their share of 1st and 2nd");
    assertApproximatelyEqual(stabilityPool.getDepositorYieldGain(C), expectedShareOfReward[1].C, 1e4, "C should receive a share of both reward 1 and 2");
}
```

## Related Implementations

### _setupForSPDepositAdjustments()

- **Kind**: internal
- **Source**: 5907:548:261
- **Link**: `test/TestContracts/DevTestSetup.sol:DevTestSetup:_setupForSPDepositAdjustments()`

```solidity
function _setupForSPDepositAdjustments() internal returns (ABCDEF memory troveIDs) {
    (troveIDs.A, troveIDs.B, troveIDs.C, troveIDs.D) = _setupForBatchLiquidateTrovesPureOffset(1);
    liquidate(A, troveIDs.C);
    transferBold(D, A, boldToken.balanceOf(D) / 2);
    transferBold(D, B, boldToken.balanceOf(D));
    assertEq(uint8(troveManager.getTroveStatus(troveIDs.C)), uint8(ITroveManager.Status.closedByLiquidation));
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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
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

### assertLe(uint256,uint256,string)

- **Kind**: internal
- **Source**: 14412:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLe(uint256,uint256,string)`

```solidity
function assertLe(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertLe(left, right, err);
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

- **Vm::warp(uint256)**
- **IActivePool::calcPendingAggInterest()**
- **IStabilityPool::getTotalBoldDeposits()**
- **IStabilityPool::getDepositorYieldGain(address)**
- **IStabilityPool::getCompoundedBoldDeposit(address)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **troveManager** (`contract ITroveManagerTester`) [test/TestContracts/Interfaces/ITroveManagerTester.sol/interface_ITroveManagerTester.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SPTest.testGetDepositorBoldGain_2SPDepositor1LiqFreshDeposit_EarnFairShareOfSPYield() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: DevTestSetup._setupForSPDepositAdjustments() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: DevTestSetup._setupForBatchLiquidateTrovesPureOffset(uint256) (NodeID: 2)
  │ │   💬 Args: [1]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 3)
  │ │ │   💬 Args: [A, 5 ether * _magnitude, troveDebtRequest_A, interestRate]
  │ │ │   👁️  Def: public
  │ │ │ └─ [4] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 4)
  │ │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │ │     👁️  Def: public
  │ │ │   └─ [5] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 5)
  │ │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 6)
  │ │ │   💬 Args: [B, 5 ether * _magnitude, troveDebtRequest_B, interestRate]
  │ │ │   👁️  Def: public
  │ │ │ └─ [4] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 7)
  │ │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │ │     👁️  Def: public
  │ │ │   └─ [5] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 8)
  │ │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 9)
  │ │ │   💬 Args: [C, 25e17 * _magnitude, troveDebtRequest_C, interestRate]
  │ │ │   👁️  Def: public
  │ │ │ └─ [4] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 10)
  │ │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │ │     👁️  Def: public
  │ │ │   └─ [5] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 11)
  │ │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 12)
  │ │ │   💬 Args: [D, 25e17 * _magnitude, troveDebtRequest_D, interestRate]
  │ │ │   👁️  Def: public
  │ │ │ └─ [4] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 13)
  │ │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │ │     👁️  Def: public
  │ │ │   └─ [5] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 14)
  │ │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 15)
  │ │ │   💬 Args: [A, troveDebtRequest_A]
  │ │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 16)
  │ │ │   💬 Args: [B, troveDebtRequest_B]
  │ │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: StdAssertions.assertFalse(bool) (NodeID: 17)
  │ │ │   💬 Args: [troveManager.checkBelowCriticalThreshold(price)]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 18)
  │ │ │   💬 Args: [troveManager.getCurrentICR(troveIDs.C, price), MCR]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 19)
  │ │     💬 Args: [troveManager.getCurrentICR(troveIDs.D, price), MCR]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.liquidate(address,uint256) (NodeID: 20)
  │ │   💬 Args: [A, troveIDs.C]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.transferBold(address,address,uint256) (NodeID: 21)
  │ │   💬 Args: [D, A, boldToken.balanceOf(D) / 2]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.transferBold(address,address,uint256) (NodeID: 22)
  │ │   💬 Args: [D, B, boldToken.balanceOf(D)]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 23)
  │     💬 Args: [uint8(troveManager.getTroveStatus(troveIDs.C)), uint8(ITroveManager.Status.closedByLiquidation)]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 24)
  │   💬 Args: [pendingAggInterest_0, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.getShareofSPReward(address,uint256) (NodeID: 25)
  │   💬 Args: [A, expectedSpYield_0]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.getShareofSPReward(address,uint256) (NodeID: 26)
  │   💬 Args: [B, expectedSpYield_0]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 27)
  │   💬 Args: [expectedShareOfReward[0].A, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 28)
  │   💬 Args: [expectedShareOfReward[0].B, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256) (NodeID: 29)
  │   💬 Args: [expectedShareOfReward[0].A + expectedShareOfReward[0].B, expectedSpYield_0, 1e3]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 30)
  │     💬 Args: [_x, _y, _margin, ""]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPWithdrawalAndClaim(address,uint256) (NodeID: 31)
  │   💬 Args: [A, 500e18]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 32)
  │   💬 Args: [stabilityPool.getDepositorYieldGain(A), 0, "A yield gain should be 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 33)
  │   💬 Args: [activePool.calcPendingAggInterest(), 0, "Pending agg interest should be 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.liquidate(address,uint256) (NodeID: 34)
  │   💬 Args: [A, troveIDs.D]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 35)
  │   💬 Args: [stabilityPool.getTotalBoldDeposits(), 1e18, "SP total bold deposits should be 1e18"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 36)
  │   💬 Args: [stabilityPool.getCompoundedBoldDeposit(A), 1e18, "A should have <1e18 deposit"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 37)
  │   💬 Args: [stabilityPool.getCompoundedBoldDeposit(B), 1e18, "B should have <1e18 deposit"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256,string) (NodeID: 38)
  │   💬 Args: [stabilityPool.getCompoundedBoldDeposit(B) + stabilityPool.getCompoundedBoldDeposit(A), 1e18, "A & B deposits should sum to <=1e18"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 39)
  │   💬 Args: [C, deposit_C]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.transferBold(address,address,uint256) (NodeID: 40)
  │   💬 Args: [C, D, deposit_D]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 41)
  │   💬 Args: [D, deposit_D]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 42)
  │   💬 Args: [totalSPDeposits_1, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 43)
  │   💬 Args: [totalSPDeposits_1, totalSPDeposits_0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 44)
  │   💬 Args: [pendingAggInterest_1, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.getShareofSPReward(address,uint256) (NodeID: 45)
  │   💬 Args: [A, expectedSpYield_1]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.getShareofSPReward(address,uint256) (NodeID: 46)
  │   💬 Args: [B, expectedSpYield_1]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.getShareofSPReward(address,uint256) (NodeID: 47)
  │   💬 Args: [C, expectedSpYield_1]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.getShareofSPReward(address,uint256) (NodeID: 48)
  │   💬 Args: [D, expectedSpYield_1]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 49)
  │   💬 Args: [expectedShareOfReward[1].A, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 50)
  │   💬 Args: [expectedShareOfReward[1].B, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 51)
  │   💬 Args: [expectedShareOfReward[1].C, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 52)
  │   💬 Args: [expectedShareOfReward[1].D, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 53)
  │   💬 Args: [expectedShareOfReward[1].A, expectedShareOfReward[1].C]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 54)
  │   💬 Args: [expectedShareOfReward[1].A, expectedShareOfReward[1].D]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 55)
  │   💬 Args: [expectedShareOfReward[1].B, expectedShareOfReward[1].C]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 56)
  │   💬 Args: [expectedShareOfReward[1].B, expectedShareOfReward[1].D]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256,string) (NodeID: 57)
  │   💬 Args: [((expectedShareOfReward[1].A + expectedShareOfReward[1].B) + expectedShareOfReward[1].C) + expectedShareOfReward[1].D, expectedSpYield_1, 1e4, "expected shares should sum up to the total expected yield"]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 58)
  │     💬 Args: [_x, _y, _margin, _reason]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.applyPendingDebt(address,uint256) (NodeID: 59)
  │   💬 Args: [B, troveIDs.A]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256,string) (NodeID: 60)
  │   💬 Args: [stabilityPool.getDepositorYieldGain(A), expectedShareOfReward[1].A, 1e4, "A should receive only 2nd reward"]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 61)
  │     💬 Args: [_x, _y, _margin, _reason]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256,string) (NodeID: 62)
  │   💬 Args: [stabilityPool.getDepositorYieldGain(B), expectedShareOfReward[0].B + expectedShareOfReward[1].B, 1e4, "B should receive only their share of 1st and 2nd"]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 63)
  │     💬 Args: [_x, _y, _margin, _reason]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256,string) (NodeID: 64)
      💬 Args: [stabilityPool.getDepositorYieldGain(C), expectedShareOfReward[1].C, 1e4, "C should receive a share of both reward 1 and 2"]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 65)
        💬 Args: [_x, _y, _margin, _reason]
        👁️  Def: internal
```
