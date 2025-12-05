# Function: test_AdjustTroveInterestRateEmitsTroveUpdated()

**Contract**: [test/events.t.sol/contract_TroveEventsTest.md]

## Metadata

- **Contract**: TroveEventsTest
- **Signature**: `test_AdjustTroveInterestRateEmitsTroveUpdated()`
- **Visibility**: external
- **Source Range**: 5866:801:303

## Implementation

```solidity
function test_AdjustTroveInterestRateEmitsTroveUpdated() external {
    (uint256 troveId, ) = openTroveHelper(A, 0, 100 ether, 10_000 ether, 0.01 ether);
    vm.warp(block.timestamp + INTEREST_RATE_ADJ_COOLDOWN);
    uint256 coll = troveManager.getTroveEntireColl(troveId);
    uint256 debt = troveManager.getTroveEntireDebt(troveId);
    uint256 stake = coll;
    uint256 newInterestRate = 0.02 ether;
    vm.expectEmit();
    emit TroveUpdated(troveId, debt, coll, stake, newInterestRate, 0, 0);
    vm.prank(A);
    borrowerOperations.adjustTroveInterestRate(troveId, newInterestRate, 0, 0, 0);
}
```

## Related Implementations

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

## External Calls

- **Vm::warp(uint256)**
- **ITroveManagerTester::getTroveEntireColl(uint256)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **Vm::expectEmit()**
- **Vm::prank(address)**
- **IBorrowerOperationsTester::adjustTroveInterestRate(uint256,uint256,uint256,uint256,uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveEventsTest.test_AdjustTroveInterestRateEmitsTroveUpdated() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 1)
      💬 Args: [A, 0, 100 ether, 10_000 ether, 0.01 ether]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 2)
        💬 Args: [_boldAmount, _annualInterestRate]
        👁️  Def: internal
```
