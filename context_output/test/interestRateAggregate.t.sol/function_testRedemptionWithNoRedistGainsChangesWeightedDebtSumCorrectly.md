# Function: testRedemptionWithNoRedistGainsChangesWeightedDebtSumCorrectly()

**Contract**: [test/interestRateAggregate.t.sol/contract_InterestRateAggregate.md]

## Metadata

- **Contract**: InterestRateAggregate
- **Signature**: `testRedemptionWithNoRedistGainsChangesWeightedDebtSumCorrectly()`
- **Visibility**: public
- **Source Range**: 79580:1816:306

## Implementation

```solidity
function testRedemptionWithNoRedistGainsChangesWeightedDebtSumCorrectly() public {
    (, , ABCDEF memory troveIDs) = _setupForRedemptionAscendingInterest();
    vm.warp(block.timestamp + 1 days);
    uint256 aggWeightedDebtSum_1 = activePool.aggWeightedDebtSum();
    uint256 oldWeightedRecordedDebt_A = troveManager.getTroveWeightedRecordedDebt(troveIDs.A);
    uint256 oldWeightedRecordedDebt_B = troveManager.getTroveWeightedRecordedDebt(troveIDs.B);
    assertGt(oldWeightedRecordedDebt_A, 0);
    assertGt(oldWeightedRecordedDebt_B, 0);
    uint256 debt_A = troveManager.getTroveEntireDebt(troveIDs.A);
    uint256 debt_B = troveManager.getTroveEntireDebt(troveIDs.B);
    uint256 debt_C = troveManager.getTroveEntireDebt(troveIDs.C);
    redeem(E, debt_A + (debt_B / 2));
    assertEq(troveManager.getTroveEntireDebt(troveIDs.C), debt_C);
    uint256 newWeightedRecordedDebt_A = troveManager.getTroveWeightedRecordedDebt(troveIDs.A);
    uint256 newWeightedRecordedDebt_B = troveManager.getTroveWeightedRecordedDebt(troveIDs.B);
    assertNotEq(oldWeightedRecordedDebt_A, newWeightedRecordedDebt_A);
    assertNotEq(oldWeightedRecordedDebt_B, newWeightedRecordedDebt_B);
    uint256 expectedAggWeightedRecordedDebt = (((aggWeightedDebtSum_1 + newWeightedRecordedDebt_A) + newWeightedRecordedDebt_B) - oldWeightedRecordedDebt_A) - oldWeightedRecordedDebt_B;
    assertEq(activePool.aggWeightedDebtSum(), expectedAggWeightedRecordedDebt);
}
```

## Related Implementations

### _setupForRedemptionAscendingInterest()

- **Kind**: internal
- **Source**: 10928:381:261
- **Link**: `test/TestContracts/DevTestSetup.sol:DevTestSetup:_setupForRedemptionAscendingInterest()`

```solidity
function _setupForRedemptionAscendingInterest() internal returns (uint256, uint256, ABCDEF memory) {
    ABCDEF memory troveInterestRates;
    troveInterestRates.A = 1e17;
    troveInterestRates.B = 2e17;
    troveInterestRates.C = 3e17;
    troveInterestRates.D = 4e17;
    return _setupForRedemption(troveInterestRates);
}
```

### _setupForRedemption(struct BaseTest.ABCDEF)

- **Kind**: internal
- **Source**: 9214:232:261
- **Link**: `test/TestContracts/DevTestSetup.sol:DevTestSetup:_setupForRedemption(struct BaseTest.ABCDEF)`

```solidity
function _setupForRedemption(ABCDEF memory _troveInterestRates) internal returns (uint256 coll, uint256 debtRequest, ABCDEF memory troveIDs) {
    return _setupForRedemption(_troveInterestRates, false);
}
```

### _setupForRedemption(struct BaseTest.ABCDEF,bool)

- **Kind**: internal
- **Source**: 9452:1470:261
- **Link**: `test/TestContracts/DevTestSetup.sol:DevTestSetup:_setupForRedemption(struct BaseTest.ABCDEF,bool)`

