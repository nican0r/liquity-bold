# Function: testGetTCRIncorporatesAllTroveInterestForSystemWithMultipleTroves()

**Contract**: [test/interestRateAggregate.t.sol/contract_InterestRateAggregate.md]

## Metadata

- **Contract**: InterestRateAggregate
- **Signature**: `testGetTCRIncorporatesAllTroveInterestForSystemWithMultipleTroves()`
- **Visibility**: public
- **Source Range**: 73382:1921:306

## Implementation

```solidity
function testGetTCRIncorporatesAllTroveInterestForSystemWithMultipleTroves() public {
    uint256 interval = 14 days;
    ABCDEF memory borrow;
    borrow.A = 2_000 ether;
    borrow.B = 4_000 ether;
    borrow.C = 5_000 ether;
    ABCDEF memory coll;
    coll.A = 20 ether;
    coll.B = 30 ether;
    coll.C = 40 ether;
    ABCDEF memory r;
    r.A = 0.25 ether;
    r.B = 0.35 ether;
    r.C = 0.45 ether;
    openTroveNoHints100pct(A, coll.A, borrow.A, r.A);
    vm.warp(block.timestamp + interval);
    openTroveNoHints100pct(B, coll.B, borrow.B, r.B);
    vm.warp(block.timestamp + interval);
    openTroveNoHints100pct(C, coll.C, borrow.C, r.C);
    vm.warp(block.timestamp + interval);
    ABCDEF memory debt;
    debt.A = borrow.A;
    debt.B = borrow.B;
    debt.C = borrow.C;
    ABCDEF memory rd;
    debt.A += calcUpfrontFee(debt.A, r.A);
    rd.A = r.A * debt.A;
    debt.A += calcInterest(rd.A, interval);
    debt.B += calcUpfrontFee(debt.B, (rd.A + (r.B * debt.B)) / (debt.A + debt.B));
    rd.B = r.B * debt.B;
    debt.A += calcInterest(rd.A, interval);
    debt.B += calcInterest(rd.B, interval);
    debt.C += calcUpfrontFee(debt.C, ((rd.A + rd.B) + (r.C * debt.C)) / ((debt.A + debt.B) + debt.C));
    rd.C = r.C * debt.C;
    debt.A += calcInterest(rd.A, interval);
    debt.B += calcInterest(rd.B, interval);
    debt.C += calcInterest(rd.C, interval);
    (uint256 price, ) = priceFeed.fetchPrice();
    uint256 expectedTCR = (((coll.A + coll.B) + coll.C) * price) / ((debt.A + debt.B) + debt.C);
    assertEq(expectedTCR, troveManager.getTCR(price));
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
- **IPriceFeedTestnet::fetchPrice()**
- **ITroveManagerTester::getTCR(uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestRateAggregate.testGetTCRIncorporatesAllTroveInterestForSystemWithMultipleTroves() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [A, coll.A, borrow.A, r.A]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 4)
  │   💬 Args: [B, coll.B, borrow.B, r.B]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 5)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 6)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 7)
  │   💬 Args: [C, coll.C, borrow.C, r.C]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 8)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 9)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 10)
  │   💬 Args: [debt.A, r.A]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 11)
  │     💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 12)
  │   💬 Args: [rd.A, interval]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 13)
  │   💬 Args: [debt.B, (rd.A + (r.B * debt.B)) / (debt.A + debt.B)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 14)
  │     💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 15)
  │   💬 Args: [rd.A, interval]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 16)
  │   💬 Args: [rd.B, interval]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 17)
  │   💬 Args: [debt.C, ((rd.A + rd.B) + (r.C * debt.C)) / ((debt.A + debt.B) + debt.C)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 18)
  │     💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 19)
  │   💬 Args: [rd.A, interval]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 20)
  │   💬 Args: [rd.B, interval]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 21)
  │   💬 Args: [rd.C, interval]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 22)
      💬 Args: [expectedTCR, troveManager.getTCR(price)]
      👁️  Def: internal
```
