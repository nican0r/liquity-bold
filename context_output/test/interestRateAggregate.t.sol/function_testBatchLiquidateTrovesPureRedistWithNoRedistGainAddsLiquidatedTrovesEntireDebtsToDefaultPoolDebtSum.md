# Function: testBatchLiquidateTrovesPureRedistWithNoRedistGainAddsLiquidatedTrovesEntireDebtsToDefaultPoolDebtSum()

**Contract**: [test/interestRateAggregate.t.sol/contract_InterestRateAggregate.md]

## Metadata

- **Contract**: InterestRateAggregate
- **Signature**: `testBatchLiquidateTrovesPureRedistWithNoRedistGainAddsLiquidatedTrovesEntireDebtsToDefaultPoolDebtSum()`
- **Visibility**: public
- **Source Range**: 69088:1473:306

## Implementation

```solidity
function testBatchLiquidateTrovesPureRedistWithNoRedistGainAddsLiquidatedTrovesEntireDebtsToDefaultPoolDebtSum() public {
    (uint256 ATroveId, , uint256 CTroveId, uint256 DTroveId) = _setupForBatchLiquidateTrovesPureRedist();
    vm.warp(block.timestamp + 1 days);
    uint256 recordedTroveDebt_C = troveManager.getTroveDebt(CTroveId);
    uint256 accruedInterest_C = troveManager.calcTroveAccruedInterest(CTroveId);
    assertGt(recordedTroveDebt_C, 0);
    assertGt(accruedInterest_C, 0);
    uint256 recordedTroveDebt_D = troveManager.getTroveDebt(DTroveId);
    uint256 accruedInterest_D = troveManager.calcTroveAccruedInterest(CTroveId);
    assertGt(recordedTroveDebt_D, 0);
    assertGt(accruedInterest_D, 0);
    uint256 debtInLiq = ((recordedTroveDebt_C + accruedInterest_C) + recordedTroveDebt_D) + accruedInterest_D;
    uint256 defaultPoolDebt = defaultPool.getBoldDebt();
    assertEq(defaultPoolDebt, 0);
    uint256[] memory trovesToLiq = new uint256[](2);
    trovesToLiq[0] = CTroveId;
    trovesToLiq[1] = DTroveId;
    batchLiquidateTroves(A, trovesToLiq);
    assertTrue(troveManager.hasRedistributionGains(ATroveId));
    assertEq(defaultPool.getBoldDebt(), debtInLiq);
}
```

## Related Implementations

### _setupForBatchLiquidateTrovesPureRedist()

- **Kind**: internal
- **Source**: 8036:1172:261
- **Link**: `test/TestContracts/DevTestSetup.sol:DevTestSetup:_setupForBatchLiquidateTrovesPureRedist()`

```solidity
function _setupForBatchLiquidateTrovesPureRedist() internal returns (uint256, uint256, uint256, uint256) {
    uint256 troveDebtRequest_A = 2200e18;
    uint256 troveDebtRequest_B = 3200e18;
    uint256 troveDebtRequest_C = 2450e18;
    uint256 troveDebtRequest_D = 2450e18;
    uint256 interestRate = 5e16;
    uint256 price = 2000e18;
    priceFeed.setPrice(price);
    uint256 ATroveId = openTroveNoHints100pct(A, 5 ether, troveDebtRequest_A, interestRate);
    uint256 BTroveId = openTroveNoHints100pct(B, 5 ether, troveDebtRequest_B, interestRate);
    uint256 CTroveId = openTroveNoHints100pct(C, 25e17, troveDebtRequest_C, interestRate);
    uint256 DTroveId = openTroveNoHints100pct(D, 25e17, troveDebtRequest_D, interestRate);
    price = 1050e18;
    priceFeed.setPrice(price);
    assertFalse(troveManager.checkBelowCriticalThreshold(price));
    assertLt(troveManager.getCurrentICR(CTroveId, price), MCR);
    assertLt(troveManager.getCurrentICR(DTroveId, price), MCR);
    return (ATroveId, BTroveId, CTroveId, DTroveId);
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

### batchLiquidateTroves(address,uint256[])

- **Kind**: internal
- **Source**: 13766:199:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:batchLiquidateTroves(address,uint256[])`

```solidity
function batchLiquidateTroves(address _from, uint256[] memory _trovesList) public {
    vm.startPrank(_from);
    troveManager.batchLiquidateTroves(_trovesList);
    vm.stopPrank();
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

## External Calls

- **Vm::warp(uint256)**
- **ITroveManagerTester::getTroveDebt(uint256)**
- **ITroveManagerTester::calcTroveAccruedInterest(uint256)**
- **IDefaultPool::getBoldDebt()**
- **ITroveManagerTester::hasRedistributionGains(uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **troveManager** (`contract ITroveManagerTester`) [test/TestContracts/Interfaces/ITroveManagerTester.sol/interface_ITroveManagerTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestRateAggregate.testBatchLiquidateTrovesPureRedistWithNoRedistGainAddsLiquidatedTrovesEntireDebtsToDefaultPoolDebtSum() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: DevTestSetup._setupForBatchLiquidateTrovesPureRedist() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 2)
  │ │   💬 Args: [A, 5 ether, troveDebtRequest_A, interestRate]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 3)
  │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │     👁️  Def: public
  │ │   └─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 4)
  │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 5)
  │ │   💬 Args: [B, 5 ether, troveDebtRequest_B, interestRate]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 6)
  │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │     👁️  Def: public
  │ │   └─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 7)
  │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 8)
  │ │   💬 Args: [C, 25e17, troveDebtRequest_C, interestRate]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 9)
  │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │     👁️  Def: public
  │ │   └─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 10)
  │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 11)
  │ │   💬 Args: [D, 25e17, troveDebtRequest_D, interestRate]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 12)
  │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │     👁️  Def: public
  │ │   └─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 13)
  │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertFalse(bool) (NodeID: 14)
  │ │   💬 Args: [troveManager.checkBelowCriticalThreshold(price)]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 15)
  │ │   💬 Args: [troveManager.getCurrentICR(CTroveId, price), MCR]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 16)
  │     💬 Args: [troveManager.getCurrentICR(DTroveId, price), MCR]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 17)
  │   💬 Args: [recordedTroveDebt_C, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 18)
  │   💬 Args: [accruedInterest_C, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 19)
  │   💬 Args: [recordedTroveDebt_D, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 20)
  │   💬 Args: [accruedInterest_D, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 21)
  │   💬 Args: [defaultPoolDebt, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.batchLiquidateTroves(address,uint256[]) (NodeID: 22)
  │   💬 Args: [A, trovesToLiq]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 23)
  │   💬 Args: [troveManager.hasRedistributionGains(ATroveId)]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 24)
      💬 Args: [defaultPool.getBoldDebt(), debtInLiq]
      👁️  Def: internal
```
