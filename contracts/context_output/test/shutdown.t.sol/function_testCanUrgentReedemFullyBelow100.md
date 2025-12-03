# Function: testCanUrgentReedemFullyBelow100()

**Contract**: [test/shutdown.t.sol/contract_ShutdownTest.md]

## Metadata

- **Contract**: ShutdownTest
- **Signature**: `testCanUrgentReedemFullyBelow100()`
- **Visibility**: external
- **Source Range**: 17681:1381:333

## Implementation

```solidity
function testCanUrgentReedemFullyBelow100() external {
    openMulticollateralTroveNoHints100pctWithIndex(0, A, 0, 11e18, 9000e18, 5e16);
    openMulticollateralTroveNoHints100pctWithIndex(0, A, 1, 11e18, 10000e18, 5e16);
    uint256 troveId = openMulticollateralTroveNoHints100pctWithIndex(0, A, 2, 11e18, 11000e18, 5e16);
    uint256 price = 1000e18;
    contractsArray[0].priceFeed.setPrice(price);
    contractsArray[0].borrowerOperations.shutdown();
    uint256 icr = troveManager.getCurrentICR(troveId, price);
    assertLt(icr, 1e18, "Trove CR should be below 100%");
    uint256 boldBalanceBefore = boldToken.balanceOf(A);
    uint256 collBalanceBefore = contractsArray[0].collToken.balanceOf(A);
    uint256 redemptionAmount = troveManager.getTroveEntireDebt(troveId);
    vm.startPrank(A);
    troveManager.urgentRedemption(redemptionAmount, uintToArray(troveId), 0);
    vm.stopPrank();
    assertEq(boldToken.balanceOf(A), boldBalanceBefore - ((((11e18 * price) / DECIMAL_PRECISION) * DECIMAL_PRECISION) / (DECIMAL_PRECISION + URGENT_REDEMPTION_BONUS)), "Bold balance mismatch");
    assertEq(contractsArray[0].collToken.balanceOf(A), collBalanceBefore + 11e18, "Coll balance mismatch");
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

### assertLt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 12044:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLt(uint256,uint256,string)`

```solidity
function assertLt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertLt(left, right, err);
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

- **IPriceFeedTestnet::setPrice(uint256)**
- **IBorrowerOperationsTester::shutdown()**
- **ITroveManagerTester::getCurrentICR(uint256,uint256)**
- **IBoldToken::balanceOf(address)**
- **IERC20Metadata::balanceOf(address)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **Vm::startPrank(address)**
- **ITroveManagerTester::urgentRedemption(uint256,uint256[],uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **contractsArray** (`struct TestDeployer.LiquityContractsDev[]`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ShutdownTest.testCanUrgentReedemFullyBelow100() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: ShutdownTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [0, A, 0, 11e18, 9000e18, 5e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 2)
  │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 3)
  │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ShutdownTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 4)
  │   💬 Args: [0, A, 1, 11e18, 10000e18, 5e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 5)
  │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 6)
  │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ShutdownTest.openMulticollateralTroveNoHints100pctWithIndex(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 7)
  │   💬 Args: [0, A, 2, 11e18, 11000e18, 5e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.calcUpfrontFee(uint256,uint256) (NodeID: 8)
  │     💬 Args: [troveChange.debtIncrease, avgInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.calcInterest(uint256,uint256) (NodeID: 9)
  │       💬 Args: [debt * avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 10)
  │   💬 Args: [icr, 1e18, "Trove CR should be below 100%"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.uintToArray(uint256) (NodeID: 11)
  │   💬 Args: [troveId]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 12)
  │   💬 Args: [boldToken.balanceOf(A), boldBalanceBefore - ((((11e18 * price) / DECIMAL_PRECISION) * DECIMAL_PRECISION) / (DECIMAL_PRECISION + URGENT_REDEMPTION_BONUS)), "Bold balance mismatch"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 13)
      💬 Args: [contractsArray[0].collToken.balanceOf(A), collBalanceBefore + 11e18, "Coll balance mismatch"]
      👁️  Def: internal
```
