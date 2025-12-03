# Function: test_AdjustTroveEmitsTroveOperation()

**Contract**: [test/events.t.sol/contract_TroveEventsTest.md]

## Metadata

- **Contract**: TroveEventsTest
- **Signature**: `test_AdjustTroveEmitsTroveOperation()`
- **Visibility**: external
- **Source Range**: 5087:773:303

## Implementation

```solidity
function test_AdjustTroveEmitsTroveOperation() external {
    uint256 interestRate = 0.01 ether;
    (uint256 troveId, ) = openTroveHelper(A, 0, 100 ether, 10_000 ether, interestRate);
    uint256 deposit = 10 ether;
    uint256 borrow = 1_000 ether;
    uint256 upfrontFee = predictAdjustTroveUpfrontFee(troveId, borrow);
    vm.expectEmit();
    emit TroveOperation(troveId, Operation.adjustTrove, interestRate, 0, upfrontFee, int256(borrow), 0, int256(deposit));
    vm.prank(A);
    borrowerOperations.adjustTrove(troveId, deposit, true, borrow, true, upfrontFee);
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

### predictAdjustTroveUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 4277:199:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:predictAdjustTroveUpfrontFee(uint256,uint256)`

```solidity
function predictAdjustTroveUpfrontFee(uint256 troveId, uint256 debtIncrease) internal view returns (uint256) {
    return hintHelpers.predictAdjustTroveUpfrontFee(0, troveId, debtIncrease);
}
```

## External Calls

- **Vm::expectEmit()**
- **Vm::prank(address)**
- **IBorrowerOperationsTester::adjustTrove(uint256,uint256,bool,uint256,bool,uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveEventsTest.test_AdjustTroveEmitsTroveOperation() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [A, 0, 100 ether, 10_000 ether, interestRate]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 2)
  │     💬 Args: [_boldAmount, _annualInterestRate]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseTest.predictAdjustTroveUpfrontFee(uint256,uint256) (NodeID: 3)
      💬 Args: [troveId, borrow]
      👁️  Def: internal
```
