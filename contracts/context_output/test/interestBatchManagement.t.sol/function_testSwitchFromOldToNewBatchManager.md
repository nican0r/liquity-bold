# Function: testSwitchFromOldToNewBatchManager()

**Contract**: [test/interestBatchManagement.t.sol/contract_InterestBatchManagementTest.md]

## Metadata

- **Contract**: InterestBatchManagementTest
- **Signature**: `testSwitchFromOldToNewBatchManager()`
- **Visibility**: public
- **Source Range**: 20279:6054:304

## Implementation

```solidity
function testSwitchFromOldToNewBatchManager() public {
    ABCDEF memory troveIDs;
    ABCDEF memory troveRecordedDebtBefore;
    ABCDEF memory troveEntireDebtBefore;
    ABCDEF memory batchRecordedDebtBefore;
    ABCDEF memory batchEntireDebtBefore;
    troveIDs.A = openTroveAndJoinBatchManager();
    registerBatchManager(C);
    IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory paramsD = IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams({owner: D, ownerIndex: 0, collAmount: 100e18, boldAmount: 5000e18, upperHint: 0, lowerHint: 0, interestBatchManager: C, maxUpfrontFee: 1e24, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(D);
    troveIDs.D = borrowerOperations.openTroveAndJoinInterestBatchManager(paramsD);
    vm.stopPrank();
    IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory paramsE = IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams({owner: E, ownerIndex: 0, collAmount: 100e18, boldAmount: 5000e18, upperHint: 0, lowerHint: 0, interestBatchManager: B, maxUpfrontFee: 1e24, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(E);
    troveIDs.E = borrowerOperations.openTroveAndJoinInterestBatchManager(paramsE);
    vm.stopPrank();
    vm.warp(block.timestamp + 365 days);
    troveRecordedDebtBefore.A = troveManager.getTroveDebt(troveIDs.A);
    troveEntireDebtBefore.A = troveManager.getTroveEntireDebt(troveIDs.A);
    assertGt(troveEntireDebtBefore.A, troveRecordedDebtBefore.A, "Trove A entire debt should be greater than recorded");
    troveRecordedDebtBefore.D = troveManager.getTroveDebt(troveIDs.D);
    troveEntireDebtBefore.D = troveManager.getTroveEntireDebt(troveIDs.D);
    assertGt(troveEntireDebtBefore.D, troveRecordedDebtBefore.D, "Trove D entire debt should be greater than recorded");
    troveRecordedDebtBefore.E = troveManager.getTroveDebt(troveIDs.E);
    troveEntireDebtBefore.E = troveManager.getTroveEntireDebt(troveIDs.E);
    assertGt(troveEntireDebtBefore.E, troveRecordedDebtBefore.E, "Trove E entire debt should be greater than recorded");
    LatestBatchData memory batchB = troveManager.getLatestBatchData(B);
    batchRecordedDebtBefore.B = batchB.recordedDebt;
    batchEntireDebtBefore.B = batchB.entireDebtWithoutRedistribution;
    assertGt(batchEntireDebtBefore.B, batchRecordedDebtBefore.B, "Batch B entire debt should be greater than recorded");
    LatestBatchData memory batchC = troveManager.getLatestBatchData(C);
    batchRecordedDebtBefore.C = batchC.recordedDebt;
    batchEntireDebtBefore.C = batchC.entireDebtWithoutRedistribution;
    assertGt(batchEntireDebtBefore.C, batchRecordedDebtBefore.C, "Batch C entire debt should be greater than recorded");
    removeFromBatch(E, troveIDs.E, 5e16);
    uint256 upfrontFee = predictJoinBatchInterestRateUpfrontFee(troveIDs.E, C);
    setInterestBatchManager(E, troveIDs.E, C);
    assertEq(borrowerOperations.interestBatchManagerOf(troveIDs.E), C, "Wrong batch manager in BO");
    (, , , , , , , , address tmBatchManagerAddress, ) = troveManager.Troves(troveIDs.E);
    assertEq(tmBatchManagerAddress, C, "Wrong batch manager in TM");
    assertApproxEqAbs(troveManager.getTroveDebt(troveIDs.A), troveEntireDebtBefore.A, 10, "Interest was not applied to trove A");
    assertEq(troveManager.getTroveDebt(troveIDs.A), troveManager.getTroveEntireDebt(troveIDs.A), "Trove A recorded debt should be equal to entire");
    assertApproxEqAbs(troveManager.getTroveDebt(troveIDs.D), troveEntireDebtBefore.D, 1, "Interest was not applied to trove D");
    assertEq(troveManager.getTroveDebt(troveIDs.D), troveManager.getTroveEntireDebt(troveIDs.D), "Trove D recorded debt should be equal to entire");
    assertApproxEqAbs(troveManager.getTroveDebt(troveIDs.E), troveEntireDebtBefore.E + upfrontFee, 1, "Interest was not applied to trove E");
    assertEq(troveManager.getTroveDebt(troveIDs.E), troveManager.getTroveEntireDebt(troveIDs.E), "Trove E recorded debt should be equal to entire");
    batchB = troveManager.getLatestBatchData(B);
    assertEq(batchB.recordedDebt, batchEntireDebtBefore.B - troveEntireDebtBefore.E, "Interest was not applied to batch B");
    assertEq(batchB.recordedDebt, batchB.entireDebtWithoutRedistribution, "Batch B recorded debt should be equal to entire");
    batchC = troveManager.getLatestBatchData(C);
    assertEq(batchC.recordedDebt, (batchEntireDebtBefore.C + troveEntireDebtBefore.E) + upfrontFee, "Interest was not applied to batch C");
    assertEq(batchC.recordedDebt, batchC.entireDebtWithoutRedistribution, "Batch C recorded debt should be equal to entire");
}
```

