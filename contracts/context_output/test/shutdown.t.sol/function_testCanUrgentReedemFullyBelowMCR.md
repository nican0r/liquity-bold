# Function: testCanUrgentReedemFullyBelowMCR()

**Contract**: [test/shutdown.t.sol/contract_ShutdownTest.md]

## Metadata

- **Contract**: ShutdownTest
- **Signature**: `testCanUrgentReedemFullyBelowMCR()`
- **Visibility**: external
- **Source Range**: 20527:1606:333

## Implementation

```solidity
function testCanUrgentReedemFullyBelowMCR() external {
    openMulticollateralTroveNoHints100pctWithIndex(0, A, 0, 11e18, 9000e18, 5e16);
    uint256 troveId = openMulticollateralTroveNoHints100pctWithIndex(0, A, 1, 11e18, 10000e18, 5e16);
    openMulticollateralTroveNoHints100pctWithIndex(0, A, 2, 11e18, 11000e18, 5e16);
    uint256 price = 1000e18;
    contractsArray[0].priceFeed.setPrice(price);
    contractsArray[0].borrowerOperations.shutdown();
    uint256 icr = troveManager.getCurrentICR(troveId, price);
    assertGt(icr, 1e18, "Trove CR should be above 100%");
    assertLt(icr, MCR, "Trove CR should be below MCR");
    uint256 boldBalanceBefore = boldToken.balanceOf(A);
    uint256 collBalanceBefore = contractsArray[0].collToken.balanceOf(A);
    uint256 redemptionAmount = troveManager.getTroveEntireDebt(troveId);
    vm.startPrank(A);
    troveManager.urgentRedemption(redemptionAmount, uintToArray(troveId), 0);
    vm.stopPrank();
    assertEq(boldToken.balanceOf(A), boldBalanceBefore - redemptionAmount, "Bold balance mismatch");
    assertApproximatelyEqual(contractsArray[0].collToken.balanceOf(A), collBalanceBefore + ((((redemptionAmount * DECIMAL_PRECISION) / price) * (DECIMAL_PRECISION + URGENT_REDEMPTION_BONUS)) / DECIMAL_PRECISION), 1, "Coll balance mismatch");
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

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 13228:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertGt(left, right, err);
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

### assertApproximatelyEqual(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 20170:170:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:assertApproximatelyEqual(uint256,uint256,uint256,string)`

```solidity
function assertApproximatelyEqual(uint256 _x, uint256 _y, uint256 _margin, string memory _reason) public pure {
    assertApproxEqAbs(_x, _y, _margin, _reason);
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
┌─ [0] ⚙️ FUNCTION: ShutdownTest.testCanUrgentReedemFullyBelowMCR() (NodeID: 0)
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
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 10)
  │   💬 Args: [icr, 1e18, "Trove CR should be above 100%"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 11)
  │   💬 Args: [icr, MCR, "Trove CR should be below MCR"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.uintToArray(uint256) (NodeID: 12)
  │   💬 Args: [troveId]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 13)
  │   💬 Args: [boldToken.balanceOf(A), boldBalanceBefore - redemptionAmount, "Bold balance mismatch"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256,string) (NodeID: 14)
      💬 Args: [contractsArray[0].collToken.balanceOf(A), collBalanceBefore + ((((redemptionAmount * DECIMAL_PRECISION) / price) * (DECIMAL_PRECISION + URGENT_REDEMPTION_BONUS)) / DECIMAL_PRECISION), 1, "Coll balance mismatch"]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 15)
        💬 Args: [_x, _y, _margin, _reason]
        👁️  Def: internal
```
