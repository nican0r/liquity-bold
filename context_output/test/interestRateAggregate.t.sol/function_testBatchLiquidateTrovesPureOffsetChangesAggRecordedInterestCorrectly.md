# Function: testBatchLiquidateTrovesPureOffsetChangesAggRecordedInterestCorrectly()

**Contract**: [test/interestRateAggregate.t.sol/contract_InterestRateAggregate.md]

## Metadata

- **Contract**: InterestRateAggregate
- **Signature**: `testBatchLiquidateTrovesPureOffsetChangesAggRecordedInterestCorrectly()`
- **Visibility**: public
- **Source Range**: 56488:1906:306

## Implementation

```solidity
function testBatchLiquidateTrovesPureOffsetChangesAggRecordedInterestCorrectly() public {
    (, , uint256 CTroveId, uint256 DTroveId) = _setupForBatchLiquidateTrovesPureOffset(1);
    vm.warp(block.timestamp + 1 days);
    uint256 aggRecordedDebt_1 = activePool.aggRecordedDebt();
    assertGt(aggRecordedDebt_1, 0);
    uint256 pendingAggInterest = activePool.calcPendingAggInterest();
    assertGt(pendingAggInterest, 0);
    uint256 recordedDebt_C = troveManager.getTroveDebt(CTroveId);
    uint256 recordedDebt_D = troveManager.getTroveDebt(DTroveId);
    assertGt(recordedDebt_C, 0);
    assertGt(recordedDebt_D, 0);
    uint256 recordedDebtInLiq = recordedDebt_C + recordedDebt_D;
    uint256 accruedInterest_C = troveManager.calcTroveAccruedInterest(CTroveId);
    uint256 accruedInterest_D = troveManager.calcTroveAccruedInterest(DTroveId);
    assertGt(accruedInterest_C, 0);
    assertGt(accruedInterest_D, 0);
    uint256 accruedInterestInLiq = accruedInterest_C + accruedInterest_D;
    uint256[] memory trovesToLiq = new uint256[](2);
    trovesToLiq[0] = CTroveId;
    trovesToLiq[1] = DTroveId;
    batchLiquidateTroves(A, trovesToLiq);
    assertEq(uint8(troveManager.getTroveStatus(CTroveId)), uint8(ITroveManager.Status.closedByLiquidation));
    assertEq(uint8(troveManager.getTroveStatus(DTroveId)), uint8(ITroveManager.Status.closedByLiquidation));
    assertEq(activePool.aggRecordedDebt(), ((aggRecordedDebt_1 + pendingAggInterest) - recordedDebtInLiq) - accruedInterestInLiq);
}
```

## Related Implementations

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

### assertGt(uint256,uint256)

- **Kind**: internal
- **Source**: 13112:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256)`

```solidity
function assertGt(uint256 left, uint256 right) virtual internal pure {
    vm.assertGt(left, right);
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
- **IActivePool::aggRecordedDebt()**
- **IActivePool::calcPendingAggInterest()**
- **ITroveManagerTester::getTroveDebt(uint256)**
- **ITroveManagerTester::calcTroveAccruedInterest(uint256)**
- **ITroveManagerTester::getTroveStatus(uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **troveManager** (`contract ITroveManagerTester`) [test/TestContracts/Interfaces/ITroveManagerTester.sol/interface_ITroveManagerTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestRateAggregate.testBatchLiquidateTrovesPureOffsetChangesAggRecordedInterestCorrectly() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: DevTestSetup._setupForBatchLiquidateTrovesPureOffset(uint256) (NodeID: 1)
  │   💬 Args: [1]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 2)
  │ │   💬 Args: [A, 5 ether * _magnitude, troveDebtRequest_A, interestRate]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 3)
  │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │     👁️  Def: public
  │ │   └─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 4)
  │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 5)
  │ │   💬 Args: [B, 5 ether * _magnitude, troveDebtRequest_B, interestRate]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 6)
  │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │     👁️  Def: public
  │ │   └─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 7)
  │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 8)
  │ │   💬 Args: [C, 25e17 * _magnitude, troveDebtRequest_C, interestRate]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 9)
  │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │     👁️  Def: public
  │ │   └─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 10)
  │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 11)
  │ │   💬 Args: [D, 25e17 * _magnitude, troveDebtRequest_D, interestRate]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 12)
  │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │     👁️  Def: public
  │ │   └─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 13)
  │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 14)
  │ │   💬 Args: [A, troveDebtRequest_A]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 15)
  │ │   💬 Args: [B, troveDebtRequest_B]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertFalse(bool) (NodeID: 16)
  │ │   💬 Args: [troveManager.checkBelowCriticalThreshold(price)]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 17)
  │ │   💬 Args: [troveManager.getCurrentICR(troveIDs.C, price), MCR]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 18)
  │     💬 Args: [troveManager.getCurrentICR(troveIDs.D, price), MCR]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 19)
  │   💬 Args: [aggRecordedDebt_1, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 20)
  │   💬 Args: [pendingAggInterest, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 21)
  │   💬 Args: [recordedDebt_C, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 22)
  │   💬 Args: [recordedDebt_D, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 23)
  │   💬 Args: [accruedInterest_C, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 24)
  │   💬 Args: [accruedInterest_D, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.batchLiquidateTroves(address,uint256[]) (NodeID: 25)
  │   💬 Args: [A, trovesToLiq]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 26)
  │   💬 Args: [uint8(troveManager.getTroveStatus(CTroveId)), uint8(ITroveManager.Status.closedByLiquidation)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 27)
  │   💬 Args: [uint8(troveManager.getTroveStatus(DTroveId)), uint8(ITroveManager.Status.closedByLiquidation)]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 28)
      💬 Args: [activePool.aggRecordedDebt(), ((aggRecordedDebt_1 + pendingAggInterest) - recordedDebtInLiq) - accruedInterestInLiq]
      👁️  Def: internal
```