## Related Implementations

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

### registerBatchManager(address)

- **Kind**: internal
- **Source**: 14398:221:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:registerBatchManager(address)`

```solidity
function registerBatchManager(address _account) internal {
    registerBatchManager(_account, uint128(1e16), uint128(20e16), uint128(5e16), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD);
}
```

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 13228:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertGt(left, right, err);
}
```

### removeFromBatch(address,uint256,uint256)

- **Kind**: internal
- **Source**: 18213:275:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:removeFromBatch(address,uint256,uint256)`

```solidity
function removeFromBatch(address _troveOwner, uint256 _troveId, uint256 _newAnnualInterestRate) internal {
    vm.startPrank(_troveOwner);
    borrowerOperations.removeFromBatch(_troveId, _newAnnualInterestRate, 0, 0, type(uint256).max);
    vm.stopPrank();
}
```

### predictJoinBatchInterestRateUpfrontFee(uint256,address)

- **Kind**: internal
- **Source**: 4482:251:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:predictJoinBatchInterestRateUpfrontFee(uint256,address)`

```solidity
function predictJoinBatchInterestRateUpfrontFee(uint256 _troveId, address _batchAddress) internal view returns (uint256) {
    return hintHelpers.predictJoinBatchInterestRateUpfrontFee(0, _troveId, _batchAddress);
}
```

### setInterestBatchManager(address,uint256,address)

