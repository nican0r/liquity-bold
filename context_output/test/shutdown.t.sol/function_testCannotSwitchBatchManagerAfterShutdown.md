# Function: testCannotSwitchBatchManagerAfterShutdown()

**Contract**: [test/shutdown.t.sol/contract_ShutdownTest.md]

## Metadata

- **Contract**: ShutdownTest
- **Signature**: `testCannotSwitchBatchManagerAfterShutdown()`
- **Visibility**: public
- **Source Range**: 13682:818:333

## Implementation

```solidity
function testCannotSwitchBatchManagerAfterShutdown() public {
    registerBatchManager(B, 5e15, 1e18, 10e16, 25e14, 30 days);
    registerBatchManager(C, 5e15, 1e18, 10e16, 25e14, 30 days);
    uint256 troveId = openMulticollateralTroveNoHints100pctWithIndex(0, A, 0, 11e18, 10000e18, 5e16);
    setInterestBatchManager(A, troveId, B, 5e15);
    contractsArray[0].priceFeed.setPrice(1000e18);
    contractsArray[0].borrowerOperations.shutdown();
    vm.startPrank(A);
    vm.expectRevert(BorrowerOperations.IsShutDown.selector);
    borrowerOperations.switchBatchManager(troveId, 0, 0, C, 0, 0, 1000e18);
    vm.stopPrank();
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

### openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 3292:1098:333
- **Link**: `test/shutdown.t.sol:ShutdownTest:openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256)`

```solidity
function openMulticollateralTroveNoHints100pctWithIndex(uint256 _collIndex, address _account, uint256 _index, uint256 _coll, uint256 _boldAmount, uint256 _annualInterestRate) public returns (uint256 troveId) {
    TroveChange memory troveChange;
    troveChange.debtIncrease = _boldAmount;
    troveChange.newWeightedRecordedDebt = troveChange.debtIncrease * _annualInterestRate;
    uint256 avgInterestRate = contractsArray[_collIndex].activePool.getNewApproxAvgInterestRateFromTroveChange(troveChange);
    uint256 upfrontFee = calcUpfrontFee(troveChange.debtIncrease, avgInterestRate);
    vm.startPrank(_account);
    troveId = contractsArray[_collIndex].borrowerOperations.openTrove(_account, _index, _coll, _boldAmount, 0, 0, _annualInterestRate, upfrontFee, address(0), address(0), address(0));
    vm.stopPrank();
}
```

### calcUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 3360:180:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:calcUpfrontFee(uint256,uint256)`

```solidity
function calcUpfrontFee(uint256 debt, uint256 avgInterestRate) internal pure returns (uint256) {
    return calcInterest(debt * avgInterestRate, UPFRONT_INTEREST_PERIOD);
}
```

### calcInterest(uint256,uint256)

- **Kind**: internal
- **Source**: 3170:184:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:calcInterest(uint256,uint256)`

```solidity
function calcInterest(uint256 weightedRecordedDebt, uint256 period) internal pure returns (uint256) {
    return ((weightedRecordedDebt * period) / 365 days) / DECIMAL_PRECISION;
}
```

### setInterestBatchManager(address,uint256,address,uint256)

- **Kind**: internal
- **Source**: 17308:614:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:setInterestBatchManager(address,uint256,address,uint256)`

```solidity
function setInterestBatchManager(address _troveOwner, uint256 _troveId, address _newBatchManager, uint256 _annualInterestRate) internal {
    if (!borrowerOperations.checkBatchManagerExists(_newBatchManager)) {
        registerBatchManager(_newBatchManager, uint128(1e16), uint128(20e16), uint128(_annualInterestRate), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD);
    }
    setInterestBatchManager(_troveOwner, _troveId, _newBatchManager);
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

## External Calls

- **IPriceFeedTestnet::setPrice(uint256)**
- **IBorrowerOperationsTester::shutdown()**
- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **IBorrowerOperationsTester::switchBatchManager(uint256,uint256,uint256,address,uint256,uint256,uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **contractsArray** (`struct TestDeployer.LiquityContractsDev[]`)
- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ShutdownTest.testCannotSwitchBatchManagerAfterShutdown() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 1)
  │   💬 Args: [B, 5e15, 1e18, 10e16, 25e14, 30 days]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 2)
  │   💬 Args: [C, 5e15, 1e18, 10e16, 25e14, 30 days]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ShutdownTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 3)
  │   💬 Args: [0, A, 0, 11e18, 10000e18, 5e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 4)
  │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 5)
  │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseTest.setInterestBatchManager(address,uint256,address,uint256) (NodeID: 6)
      💬 Args: [A, troveId, B, 5e15]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 7)
    │   💬 Args: [_newBatchManager, uint128(1e16), uint128(20e16), uint128(_annualInterestRate), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BaseTest.setInterestBatchManager(address,uint256,address) (NodeID: 8)
        💬 Args: [_troveOwner, _troveId, _newBatchManager]
        👁️  Def: internal
```
