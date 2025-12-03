# Function: testCannotAdjustInsideABatchIfBelowMCRPlusBCR1()

**Contract**: [test/interestBatchManagement.t.sol/contract_InterestBatchManagementTest.md]

## Metadata

- **Contract**: InterestBatchManagementTest
- **Signature**: `testCannotAdjustInsideABatchIfBelowMCRPlusBCR1()`
- **Visibility**: public
- **Source Range**: 63765:920:304

## Implementation

```solidity
function testCannotAdjustInsideABatchIfBelowMCRPlusBCR1() public {
    uint256 price = 2000e18;
    priceFeed.setPrice(price);
    openTroveNoHints100pct(C, 100e18, 5000e18, MIN_ANNUAL_INTEREST_RATE);
    uint256 troveId = openTroveAndJoinBatchManager();
    uint256 debt = troveManager.getTroveEntireDebt(troveId);
    uint256 coll = troveManager.getTroveEntireColl(troveId);
    uint256 withdrawColl = 97.5 ether;
    uint256 repayBold = (debt - (((coll - withdrawColl) * price) / (MCR + BCR))) - 1;
    vm.startPrank(A);
    vm.expectRevert(BorrowerOperations.ICRBelowMCRPlusBCR.selector);
    borrowerOperations.adjustTrove(troveId, withdrawColl, false, repayBold, false, 10000e18);
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

### openTroveAndJoinBatchManager()

- **Kind**: internal
- **Source**: 15105:148:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:openTroveAndJoinBatchManager()`

```solidity
function openTroveAndJoinBatchManager() internal returns (uint256) {
    return openTroveAndJoinBatchManager(A, 100e18, 5000e18, B, 5e16);
}
```

### openTroveAndJoinBatchManager(address,uint256,uint256,address,uint256)

- **Kind**: internal
- **Source**: 15259:341:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:openTroveAndJoinBatchManager(address,uint256,uint256,address,uint256)`

```solidity
function openTroveAndJoinBatchManager(address _troveOwner, uint256 _coll, uint256 _debt, address _batchAddress, uint256 _annualInterestRate) internal returns (uint256) {
    return openTroveAndJoinBatchManagerWithIndex(_troveOwner, 0, _coll, _debt, _batchAddress, _annualInterestRate);
}
```

### openTroveAndJoinBatchManagerWithIndex(address,uint256,uint256,uint256,address,uint256)

- **Kind**: internal
- **Source**: 15606:1407:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:openTroveAndJoinBatchManagerWithIndex(address,uint256,uint256,uint256,address,uint256)`

```solidity
function openTroveAndJoinBatchManagerWithIndex(address _troveOwner, uint256 _index, uint256 _coll, uint256 _debt, address _batchAddress, uint256 _annualInterestRate) internal returns (uint256) {
    if (!borrowerOperations.checkBatchManagerExists(_batchAddress)) {
        registerBatchManager(_batchAddress, uint128(LiquityMath._min(1e16, _annualInterestRate)), uint128(LiquityMath._max(20e16, _annualInterestRate)), uint128(_annualInterestRate), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD);
    }
    IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory params = IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams({owner: _troveOwner, ownerIndex: _index, collAmount: _coll, boldAmount: _debt, upperHint: 0, lowerHint: 0, interestBatchManager: _batchAddress, maxUpfrontFee: 1e24, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(_troveOwner);
    uint256 troveId = borrowerOperations.openTroveAndJoinInterestBatchManager(params);
    vm.stopPrank();
    return troveId;
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

### _min(uint256,uint256)

- **Kind**: internal
- **Source**: 136:113:137
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_min(uint256,uint256)`

```solidity
function _min(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a < _b) ? _a : _b;
}
```

### _max(uint256,uint256)

- **Kind**: internal
- **Source**: 255:114:137
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_max(uint256,uint256)`

```solidity
function _max(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a >= _b) ? _a : _b;
}
```

## External Calls

- **IPriceFeedTestnet::setPrice(uint256)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **ITroveManagerTester::getTroveEntireColl(uint256)**
- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **IBorrowerOperationsTester::adjustTrove(uint256,uint256,bool,uint256,bool,uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestBatchManagementTest.testCannotAdjustInsideABatchIfBelowMCRPlusBCR1() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [C, 100e18, 5000e18, MIN_ANNUAL_INTEREST_RATE]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManager() (NodeID: 4)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManager(address,uint256,uint256,address,uint256) (NodeID: 5)
        💬 Args: [A, 100e18, 5000e18, B, 5e16]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManagerWithIndex(address,uint256,uint256,uint256,address,uint256) (NodeID: 6)
          💬 Args: [_troveOwner, 0, _coll, _debt, _batchAddress, _annualInterestRate]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 7)
            💬 Args: [_batchAddress, uint128(LiquityMath._min(1e16, _annualInterestRate)), uint128(LiquityMath._max(20e16, _annualInterestRate)), uint128(_annualInterestRate), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
            👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 8)
          │   💬 Args: [1e16, _annualInterestRate]
          │   👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 9)
              💬 Args: [20e16, _annualInterestRate]
              👁️  Def: internal
```
