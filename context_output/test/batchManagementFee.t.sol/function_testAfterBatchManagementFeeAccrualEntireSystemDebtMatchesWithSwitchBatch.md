# Function: testAfterBatchManagementFeeAccrualEntireSystemDebtMatchesWithSwitchBatch()

**Contract**: [test/batchManagementFee.t.sol/contract_BatchManagementFeeTest.md]

## Metadata

- **Contract**: BatchManagementFeeTest
- **Signature**: `testAfterBatchManagementFeeAccrualEntireSystemDebtMatchesWithSwitchBatch()`
- **Visibility**: public
- **Source Range**: 23271:952:298

## Implementation

```solidity
function testAfterBatchManagementFeeAccrualEntireSystemDebtMatchesWithSwitchBatch() public {
    uint256 ATroveId = openTroveAndJoinBatchManager(A, 100e18, 5000e18, B, 5e16);
    uint256 CTroveId = openTroveAndJoinBatchManager(C, 100e18, 4000e18, B, 5e16);
    vm.warp(block.timestamp + 10 days);
    registerBatchManager(D, uint128(MIN_ANNUAL_INTEREST_RATE), 1e18, 4e16, 50e14, MIN_INTEREST_RATE_CHANGE_PERIOD);
    switchBatchManager(C, CTroveId, D);
    vm.warp(block.timestamp + 5 days);
    uint256 entireSystemDebt = troveManager.getEntireBranchDebt();
    uint256 entireDebtA = troveManager.getTroveEntireDebt(ATroveId);
    uint256 entireDebtC = troveManager.getTroveEntireDebt(CTroveId);
    assertApproxEqAbs(entireSystemDebt, entireDebtA + entireDebtC, 10);
}
```

## Related Implementations

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

### switchBatchManager(address,uint256,address)

- **Kind**: internal
- **Source**: 18494:209:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:switchBatchManager(address,uint256,address)`

```solidity
function switchBatchManager(address _troveOwner, uint256 _troveId, address _newBatchManager) internal {
    switchBatchManager(_troveOwner, _troveId, 0, 0, _newBatchManager, 0, 0, type(uint256).max);
}
```

### switchBatchManager(address,uint256,uint256,uint256,address,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 18709:540:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:switchBatchManager(address,uint256,uint256,uint256,address,uint256,uint256,uint256)`

```solidity
function switchBatchManager(address _troveOwner, uint256 _troveId, uint256 _removeUpperHint, uint256 _removeLowerHint, address _newBatchManager, uint256 _addUpperHint, uint256 _addLowerHint, uint256 _maxUpfrontFee) internal {
    vm.startPrank(_troveOwner);
    borrowerOperations.switchBatchManager(_troveId, _removeUpperHint, _removeLowerHint, _newBatchManager, _addUpperHint, _addLowerHint, _maxUpfrontFee);
    vm.stopPrank();
}
```

### assertApproxEqAbs(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 16664:156:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqAbs(uint256,uint256,uint256)`

```solidity
function assertApproxEqAbs(uint256 left, uint256 right, uint256 maxDelta) virtual internal pure {
    vm.assertApproxEqAbs(left, right, maxDelta);
}
```

## External Calls

- **Vm::warp(uint256)**
- **ITroveManagerTester::getEntireBranchDebt()**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BatchManagementFeeTest.testAfterBatchManagementFeeAccrualEntireSystemDebtMatchesWithSwitchBatch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManager(address,uint256,uint256,address,uint256) (NodeID: 1)
  │   💬 Args: [A, 100e18, 5000e18, B, 5e16]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManagerWithIndex(address,uint256,uint256,uint256,address,uint256) (NodeID: 2)
  │     💬 Args: [_troveOwner, 0, _coll, _debt, _batchAddress, _annualInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 3)
  │       💬 Args: [_batchAddress, uint128(LiquityMath._min(1e16, _annualInterestRate)), uint128(LiquityMath._max(20e16, _annualInterestRate)), uint128(_annualInterestRate), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 4)
  │     │   💬 Args: [1e16, _annualInterestRate]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 5)
  │         💬 Args: [20e16, _annualInterestRate]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManager(address,uint256,uint256,address,uint256) (NodeID: 6)
  │   💬 Args: [C, 100e18, 4000e18, B, 5e16]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManagerWithIndex(address,uint256,uint256,uint256,address,uint256) (NodeID: 7)
  │     💬 Args: [_troveOwner, 0, _coll, _debt, _batchAddress, _annualInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 8)
  │       💬 Args: [_batchAddress, uint128(LiquityMath._min(1e16, _annualInterestRate)), uint128(LiquityMath._max(20e16, _annualInterestRate)), uint128(_annualInterestRate), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 9)
  │     │   💬 Args: [1e16, _annualInterestRate]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 10)
  │         💬 Args: [20e16, _annualInterestRate]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 11)
  │   💬 Args: [D, uint128(MIN_ANNUAL_INTEREST_RATE), 1e18, 4e16, 50e14, MIN_INTEREST_RATE_CHANGE_PERIOD]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.switchBatchManager(address,uint256,address) (NodeID: 12)
  │   💬 Args: [C, CTroveId, D]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.switchBatchManager(address,uint256,uint256,uint256,address,uint256,uint256,uint256) (NodeID: 13)
  │     💬 Args: [_troveOwner, _troveId, 0, 0, _newBatchManager, 0, 0, type(uint256).max]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256) (NodeID: 14)
      💬 Args: [entireSystemDebt, entireDebtA + entireDebtC, 10]
      👁️  Def: internal
```
