# Function: testDelegateCannotSetInterestBelowMin()

**Contract**: [test/interestIndividualDelegation.t.sol/contract_InterestIndividualDelegationTest.md]

## Metadata

- **Contract**: InterestIndividualDelegationTest
- **Signature**: `testDelegateCannotSetInterestBelowMin()`
- **Visibility**: public
- **Source Range**: 3621:349:305

## Implementation

```solidity
function testDelegateCannotSetInterestBelowMin() public {
    uint256 troveId = openTroveAndSetIndividualDelegate();
    vm.startPrank(B);
    vm.expectRevert(BorrowerOperations.InterestNotInRange.selector);
    borrowerOperations.adjustTroveInterestRate(troveId, MIN_ANNUAL_INTEREST_RATE, 0, 0, 1e24);
    vm.stopPrank();
}
```

## Related Implementations

### openTroveAndSetIndividualDelegate()

- **Kind**: internal
- **Source**: 216:329:305
- **Link**: `test/interestIndividualDelegation.t.sol:InterestIndividualDelegationTest:openTroveAndSetIndividualDelegate()`

```solidity
function openTroveAndSetIndividualDelegate() internal returns (uint256) {
    uint256 troveId = openTroveNoHints100pct(A, 100e18, 5000e18, 5e16);
    vm.startPrank(A);
    borrowerOperations.setInterestIndividualDelegate(troveId, B, 1e16, 20e16, 0, 0, 0, 0, 0);
    vm.stopPrank();
    return troveId;
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

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **IBorrowerOperationsTester::adjustTroveInterestRate(uint256,uint256,uint256,uint256,uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestIndividualDelegationTest.testDelegateCannotSetInterestBelowMin() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: InterestIndividualDelegationTest.openTroveAndSetIndividualDelegate() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 2)
        💬 Args: [A, 100e18, 5000e18, 5e16]
        👁️  Def: public
      └─ [3] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 3)
          💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
          👁️  Def: public
        └─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 4)
            💬 Args: [_boldAmount, _annualInterestRate]
            👁️  Def: internal
```
