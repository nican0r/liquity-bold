# Function: testIndividualTrovesDontAcrrueInterestAfterShutdown()

**Contract**: [test/shutdown.t.sol/contract_ShutdownTest.md]

## Metadata

- **Contract**: ShutdownTest
- **Signature**: `testIndividualTrovesDontAcrrueInterestAfterShutdown()`
- **Visibility**: public
- **Source Range**: 32212:1837:333

## Implementation

```solidity
function testIndividualTrovesDontAcrrueInterestAfterShutdown() public {
    uint256 troveId1 = openMulticollateralTroveNoHints100pctWithIndex(0, A, 0, 11e18, 9000e18, 5e16);
    vm.warp(block.timestamp + 1 days);
    uint256 troveId2 = openMulticollateralTroveNoHints100pctWithIndex(0, A, 1, 11e18, 10000e18, 6e16);
    vm.warp(block.timestamp + 1 days);
    uint256 troveId3 = openMulticollateralTroveNoHints100pctWithIndex(0, A, 2, 11e18, 11000e18, 7e16);
    vm.warp(block.timestamp + 1 days);
    uint256 interest1_t0 = troveManager.calcTroveAccruedInterest((troveId1));
    uint256 interest2_t0 = troveManager.calcTroveAccruedInterest((troveId2));
    uint256 interest3_t0 = troveManager.calcTroveAccruedInterest((troveId3));
    assertGt(interest1_t0, 0);
    assertGt(interest2_t0, 0);
    assertGt(interest3_t0, 0);
    uint256 price = 1000e18;
    contractsArray[0].priceFeed.setPrice(price);
    assertLt(troveManager.getTCR(price), SCR);
    contractsArray[0].borrowerOperations.shutdown();
    assertTrue(borrowerOperations.hasBeenShutDown());
    vm.warp(block.timestamp + 1 days);
    uint256 interest1_t1 = troveManager.calcTroveAccruedInterest((troveId1));
    uint256 interest2_t1 = troveManager.calcTroveAccruedInterest((troveId2));
    uint256 interest3_t1 = troveManager.calcTroveAccruedInterest((troveId3));
    assertEq(interest1_t1, interest1_t0);
    assertEq(interest2_t1, interest2_t0);
    assertEq(interest3_t1, interest3_t0);
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

### assertGt(uint256,uint256)

- **Kind**: internal
- **Source**: 13112:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256)`

```solidity
function assertGt(uint256 left, uint256 right) virtual internal pure {
    vm.assertGt(left, right);
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
- **ITroveManagerTester::calcTroveAccruedInterest(uint256)**
- **IPriceFeedTestnet::setPrice(uint256)**
- **ITroveManagerTester::getTCR(uint256)**
- **IBorrowerOperationsTester::shutdown()**
- **IBorrowerOperationsTester::hasBeenShutDown()**

## State Variable Reads

- **contractsArray** (`struct TestDeployer.LiquityContractsDev[]`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ShutdownTest.testIndividualTrovesDontAcrrueInterestAfterShutdown() (NodeID: 0)
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
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 10)
  │   💬 Args: [interest1_t0, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 11)
  │   💬 Args: [interest2_t0, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 12)
  │   💬 Args: [interest3_t0, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 13)
  │   💬 Args: [troveManager.getTCR(price), SCR]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 14)
  │   💬 Args: [borrowerOperations.hasBeenShutDown()]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 15)
  │   💬 Args: [interest1_t1, interest1_t0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 16)
  │   💬 Args: [interest2_t1, interest2_t0]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 17)
      💬 Args: [interest3_t1, interest3_t0]
      👁️  Def: internal
```
