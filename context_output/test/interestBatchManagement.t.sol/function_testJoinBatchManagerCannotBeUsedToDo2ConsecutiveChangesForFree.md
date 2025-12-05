# Function: testJoinBatchManagerCannotBeUsedToDo2ConsecutiveChangesForFree()

**Contract**: [test/interestBatchManagement.t.sol/contract_InterestBatchManagementTest.md]

## Metadata

- **Contract**: InterestBatchManagementTest
- **Signature**: `testJoinBatchManagerCannotBeUsedToDo2ConsecutiveChangesForFree()`
- **Visibility**: public
- **Source Range**: 54059:1859:304

## Implementation

```solidity
function testJoinBatchManagerCannotBeUsedToDo2ConsecutiveChangesForFree() public {
    registerBatchManager(B, uint128(MIN_ANNUAL_INTEREST_RATE), 1e18, 5e16, 0, MIN_INTEREST_RATE_CHANGE_PERIOD);
    uint256 troveId = openTroveNoHints100pct(A, 100 ether, 2000e18, 5e16);
    vm.warp((block.timestamp + INTEREST_RATE_ADJ_COOLDOWN) + 1);
    uint256 ADebtBefore = troveManager.getTroveEntireDebt(troveId);
    uint256 upfrontFee = predictJoinBatchInterestRateUpfrontFee(troveId, B);
    setInterestBatchManager(A, troveId, B);
    assertGt(upfrontFee, 0, "Upfront fee should be > 0");
    assertEq(troveManager.getTroveEntireDebt(troveId), ADebtBefore + upfrontFee, "A debt should increase by upfrontfee after first switch");
    LatestTroveData memory troveData = troveManager.getLatestTroveData(troveId);
    assertEq(troveData.lastInterestRateAdjTime, block.timestamp, "Wrong interest rate adj time for A after first switch");
    ADebtBefore = troveManager.getTroveEntireDebt(troveId);
    setBatchInterestRate(B, 6e16);
    assertEq(troveManager.getTroveEntireDebt(troveId), ADebtBefore, "A debt should not increase after first batch adjust");
    troveData = troveManager.getLatestTroveData(troveId);
    assertEq(troveData.lastInterestRateAdjTime, block.timestamp, "Wrong interest rate adj time for A after first batch adjust");
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

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 13228:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertGt(left, right, err);
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

## External Calls

- **Vm::warp(uint256)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **ITroveManagerTester::getLatestTroveData(uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestBatchManagementTest.testJoinBatchManagerCannotBeUsedToDo2ConsecutiveChangesForFree() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 1)
  │   💬 Args: [B, uint128(MIN_ANNUAL_INTEREST_RATE), 1e18, 5e16, 0, MIN_INTEREST_RATE_CHANGE_PERIOD]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 2)
  │   💬 Args: [A, 100 ether, 2000e18, 5e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 3)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 4)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.predictJoinBatchInterestRateUpfrontFee(uint256,address) (NodeID: 5)
  │   💬 Args: [troveId, B]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.setInterestBatchManager(address,uint256,address) (NodeID: 6)
  │   💬 Args: [A, troveId, B]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [upfrontFee, 0, "Upfront fee should be > 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 8)
  │   💬 Args: [troveManager.getTroveEntireDebt(troveId), ADebtBefore + upfrontFee, "A debt should increase by upfrontfee after first switch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 9)
  │   💬 Args: [troveData.lastInterestRateAdjTime, block.timestamp, "Wrong interest rate adj time for A after first switch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.setBatchInterestRate(address,uint256) (NodeID: 10)
  │   💬 Args: [B, 6e16]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 11)
  │   💬 Args: [troveManager.getTroveEntireDebt(troveId), ADebtBefore, "A debt should not increase after first batch adjust"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 12)
      💬 Args: [troveData.lastInterestRateAdjTime, block.timestamp, "Wrong interest rate adj time for A after first batch adjust"]
      👁️  Def: internal
```
