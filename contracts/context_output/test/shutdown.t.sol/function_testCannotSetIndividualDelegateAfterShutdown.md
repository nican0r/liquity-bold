# Function: testCannotSetIndividualDelegateAfterShutdown()

**Contract**: [test/shutdown.t.sol/contract_ShutdownTest.md]

## Metadata

- **Contract**: ShutdownTest
- **Signature**: `testCannotSetIndividualDelegateAfterShutdown()`
- **Visibility**: public
- **Source Range**: 11475:342:333

## Implementation

```solidity
function testCannotSetIndividualDelegateAfterShutdown() public {
    uint256 troveId = prepareAndShutdownFirstBranch();
    vm.startPrank(A);
    vm.expectRevert(BorrowerOperations.IsShutDown.selector);
    borrowerOperations.setInterestIndividualDelegate(troveId, B, 5e15, 1e18, 0, 0, 0, 0, 0);
    vm.stopPrank();
}
```

## Related Implementations

### prepareAndShutdownFirstBranch()

- **Kind**: internal
- **Source**: 4396:373:333
- **Link**: `test/shutdown.t.sol:ShutdownTest:prepareAndShutdownFirstBranch()`

```solidity
function prepareAndShutdownFirstBranch() internal returns (uint256) {
    uint256 troveId = openMulticollateralTroveNoHints100pctWithIndex(0, A, 0, 11e18, 10000e18, 5e16);
    contractsArray[0].priceFeed.setPrice(1000e18);
    contractsArray[0].borrowerOperations.shutdown();
    return troveId;
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

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **IBorrowerOperationsTester::setInterestIndividualDelegate(uint256,address,uint128,uint128,uint256,uint256,uint256,uint256,uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **contractsArray** (`struct TestDeployer.LiquityContractsDev[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ShutdownTest.testCannotSetIndividualDelegateAfterShutdown() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ShutdownTest.prepareAndShutdownFirstBranch() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ShutdownTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 2)
        💬 Args: [0, A, 0, 11e18, 10000e18, 5e16]
        👁️  Def: public
      └─ [3] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 3)
          💬 Args: [troveChange.debtIncrease, avgInterestRate]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 4)
            💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
            👁️  Def: internal
```