- **Kind**: internal
- **Source**: 17928:279:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:setInterestBatchManager(address,uint256,address)`

```solidity
function setInterestBatchManager(address _troveOwner, uint256 _troveId, address _newBatchManager) internal {
    vm.startPrank(_troveOwner);
    borrowerOperations.setInterestBatchManager(_troveId, _newBatchManager, 0, 0, type(uint256).max);
    vm.stopPrank();
}
```

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 3570:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
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

- **Vm::startPrank(address)**
- **IBorrowerOperationsTester::openTroveAndJoinInterestBatchManager(struct IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams)**
- **Vm::stopPrank()**
- **Vm::warp(uint256)**
- **ITroveManagerTester::getTroveDebt(uint256)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **ITroveManagerTester::getLatestBatchData(address)**
- **IBorrowerOperationsTester::interestBatchManagerOf(uint256)**
- **ITroveManagerTester::Troves(uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestBatchManagementTest.testSwitchFromOldToNewBatchManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManager() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManager(address,uint256,uint256,address,uint256) (NodeID: 2)
  │     💬 Args: [A, 100e18, 5000e18, B, 5e16]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManagerWithIndex(address,uint256,uint256,uint256,address,uint256) (NodeID: 3)
  │       💬 Args: [_troveOwner, 0, _coll, _debt, _batchAddress, _annualInterestRate]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 4)
  │         💬 Args: [_batchAddress, uint128(LiquityMath._min(1e16, _annualInterestRate)), uint128(LiquityMath._max(20e16, _annualInterestRate)), uint128(_annualInterestRate), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 5)
  │       │   💬 Args: [1e16, _annualInterestRate]
  │       │   👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 6)
  │           💬 Args: [20e16, _annualInterestRate]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.registerBatchManager(address) (NodeID: 7)
  │   💬 Args: [C]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 8)
  │     💬 Args: [_account, uint128(1e16), uint128(20e16), uint128(5e16), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 9)
  │   💬 Args: [troveEntireDebtBefore.A, troveRecordedDebtBefore.A, "Trove A entire debt should be greater than recorded"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 10)
  │   💬 Args: [troveEntireDebtBefore.D, troveRecordedDebtBefore.D, "Trove D entire debt should be greater than recorded"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 11)
  │   💬 Args: [troveEntireDebtBefore.E, troveRecordedDebtBefore.E, "Trove E entire debt should be greater than recorded"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 12)
  │   💬 Args: [batchEntireDebtBefore.B, batchRecordedDebtBefore.B, "Batch B entire debt should be greater than recorded"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 13)
  │   💬 Args: [batchEntireDebtBefore.C, batchRecordedDebtBefore.C, "Batch C entire debt should be greater than recorded"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.removeFromBatch(address,uint256,uint256) (NodeID: 14)
  │   💬 Args: [E, troveIDs.E, 5e16]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.predictJoinBatchInterestRateUpfrontFee(uint256,address) (NodeID: 15)
  │   💬 Args: [troveIDs.E, C]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.setInterestBatchManager(address,uint256,address) (NodeID: 16)
  │   💬 Args: [E, troveIDs.E, C]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 17)
  │   💬 Args: [borrowerOperations.interestBatchManagerOf(troveIDs.E), C, "Wrong batch manager in BO"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 18)
  │   💬 Args: [tmBatchManagerAddress, C, "Wrong batch manager in TM"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 19)
  │   💬 Args: [troveManager.getTroveDebt(troveIDs.A), troveEntireDebtBefore.A, 10, "Interest was not applied to trove A"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 20)
  │   💬 Args: [troveManager.getTroveDebt(troveIDs.A), troveManager.getTroveEntireDebt(troveIDs.A), "Trove A recorded debt should be equal to entire"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 21)
  │   💬 Args: [troveManager.getTroveDebt(troveIDs.D), troveEntireDebtBefore.D, 1, "Interest was not applied to trove D"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 22)
  │   💬 Args: [troveManager.getTroveDebt(troveIDs.D), troveManager.getTroveEntireDebt(troveIDs.D), "Trove D recorded debt should be equal to entire"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 23)
  │   💬 Args: [troveManager.getTroveDebt(troveIDs.E), troveEntireDebtBefore.E + upfrontFee, 1, "Interest was not applied to trove E"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 24)
  │   💬 Args: [troveManager.getTroveDebt(troveIDs.E), troveManager.getTroveEntireDebt(troveIDs.E), "Trove E recorded debt should be equal to entire"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 25)
  │   💬 Args: [batchB.recordedDebt, batchEntireDebtBefore.B - troveEntireDebtBefore.E, "Interest was not applied to batch B"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 26)
  │   💬 Args: [batchB.recordedDebt, batchB.entireDebtWithoutRedistribution, "Batch B recorded debt should be equal to entire"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 27)
  │   💬 Args: [batchC.recordedDebt, (batchEntireDebtBefore.C + troveEntireDebtBefore.E) + upfrontFee, "Interest was not applied to batch C"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 28)
      💬 Args: [batchC.recordedDebt, batchC.entireDebtWithoutRedistribution, "Batch C recorded debt should be equal to entire"]
      👁️  Def: internal
```
