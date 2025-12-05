# Function: testCanShutdownBranchesSeparately()

**Contract**: [test/shutdown.t.sol/contract_ShutdownTest.md]

## Metadata

- **Contract**: ShutdownTest
- **Signature**: `testCanShutdownBranchesSeparately()`
- **Visibility**: public
- **Source Range**: 4775:1718:333

## Implementation

```solidity
function testCanShutdownBranchesSeparately() public {
    openMulticollateralTroveNoHints100pctWithIndex(0, A, 0, 11e18, 10000e18, 5e16);
    openMulticollateralTroveNoHints100pctWithIndex(1, A, 0, 110e18, 10000e18, 5e16);
    openMulticollateralTroveNoHints100pctWithIndex(2, A, 0, 11e18, 100000e18, 5e16);
    openMulticollateralTroveNoHints100pctWithIndex(3, A, 0, 11e18, 12500e18, 5e16);
    vm.startPrank(A);
    for (uint256 i = 0; i < NUM_COLLATERALS; i++) {
        vm.expectRevert(BorrowerOperations.TCRNotBelowSCR.selector);
        contractsArray[i].borrowerOperations.shutdown();
    }
    contractsArray[0].priceFeed.setPrice(1000e18);
    contractsArray[0].borrowerOperations.shutdown();
    for (uint256 i = 1; i < NUM_COLLATERALS; i++) {
        vm.expectRevert(BorrowerOperations.TCRNotBelowSCR.selector);
        contractsArray[i].borrowerOperations.shutdown();
    }
    contractsArray[1].priceFeed.setPrice(100e18);
    contractsArray[1].borrowerOperations.shutdown();
    for (uint256 i = 2; i < NUM_COLLATERALS; i++) {
        vm.expectRevert(BorrowerOperations.TCRNotBelowSCR.selector);
        contractsArray[i].borrowerOperations.shutdown();
    }
    contractsArray[2].priceFeed.setPrice(10000e18);
    contractsArray[2].borrowerOperations.shutdown();
    for (uint256 i = 3; i < NUM_COLLATERALS; i++) {
        vm.expectRevert(BorrowerOperations.TCRNotBelowSCR.selector);
        contractsArray[i].borrowerOperations.shutdown();
    }
    contractsArray[3].priceFeed.setPrice(1250e18);
    contractsArray[3].borrowerOperations.shutdown();
    vm.stopPrank();
}
```

## Related Implementations

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
- **IBorrowerOperationsTester::shutdown()**
- **IPriceFeedTestnet::setPrice(uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **NUM_COLLATERALS** (`uint256`)
- **contractsArray** (`struct TestDeployer.LiquityContractsDev[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ShutdownTest.testCanShutdownBranchesSeparately() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ShutdownTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [0, A, 0, 11e18, 10000e18, 5e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 2)
  │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 3)
  │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ShutdownTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 4)
  │   💬 Args: [1, A, 0, 110e18, 10000e18, 5e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 5)
  │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 6)
  │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ShutdownTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 7)
  │   💬 Args: [2, A, 0, 11e18, 100000e18, 5e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 8)
  │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 9)
  │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ShutdownTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 10)
      💬 Args: [3, A, 0, 11e18, 12500e18, 5e16]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 11)
        💬 Args: [troveChange.debtIncrease, avgInterestRate]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 12)
          💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
          👁️  Def: internal
```