```solidity
function _setupForRedemption(ABCDEF memory _troveInterestRates, bool _batched) internal returns (uint256 coll, uint256 debtRequest, ABCDEF memory troveIDs) {
    priceFeed.setPrice(2000e18);
    vm.warp(block.timestamp + 14 days);
    coll = 20 ether;
    debtRequest = 20200e18;
    if (_batched) {
        troveIDs.A = openTroveAndJoinBatchManager(A, coll, debtRequest, A, _troveInterestRates.A);
        troveIDs.B = openTroveAndJoinBatchManager(B, coll, debtRequest, B, _troveInterestRates.B);
        troveIDs.C = openTroveAndJoinBatchManager(C, coll, debtRequest, C, _troveInterestRates.C);
        troveIDs.D = openTroveAndJoinBatchManager(D, coll, debtRequest, D, _troveInterestRates.D);
    } else {
        troveIDs.A = openTroveNoHints100pct(A, coll, debtRequest, _troveInterestRates.A);
        troveIDs.B = openTroveNoHints100pct(B, coll, debtRequest, _troveInterestRates.B);
        troveIDs.C = openTroveNoHints100pct(C, coll, debtRequest, _troveInterestRates.C);
        troveIDs.D = openTroveNoHints100pct(D, coll, debtRequest, _troveInterestRates.D);
    }
    transferBold(A, E, boldToken.balanceOf(A));
    transferBold(B, E, boldToken.balanceOf(B));
    transferBold(C, E, boldToken.balanceOf(C));
    transferBold(D, E, boldToken.balanceOf(D));
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

### transferBold(address,address,uint256)

- **Kind**: internal
- **Source**: 13415:177:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:transferBold(address,address,uint256)`

```solidity
function transferBold(address _from, address _to, uint256 _amount) public {
    vm.startPrank(_from);
    boldToken.transfer(_to, _amount);
    vm.stopPrank();
}
```

### assertGt(uint256,uint256)

- **Kind**: internal
- **Source**: 13112:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256)`

```solidity
function assertGt(uint256 left, uint256 right) virtual internal pure {
    vm.assertGt(left, right);
}
```

### redeem(address,uint256)

- **Kind**: internal
- **Source**: 13971:197:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:redeem(address,uint256)`

```solidity
function redeem(address _from, uint256 _boldAmount) public {
    vm.startPrank(_from);
    collateralRegistry.redeemCollateral(_boldAmount, MAX_UINT256, 1e18);
    vm.stopPrank();
}
```

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
}
```

### assertNotEq(uint256,uint256)

- **Kind**: internal
- **Source**: 7186:116:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertNotEq(uint256,uint256)`

```solidity
function assertNotEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertNotEq(left, right);
}
```

## External Calls

