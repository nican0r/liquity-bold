# Function: testAddCollWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterest()

**Contract**: [test/interestRateAggregate.t.sol/contract_InterestRateAggregate.md]

## Metadata

- **Contract**: InterestRateAggregate
- **Signature**: `testAddCollWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterest()`
- **Visibility**: public
- **Source Range**: 39985:786:306

## Implementation

```solidity
function testAddCollWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterest() public {
    uint256 troveDebtRequest = 3000e18;
    uint256 collIncrease = 1 ether;
    priceFeed.setPrice(2000e18);
    uint256 ATroveId = openTroveNoHints100pct(A, 3 ether, troveDebtRequest, 25e16);
    vm.warp(block.timestamp + 1 days);
    uint256 aggRecordedDebt_1 = activePool.aggRecordedDebt();
    assertGt(aggRecordedDebt_1, 0);
    uint256 pendingAggInterest = activePool.calcPendingAggInterest();
    assertGt(pendingAggInterest, 0);
    addColl(A, ATroveId, collIncrease);
    assertEq(activePool.aggRecordedDebt(), aggRecordedDebt_1 + pendingAggInterest);
}
```

## Related Implementations

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

### assertGt(uint256,uint256)

- **Kind**: internal
- **Source**: 13112:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256)`

```solidity
function assertGt(uint256 left, uint256 right) virtual internal pure {
    vm.assertGt(left, right);
}
```

### addColl(address,uint256,uint256)

- **Kind**: internal
- **Source**: 12789:208:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:addColl(address,uint256,uint256)`

```solidity
function addColl(address _account, uint256 _troveId, uint256 _collIncrease) public {
    vm.startPrank(_account);
    borrowerOperations.addColl(_troveId, _collIncrease);
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

- **IPriceFeedTestnet::setPrice(uint256)**
- **Vm::warp(uint256)**
- **IActivePool::aggRecordedDebt()**
- **IActivePool::calcPendingAggInterest()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestRateAggregate.testAddCollWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterest() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [A, 3 ether, troveDebtRequest, 25e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 4)
  │   💬 Args: [aggRecordedDebt_1, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 5)
  │   💬 Args: [pendingAggInterest, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.addColl(address,uint256,uint256) (NodeID: 6)
  │   💬 Args: [A, ATroveId, collIncrease]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 7)
      💬 Args: [activePool.aggRecordedDebt(), aggRecordedDebt_1 + pendingAggInterest]
      👁️  Def: internal
```
