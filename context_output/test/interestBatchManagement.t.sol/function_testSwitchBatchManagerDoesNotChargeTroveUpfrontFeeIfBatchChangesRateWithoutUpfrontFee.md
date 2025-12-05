# Function: testSwitchBatchManagerDoesNotChargeTroveUpfrontFeeIfBatchChangesRateWithoutUpfrontFee()

**Contract**: [test/interestBatchManagement.t.sol/contract_InterestBatchManagementTest.md]

## Metadata

- **Contract**: InterestBatchManagementTest
- **Signature**: `testSwitchBatchManagerDoesNotChargeTroveUpfrontFeeIfBatchChangesRateWithoutUpfrontFee()`
- **Visibility**: public
- **Source Range**: 49295:1254:304

## Implementation

```solidity
function testSwitchBatchManagerDoesNotChargeTroveUpfrontFeeIfBatchChangesRateWithoutUpfrontFee() public {
    registerBatchManager(B, uint128(MIN_ANNUAL_INTEREST_RATE), 1e18, 5e16, 0, MIN_INTEREST_RATE_CHANGE_PERIOD);
    registerBatchManager(C, uint128(MIN_ANNUAL_INTEREST_RATE), 1e18, 5e16, 0, MIN_INTEREST_RATE_CHANGE_PERIOD);
    vm.warp((block.timestamp + INTEREST_RATE_ADJ_COOLDOWN) + 1);
    uint256 troveId = openTroveAndJoinBatchManager(A, 100 ether, 2000e18, B, 5e16);
    switchBatchManager(A, troveId, C);
    uint256 ADebtBefore = troveManager.getTroveEntireDebt(troveId);
    setBatchInterestRate(C, 10e16);
    assertEq(troveManager.getTroveEntireDebt(troveId), ADebtBefore, "A debt should be the same");
    LatestTroveData memory troveData = troveManager.getLatestTroveData(troveId);
    assertEq(troveData.lastInterestRateAdjTime, block.timestamp, "Wrong interest rate adj time for A");
}
```

## Related Implementations

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

### setBatchInterestRate(address,uint256)

- **Kind**: internal
- **Source**: 17019:283:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:setBatchInterestRate(address,uint256)`

```solidity
function setBatchInterestRate(address _batchAddress, uint256 _newAnnualInterestRate) internal {
    vm.startPrank(_batchAddress);
    borrowerOperations.setBatchManagerAnnualInterestRate(uint128(_newAnnualInterestRate), 0, 0, type(uint256).max);
    vm.stopPrank();
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

- **Vm::warp(uint256)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **ITroveManagerTester::getLatestTroveData(uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestBatchManagementTest.testSwitchBatchManagerDoesNotChargeTroveUpfrontFeeIfBatchChangesRateWithoutUpfrontFee() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 1)
  │   💬 Args: [B, uint128(MIN_ANNUAL_INTEREST_RATE), 1e18, 5e16, 0, MIN_INTEREST_RATE_CHANGE_PERIOD]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 2)
  │   💬 Args: [C, uint128(MIN_ANNUAL_INTEREST_RATE), 1e18, 5e16, 0, MIN_INTEREST_RATE_CHANGE_PERIOD]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManager(address,uint256,uint256,address,uint256) (NodeID: 3)
  │   💬 Args: [A, 100 ether, 2000e18, B, 5e16]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManagerWithIndex(address,uint256,uint256,uint256,address,uint256) (NodeID: 4)
  │     💬 Args: [_troveOwner, 0, _coll, _debt, _batchAddress, _annualInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 5)
  │       💬 Args: [_batchAddress, uint128(LiquityMath._min(1e16, _annualInterestRate)), uint128(LiquityMath._max(20e16, _annualInterestRate)), uint128(_annualInterestRate), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 6)
  │     │   💬 Args: [1e16, _annualInterestRate]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 7)
  │         💬 Args: [20e16, _annualInterestRate]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.switchBatchManager(address,uint256,address) (NodeID: 8)
  │   💬 Args: [A, troveId, C]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.switchBatchManager(address,uint256,uint256,uint256,address,uint256,uint256,uint256) (NodeID: 9)
  │     💬 Args: [_troveOwner, _troveId, 0, 0, _newBatchManager, 0, 0, type(uint256).max]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.setBatchInterestRate(address,uint256) (NodeID: 10)
  │   💬 Args: [C, 10e16]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 11)
  │   💬 Args: [troveManager.getTroveEntireDebt(troveId), ADebtBefore, "A debt should be the same"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 12)
      💬 Args: [troveData.lastInterestRateAdjTime, block.timestamp, "Wrong interest rate adj time for A"]
      👁️  Def: internal
```
