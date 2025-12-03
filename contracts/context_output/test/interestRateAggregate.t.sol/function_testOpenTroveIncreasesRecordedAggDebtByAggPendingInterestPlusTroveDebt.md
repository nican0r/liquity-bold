# Function: testOpenTroveIncreasesRecordedAggDebtByAggPendingInterestPlusTroveDebt()

**Contract**: [test/interestRateAggregate.t.sol/contract_InterestRateAggregate.md]

## Metadata

- **Contract**: InterestRateAggregate
- **Signature**: `testOpenTroveIncreasesRecordedAggDebtByAggPendingInterestPlusTroveDebt()`
- **Visibility**: public
- **Source Range**: 5834:1470:306

## Implementation

```solidity
function testOpenTroveIncreasesRecordedAggDebtByAggPendingInterestPlusTroveDebt() public {
    priceFeed.setPrice(2000e18);
    assertEq(activePool.aggRecordedDebt(), 0);
    uint256 troveDebtRequest = 2000e18;
    openTroveNoHints100pct(A, 2 ether, troveDebtRequest, 25e16);
    uint256 debt_A = troveDebtRequest;
    debt_A += calcUpfrontFee(debt_A, 25e16);
    uint256 weightedRecordedDebt_A = debt_A * 25e16;
    uint256 aggREcordedDebt_1 = activePool.aggRecordedDebt();
    assertGt(aggREcordedDebt_1, 0);
    vm.warp(block.timestamp + 1 days);
    uint256 pendingInterest = activePool.calcPendingAggInterest();
    assertApproxEqAbs(pendingInterest, calcInterest(weightedRecordedDebt_A, 1 days), 1);
    debt_A += pendingInterest;
    uint256 BTroveId = openTroveNoHints100pct(B, 2 ether, troveDebtRequest, 25e16);
    uint256 debt_B = troveDebtRequest;
    debt_B += calcUpfrontFee(debt_B, (weightedRecordedDebt_A + (debt_B * 25e16)) / (debt_A + debt_B));
    assertEq(troveManager.getTroveDebt(BTroveId), debt_B);
    assertEq(activePool.aggRecordedDebt(), (aggREcordedDebt_1 + pendingInterest) + debt_B);
}
```

## Related Implementations

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
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

### assertApproxEqAbs(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 16664:156:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqAbs(uint256,uint256,uint256)`

```solidity
function assertApproxEqAbs(uint256 left, uint256 right, uint256 maxDelta) virtual internal pure {
    vm.assertApproxEqAbs(left, right, maxDelta);
}
```

## External Calls

- **IPriceFeedTestnet::setPrice(uint256)**
- **IActivePool::aggRecordedDebt()**
- **Vm::warp(uint256)**
- **IActivePool::calcPendingAggInterest()**
- **ITroveManagerTester::getTroveDebt(uint256)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestRateAggregate.testOpenTroveIncreasesRecordedAggDebtByAggPendingInterestPlusTroveDebt() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [activePool.aggRecordedDebt(), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 2)
  │   💬 Args: [A, 2 ether, troveDebtRequest, 25e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 3)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 4)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 5)
  │   💬 Args: [debt_A, 25e16]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 6)
  │     💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 7)
  │   💬 Args: [aggREcordedDebt_1, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256) (NodeID: 8)
  │   💬 Args: [pendingInterest, calcInterest(weightedRecordedDebt_A, 1 days), 1]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 9)
  │     💬 Args: [weightedRecordedDebt_A, 1 days]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 10)
  │   💬 Args: [B, 2 ether, troveDebtRequest, 25e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 11)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 12)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 13)
  │   💬 Args: [debt_B, (weightedRecordedDebt_A + (debt_B * 25e16)) / (debt_A + debt_B)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 14)
  │     💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 15)
  │   💬 Args: [troveManager.getTroveDebt(BTroveId), debt_B]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 16)
      💬 Args: [activePool.aggRecordedDebt(), (aggREcordedDebt_1 + pendingInterest) + debt_B]
      👁️  Def: internal
```