- **Vm::warp(uint256)**
- **IActivePool::aggWeightedDebtSum()**
- **ITroveManagerTester::getTroveWeightedRecordedDebt(uint256)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestRateAggregate.testRedemptionWithNoRedistGainsChangesWeightedDebtSumCorrectly() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: DevTestSetup._setupForRedemptionAscendingInterest() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: DevTestSetup._setupForRedemption(struct BaseTest.ABCDEF) (NodeID: 2)
  │     💬 Args: [troveInterestRates]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: DevTestSetup._setupForRedemption(struct BaseTest.ABCDEF,bool) (NodeID: 3)
  │       💬 Args: [_troveInterestRates, false]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManager(address,uint256,uint256,address,uint256) (NodeID: 4)
  │     │   💬 Args: [A, coll, debtRequest, A, _troveInterestRates.A]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManagerWithIndex(address,uint256,uint256,uint256,address,uint256) (NodeID: 5)
  │     │     💬 Args: [_troveOwner, 0, _coll, _debt, _batchAddress, _annualInterestRate]
  │     │     👁️  Def: internal
  │     │   └─ [6] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 6)
  │     │       💬 Args: [_batchAddress, uint128(LiquityMath._min(1e16, _annualInterestRate)), uint128(LiquityMath._max(20e16, _annualInterestRate)), uint128(_annualInterestRate), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
  │     │       👁️  Def: internal
  │     │     ├─ [7] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 7)
  │     │     │   💬 Args: [1e16, _annualInterestRate]
  │     │     │   👁️  Def: internal
  │     │     └─ [7] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 8)
  │     │         💬 Args: [20e16, _annualInterestRate]
  │     │         👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManager(address,uint256,uint256,address,uint256) (NodeID: 9)
  │     │   💬 Args: [B, coll, debtRequest, B, _troveInterestRates.B]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManagerWithIndex(address,uint256,uint256,uint256,address,uint256) (NodeID: 10)
  │     │     💬 Args: [_troveOwner, 0, _coll, _debt, _batchAddress, _annualInterestRate]
  │     │     👁️  Def: internal
  │     │   └─ [6] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 11)
  │     │       💬 Args: [_batchAddress, uint128(LiquityMath._min(1e16, _annualInterestRate)), uint128(LiquityMath._max(20e16, _annualInterestRate)), uint128(_annualInterestRate), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
  │     │       👁️  Def: internal
  │     │     ├─ [7] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 12)
  │     │     │   💬 Args: [1e16, _annualInterestRate]
  │     │     │   👁️  Def: internal
  │     │     └─ [7] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 13)
  │     │         💬 Args: [20e16, _annualInterestRate]
  │     │         👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManager(address,uint256,uint256,address,uint256) (NodeID: 14)
  │     │   💬 Args: [C, coll, debtRequest, C, _troveInterestRates.C]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManagerWithIndex(address,uint256,uint256,uint256,address,uint256) (NodeID: 15)
  │     │     💬 Args: [_troveOwner, 0, _coll, _debt, _batchAddress, _annualInterestRate]
  │     │     👁️  Def: internal
  │     │   └─ [6] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 16)
  │     │       💬 Args: [_batchAddress, uint128(LiquityMath._min(1e16, _annualInterestRate)), uint128(LiquityMath._max(20e16, _annualInterestRate)), uint128(_annualInterestRate), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
  │     │       👁️  Def: internal
  │     │     ├─ [7] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 17)
  │     │     │   💬 Args: [1e16, _annualInterestRate]
  │     │     │   👁️  Def: internal
  │     │     └─ [7] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 18)
  │     │         💬 Args: [20e16, _annualInterestRate]
  │     │         👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManager(address,uint256,uint256,address,uint256) (NodeID: 19)
  │     │   💬 Args: [D, coll, debtRequest, D, _troveInterestRates.D]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManagerWithIndex(address,uint256,uint256,uint256,address,uint256) (NodeID: 20)
  │     │     💬 Args: [_troveOwner, 0, _coll, _debt, _batchAddress, _annualInterestRate]
  │     │     👁️  Def: internal
  │     │   └─ [6] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 21)
  │     │       💬 Args: [_batchAddress, uint128(LiquityMath._min(1e16, _annualInterestRate)), uint128(LiquityMath._max(20e16, _annualInterestRate)), uint128(_annualInterestRate), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
  │     │       👁️  Def: internal
  │     │     ├─ [7] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 22)
  │     │     │   💬 Args: [1e16, _annualInterestRate]
  │     │     │   👁️  Def: internal
  │     │     └─ [7] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 23)
  │     │         💬 Args: [20e16, _annualInterestRate]
  │     │         👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 24)
  │     │   💬 Args: [A, coll, debtRequest, _troveInterestRates.A]
  │     │   👁️  Def: public
  │     │ └─ [5] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 25)
  │     │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     │     👁️  Def: public
  │     │   └─ [6] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 26)
  │     │       💬 Args: [_boldAmount, _annualInterestRate]
  │     │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 27)
  │     │   💬 Args: [B, coll, debtRequest, _troveInterestRates.B]
  │     │   👁️  Def: public
  │     │ └─ [5] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 28)
  │     │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     │     👁️  Def: public
  │     │   └─ [6] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 29)
  │     │       💬 Args: [_boldAmount, _annualInterestRate]
  │     │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 30)
  │     │   💬 Args: [C, coll, debtRequest, _troveInterestRates.C]
  │     │   👁️  Def: public
  │     │ └─ [5] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 31)
  │     │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     │     👁️  Def: public
  │     │   └─ [6] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 32)
  │     │       💬 Args: [_boldAmount, _annualInterestRate]
  │     │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 33)
  │     │   💬 Args: [D, coll, debtRequest, _troveInterestRates.D]
  │     │   👁️  Def: public
  │     │ └─ [5] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 34)
  │     │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     │     👁️  Def: public
  │     │   └─ [6] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 35)
  │     │       💬 Args: [_boldAmount, _annualInterestRate]
  │     │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: BaseTest.transferBold(address,address,uint256) (NodeID: 36)
  │     │   💬 Args: [A, E, boldToken.balanceOf(A)]
  │     │   👁️  Def: public
  │     ├─ [4] ⚙️ FUNCTION: BaseTest.transferBold(address,address,uint256) (NodeID: 37)
  │     │   💬 Args: [B, E, boldToken.balanceOf(B)]
  │     │   👁️  Def: public
  │     ├─ [4] ⚙️ FUNCTION: BaseTest.transferBold(address,address,uint256) (NodeID: 38)
  │     │   💬 Args: [C, E, boldToken.balanceOf(C)]
  │     │   👁️  Def: public
  │     └─ [4] ⚙️ FUNCTION: BaseTest.transferBold(address,address,uint256) (NodeID: 39)
  │         💬 Args: [D, E, boldToken.balanceOf(D)]
  │         👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 40)
  │   💬 Args: [oldWeightedRecordedDebt_A, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 41)
  │   💬 Args: [oldWeightedRecordedDebt_B, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.redeem(address,uint256) (NodeID: 42)
  │   💬 Args: [E, debt_A + (debt_B / 2)]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 43)
  │   💬 Args: [troveManager.getTroveEntireDebt(troveIDs.C), debt_C]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(uint256,uint256) (NodeID: 44)
  │   💬 Args: [oldWeightedRecordedDebt_A, newWeightedRecordedDebt_A]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(uint256,uint256) (NodeID: 45)
  │   💬 Args: [oldWeightedRecordedDebt_B, newWeightedRecordedDebt_B]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 46)
      💬 Args: [activePool.aggWeightedDebtSum(), expectedAggWeightedRecordedDebt]
      👁️  Def: internal
```
