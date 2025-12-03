# Function: testCannotUrgentRedeemWithoutEnoughBalance()

**Contract**: [test/shutdown.t.sol/contract_ShutdownTest.md]

## Metadata

- **Contract**: ShutdownTest
- **Signature**: `testCannotUrgentRedeemWithoutEnoughBalance()`
- **Visibility**: public
- **Source Range**: 15254:482:333

## Implementation

```solidity
function testCannotUrgentRedeemWithoutEnoughBalance() public {
    uint256 troveId = prepareAndShutdownFirstBranch();
    vm.startPrank(A);
    boldToken.transfer(B, 900e18);
    vm.stopPrank();
    vm.startPrank(B);
    vm.expectRevert(TroveManager.NotEnoughBoldBalance.selector);
    troveManager.urgentRedemption(1000e18, uintToArray(troveId), 0);
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

### uintToArray(uint256)

- **Kind**: internal
- **Source**: 20346:153:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:uintToArray(uint256)`

```solidity
function uintToArray(uint256 _value) public pure returns (uint256[] memory result) {
    result = new uint256[](1);
    result[0] = _value;
}
```

## External Calls

- **Vm::startPrank(address)**
- **IBoldToken::transfer(address,uint256)**
- **Vm::stopPrank()**
- **Vm::expectRevert(bytes4)**
- **ITroveManagerTester::urgentRedemption(uint256,uint256[],uint256)**

## Native Transfers

- **boldToken** (computed)

## State Variable Reads

- **contractsArray** (`struct TestDeployer.LiquityContractsDev[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ShutdownTest.testCannotUrgentRedeemWithoutEnoughBalance() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ShutdownTest.prepareAndShutdownFirstBranch() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ShutdownTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [0, A, 0, 11e18, 10000e18, 5e16]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 3)
  │       💬 Args: [troveChange.debtIncrease, avgInterestRate]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 4)
  │         💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseTest.uintToArray(uint256) (NodeID: 5)
      💬 Args: [troveId]
      👁️  Def: public
```
