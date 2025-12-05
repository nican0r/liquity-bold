# Function: testSetDelegateRevertsIfNewInterestRateNotInRangeAbove()

**Contract**: [test/interestIndividualDelegation.t.sol/contract_InterestIndividualDelegationTest.md]

## Metadata

- **Contract**: InterestIndividualDelegationTest
- **Signature**: `testSetDelegateRevertsIfNewInterestRateNotInRangeAbove()`
- **Visibility**: public
- **Source Range**: 9678:914:305

## Implementation

```solidity
function testSetDelegateRevertsIfNewInterestRateNotInRangeAbove() public {
    vm.startPrank(B);
    borrowerOperations.registerBatchManager(1e16, 20e16, 5e16, 25e14, MIN_INTEREST_RATE_CHANGE_PERIOD);
    vm.stopPrank();
    uint256 troveId = openTroveNoHints100pct(A, 100e18, 5000e18, 5e16);
    vm.startPrank(A);
    borrowerOperations.setInterestBatchManager(troveId, B, 0, 0, 1e24);
    vm.stopPrank();
    uint256 newAnnualInterestRate = MAX_ANNUAL_INTEREST_RATE + 1;
    vm.startPrank(A);
    vm.expectRevert(BorrowerOperations.InterestRateTooHigh.selector);
    borrowerOperations.setInterestIndividualDelegate(troveId, C, 1e16, 20e16, newAnnualInterestRate, 0, 0, 10000e18, 0);
    vm.stopPrank();
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

## External Calls

- **Vm::startPrank(address)**
- **IBorrowerOperationsTester::registerBatchManager(uint128,uint128,uint128,uint128,uint128)**
- **Vm::stopPrank()**
- **IBorrowerOperationsTester::setInterestBatchManager(uint256,address,uint256,uint256,uint256)**
- **Vm::expectRevert(bytes4)**
- **IBorrowerOperationsTester::setInterestIndividualDelegate(uint256,address,uint128,uint128,uint256,uint256,uint256,uint256,uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestIndividualDelegationTest.testSetDelegateRevertsIfNewInterestRateNotInRangeAbove() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 1)
      💬 Args: [A, 100e18, 5000e18, 5e16]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 2)
        💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
        👁️  Def: public
      └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
          💬 Args: [_boldAmount, _annualInterestRate]
          👁️  Def: internal
```
