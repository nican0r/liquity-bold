# Function: testNoDoubleInterestOnPendingRedistribution()

**Contract**: [test/interestRateAggregate.t.sol/contract_InterestRateAggregate.md]

## Metadata

- **Contract**: InterestRateAggregate
- **Signature**: `testNoDoubleInterestOnPendingRedistribution()`
- **Visibility**: public
- **Source Range**: 81809:1564:306

## Implementation

```solidity
function testNoDoubleInterestOnPendingRedistribution() public {
    ABCDEF memory troveIDs;
    uint256 coll = 100 ether;
    uint256 borrow = 10_000 ether - 200 ether;
    uint256 interestRate = 1 ether;
    troveIDs.A = openTroveNoHints100pct(A, coll, borrow, interestRate);
    troveIDs.B = openTroveNoHints100pct(B, coll, borrow, interestRate);
    troveIDs.C = openTroveNoHints100pct(C, coll, borrow, interestRate);
    troveIDs.D = openTroveNoHints100pct(D, coll, borrow, interestRate);
    emit log_named_decimal_uint("Trove D debt (initial)  ", troveManager.getTroveEntireDebt(troveIDs.D), 18);
    vm.warp(block.timestamp + 365 days);
    emit log_named_decimal_uint("Trove D debt (post-1y)  ", troveManager.getTroveEntireDebt(troveIDs.D), 18);
    priceFeed.setPrice(110 ether);
    uint256[] memory liquidatedTroves = new uint256[](3);
    liquidatedTroves[0] = troveIDs.A;
    liquidatedTroves[1] = troveIDs.B;
    liquidatedTroves[2] = troveIDs.C;
    troveManager.batchLiquidateTroves(liquidatedTroves);
    uint256 debtBefore = troveManager.getTroveEntireDebt(troveIDs.D);
    emit log_named_decimal_uint("Trove D debt (post-liq) ", debtBefore, 18);
    changeInterestRateNoHints(D, troveIDs.D, 0.1 ether);
    uint256 debtAfter = troveManager.getTroveEntireDebt(troveIDs.D);
    emit log_named_decimal_uint("Trove D debt (post-adj) ", debtAfter, 18);
    assertEq(debtBefore, debtAfter, "Adjusting interest rate shouldn't change Trove's debt");
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

### changeInterestRateNoHints(address,uint256,uint256)

- **Kind**: internal
- **Source**: 10473:420:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:changeInterestRateNoHints(address,uint256,uint256)`

```solidity
function changeInterestRateNoHints(address _account, uint256 _troveId, uint256 _newAnnualInterestRate) public returns (uint256 upfrontFee) {
    upfrontFee = predictAdjustInterestRateUpfrontFee(_troveId, _newAnnualInterestRate);
    vm.startPrank(_account);
    borrowerOperations.adjustTroveInterestRate(_troveId, _newAnnualInterestRate, 0, 0, upfrontFee);
    vm.stopPrank();
}
```

### predictAdjustInterestRateUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 3761:247:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:predictAdjustInterestRateUpfrontFee(uint256,uint256)`

```solidity
function predictAdjustInterestRateUpfrontFee(uint256 troveId, uint256 newInterestRate) internal view returns (uint256) {
    return hintHelpers.predictAdjustInterestRateUpfrontFee(0, troveId, newInterestRate);
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

## External Calls

- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **Vm::warp(uint256)**
- **IPriceFeedTestnet::setPrice(uint256)**
- **ITroveManagerTester::batchLiquidateTroves(uint256[])**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestRateAggregate.testNoDoubleInterestOnPendingRedistribution() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [A, coll, borrow, interestRate]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 4)
  │   💬 Args: [B, coll, borrow, interestRate]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 5)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 6)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 7)
  │   💬 Args: [C, coll, borrow, interestRate]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 8)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 9)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 10)
  │   💬 Args: [D, coll, borrow, interestRate]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 11)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 12)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.changeInterestRateNoHints(address,uint256,uint256) (NodeID: 13)
  │   💬 Args: [D, troveIDs.D, 0.1 ether]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictAdjustInterestRateUpfrontFee(uint256,uint256) (NodeID: 14)
  │     💬 Args: [_troveId, _newAnnualInterestRate]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 15)
      💬 Args: [debtBefore, debtAfter, "Adjusting interest rate shouldn't change Trove's debt"]
      👁️  Def: internal
```
