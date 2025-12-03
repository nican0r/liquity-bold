# Function: testOnlyBorrowerCanSetBatchManager()

**Contract**: [test/interestBatchManagement.t.sol/contract_InterestBatchManagementTest.md]

## Metadata

- **Contract**: InterestBatchManagementTest
- **Signature**: `testOnlyBorrowerCanSetBatchManager()`
- **Visibility**: public
- **Source Range**: 9753:710:304

## Implementation

```solidity
function testOnlyBorrowerCanSetBatchManager() public {
    registerBatchManager(A);
    registerBatchManager(B);
    registerBatchManager(C);
    uint256 troveId = openTroveNoHints100pct(A, 100e18, 5000e18, 5e16);
    vm.startPrank(B);
    vm.expectRevert(AddRemoveManagers.NotBorrower.selector);
    borrowerOperations.setInterestBatchManager(troveId, B, 0, 0, 1e24);
    vm.expectRevert(AddRemoveManagers.NotBorrower.selector);
    borrowerOperations.setInterestBatchManager(troveId, A, 0, 0, 1e24);
    vm.expectRevert(AddRemoveManagers.NotBorrower.selector);
    borrowerOperations.setInterestBatchManager(troveId, C, 0, 0, 1e24);
    vm.stopPrank();
}
```

## Related Implementations

### registerBatchManager(address)

- **Kind**: internal
- **Source**: 14398:221:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:registerBatchManager(address)`

```solidity
function registerBatchManager(address _account) internal {
    registerBatchManager(_account, uint128(1e16), uint128(20e16), uint128(5e16), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD);
}
```

### registerBatchManager(address,uint128,uint128,uint128,uint128,uint128)

- **Kind**: internal
- **Source**: 14625:474:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:registerBatchManager(address,uint128,uint128,uint128,uint128,uint128)`

```solidity
function registerBatchManager(address _account, uint128 _minInterestRate, uint128 _maxInterestRate, uint128 _currentInterestRate, uint128 _fee, uint128 _minInterestRateChangePeriod) internal {
    vm.startPrank(_account);
    borrowerOperations.registerBatchManager(_minInterestRate, _maxInterestRate, _currentInterestRate, _fee, _minInterestRateChangePeriod);
    vm.stopPrank();
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
- **IBorrowerOperationsTester::setInterestBatchManager(uint256,address,uint256,uint256,uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestBatchManagementTest.testOnlyBorrowerCanSetBatchManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.registerBatchManager(address) (NodeID: 1)
  │   💬 Args: [A]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 2)
  │     💬 Args: [_account, uint128(1e16), uint128(20e16), uint128(5e16), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.registerBatchManager(address) (NodeID: 3)
  │   💬 Args: [B]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 4)
  │     💬 Args: [_account, uint128(1e16), uint128(20e16), uint128(5e16), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.registerBatchManager(address) (NodeID: 5)
  │   💬 Args: [C]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 6)
  │     💬 Args: [_account, uint128(1e16), uint128(20e16), uint128(5e16), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 7)
      💬 Args: [A, 100e18, 5000e18, 5e16]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 8)
        💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
        👁️  Def: public
      └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 9)
          💬 Args: [_boldAmount, _annualInterestRate]
          👁️  Def: internal
```
