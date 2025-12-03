# Function: testUrgentRedemptionAppliesInterestEarnedUpToShutdownTimeToTrove()

**Contract**: [test/shutdown.t.sol/contract_ShutdownTest.md]

## Metadata

- **Contract**: ShutdownTest
- **Signature**: `testUrgentRedemptionAppliesInterestEarnedUpToShutdownTimeToTrove()`
- **Visibility**: public
- **Source Range**: 37441:1633:333

## Implementation

```solidity
function testUrgentRedemptionAppliesInterestEarnedUpToShutdownTimeToTrove() public {
    openMulticollateralTroveNoHints100pctWithIndex(0, A, 0, 11e18, 9000e18, 5e16);
    vm.warp(block.timestamp + 1 days);
    openMulticollateralTroveNoHints100pctWithIndex(0, A, 1, 11e18, 10000e18, 6e16);
    vm.warp(block.timestamp + 1 days);
    uint256 troveId3 = openMulticollateralTroveNoHints100pctWithIndex(0, A, 2, 11e18, 11000e18, 7e16);
    vm.warp(block.timestamp + 1 days);
    uint256 price = 1000e18;
    contractsArray[0].priceFeed.setPrice(price);
    assertLt(troveManager.getTCR(price), SCR);
    contractsArray[0].borrowerOperations.shutdown();
    assertTrue(borrowerOperations.hasBeenShutDown());
    uint256 interest3_t0 = troveManager.calcTroveAccruedInterest((troveId3));
    assertGt(interest3_t0, 0);
    uint256 recordedDebt3 = troveManager.getTroveDebt(troveId3);
    assertGt(recordedDebt3, 0);
    uint256 redemptionAmount = 100e18;
    vm.startPrank(A);
    troveManager.urgentRedemption(redemptionAmount, uintToArray(troveId3), 0);
    vm.stopPrank();
    vm.warp(block.timestamp + 1 days);
    assertEq(troveManager.getTroveDebt(troveId3), (recordedDebt3 - redemptionAmount) + interest3_t0);
}
```

## Related Implementations

### openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 3292:1098:333
- **Link**: `test/shutdown.t.sol:ShutdownTest:openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256)`

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

### assertLt(uint256,uint256)

- **Kind**: internal
- **Source**: 11928:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLt(uint256,uint256)`

```solidity
function assertLt(uint256 left, uint256 right) virtual internal pure {
    vm.assertLt(left, right);
}
```

### assertTrue(bool)

- **Kind**: internal
- **Source**: 1594:89:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool)`

```solidity
function assertTrue(bool data) virtual internal pure {
    vm.assertTrue(data);
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

### uintToArray(uint256)

- **Kind**: internal
- **Source**: 20346:153:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:uintToArray(uint256)`

```solidity
function uintToArray(uint256 _value) public pure returns (uint256[] memory result) {
    result = new uint256[](1);
    result[0] = _value;
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

## External Calls

- **Vm::warp(uint256)**
- **IPriceFeedTestnet::setPrice(uint256)**
- **ITroveManagerTester::getTCR(uint256)**
- **IBorrowerOperationsTester::shutdown()**
- **IBorrowerOperationsTester::hasBeenShutDown()**
- **ITroveManagerTester::calcTroveAccruedInterest(uint256)**
- **ITroveManagerTester::getTroveDebt(uint256)**
- **Vm::startPrank(address)**
- **ITroveManagerTester::urgentRedemption(uint256,uint256[],uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **contractsArray** (`struct TestDeployer.LiquityContractsDev[]`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ShutdownTest.testUrgentRedemptionAppliesInterestEarnedUpToShutdownTimeToTrove() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ShutdownTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [0, A, 0, 11e18, 9000e18, 5e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 2)
  │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 3)
  │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ShutdownTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 4)
  │   💬 Args: [0, A, 1, 11e18, 10000e18, 6e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 5)
  │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 6)
  │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ShutdownTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 7)
  │   💬 Args: [0, A, 2, 11e18, 11000e18, 7e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 8)
  │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 9)
  │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 10)
  │   💬 Args: [troveManager.getTCR(price), SCR]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 11)
  │   💬 Args: [borrowerOperations.hasBeenShutDown()]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 12)
  │   💬 Args: [interest3_t0, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 13)
  │   💬 Args: [recordedDebt3, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.uintToArray(uint256) (NodeID: 14)
  │   💬 Args: [troveId3]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 15)
      💬 Args: [troveManager.getTroveDebt(troveId3), (recordedDebt3 - redemptionAmount) + interest3_t0]
      👁️  Def: internal
```
