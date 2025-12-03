# Function: testAfterBatchManagementFeeAccrualEntireSystemDebtMatchesWithOpenTrove()

**Contract**: [test/batchManagementFee.t.sol/contract_BatchManagementFeeTest.md]

## Metadata

- **Contract**: BatchManagementFeeTest
- **Signature**: `testAfterBatchManagementFeeAccrualEntireSystemDebtMatchesWithOpenTrove()`
- **Visibility**: public
- **Source Range**: 22276:989:298

## Implementation

```solidity
function testAfterBatchManagementFeeAccrualEntireSystemDebtMatchesWithOpenTrove() public {
    uint256 ATroveId = openTroveAndJoinBatchManager(A, 100e18, 5000e18, B, 5e16);
    vm.warp(block.timestamp + 10 days);
    uint256 entireSystemDebt = troveManager.getEntireBranchDebt();
    uint256 entireDebtA = troveManager.getTroveEntireDebt(ATroveId);
    assertApproxEqAbs(entireSystemDebt, entireDebtA, 2, "Entire debt should be that of trove A");
    uint256 CTroveId = openTroveAndJoinBatchManager(C, 100e18, 4000e18, B, 5e16);
    vm.warp(block.timestamp + 5 days);
    entireSystemDebt = troveManager.getEntireBranchDebt();
    entireDebtA = troveManager.getTroveEntireDebt(ATroveId);
    uint256 entireDebtC = troveManager.getTroveEntireDebt(CTroveId);
    assertApproxEqAbs(entireSystemDebt, entireDebtA + entireDebtC, 10, "Entire debt should be A+C");
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

### assertApproxEqAbs(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 16826:208:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqAbs(uint256,uint256,uint256,string)`

```solidity
function assertApproxEqAbs(uint256 left, uint256 right, uint256 maxDelta, string memory err) virtual internal pure {
    vm.assertApproxEqAbs(left, right, maxDelta, err);
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
┌─ [0] ⚙️ FUNCTION: BatchManagementFeeTest.testAfterBatchManagementFeeAccrualEntireSystemDebtMatchesWithOpenTrove() (NodeID: 0)
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
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 6)
  │   💬 Args: [entireSystemDebt, entireDebtA, 2, "Entire debt should be that of trove A"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManager(address,uint256,uint256,address,uint256) (NodeID: 7)
  │   💬 Args: [C, 100e18, 4000e18, B, 5e16]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManagerWithIndex(address,uint256,uint256,uint256,address,uint256) (NodeID: 8)
  │     💬 Args: [_troveOwner, 0, _coll, _debt, _batchAddress, _annualInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 9)
  │       💬 Args: [_batchAddress, uint128(LiquityMath._min(1e16, _annualInterestRate)), uint128(LiquityMath._max(20e16, _annualInterestRate)), uint128(_annualInterestRate), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 10)
  │     │   💬 Args: [1e16, _annualInterestRate]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 11)
  │         💬 Args: [20e16, _annualInterestRate]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 12)
      💬 Args: [entireSystemDebt, entireDebtA + entireDebtC, 10, "Entire debt should be A+C"]
      👁️  Def: internal
```
