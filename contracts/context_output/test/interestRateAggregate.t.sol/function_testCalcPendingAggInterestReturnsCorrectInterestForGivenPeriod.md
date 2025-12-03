# Function: testCalcPendingAggInterestReturnsCorrectInterestForGivenPeriod()

**Contract**: [test/interestRateAggregate.t.sol/contract_InterestRateAggregate.md]

## Metadata

- **Contract**: InterestRateAggregate
- **Signature**: `testCalcPendingAggInterestReturnsCorrectInterestForGivenPeriod()`
- **Visibility**: public
- **Source Range**: 1511:1013:306

## Implementation

```solidity
function testCalcPendingAggInterestReturnsCorrectInterestForGivenPeriod() public {
    priceFeed.setPrice(2000e18);
    uint256 _duration = 1 days;
    uint256 troveDebtRequest = 2000e18;
    uint256 interestRate_A = 0.25 ether;
    uint256 interestRate_B = 0.75 ether;
    uint256 ATroveId = openTroveNoHints100pct(A, 2 ether, troveDebtRequest, interestRate_A);
    uint256 BTroveId = openTroveNoHints100pct(B, 2 ether, troveDebtRequest, interestRate_B);
    uint256 debt_A = troveManager.getTroveEntireDebt(ATroveId);
    uint256 debt_B = troveManager.getTroveEntireDebt(BTroveId);
    vm.warp(block.timestamp + _duration);
    uint256 expectedPendingAggInterest = Math.ceilDiv(((debt_A * interestRate_A) + (debt_B * interestRate_B)) * _duration, ONE_YEAR * DECIMAL_PRECISION);
    assertEq(expectedPendingAggInterest, activePool.calcPendingAggInterest());
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

### ceilDiv(uint256,uint256)

- **Kind**: internal
- **Source**: 1157:194:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:ceilDiv(uint256,uint256)`

```solidity
///  @dev Returns the ceiling of the division of two numbers.
///  This differs from standard division with `/` in that it rounds up instead
///  of rounding down.
function ceilDiv(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a == 0) ? 0 : (((a - 1) / b) + 1);
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
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **Vm::warp(uint256)**
- **IActivePool::calcPendingAggInterest()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestRateAggregate.testCalcPendingAggInterestReturnsCorrectInterestForGivenPeriod() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [A, 2 ether, troveDebtRequest, interestRate_A]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 4)
  │   💬 Args: [B, 2 ether, troveDebtRequest, interestRate_B]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 5)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 6)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.ceilDiv(uint256,uint256) (NodeID: 7)
  │   💬 Args: [((debt_A * interestRate_A) + (debt_B * interestRate_B)) * _duration, ONE_YEAR * DECIMAL_PRECISION]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 8)
      💬 Args: [expectedPendingAggInterest, activePool.calcPendingAggInterest()]
      👁️  Def: internal
```
