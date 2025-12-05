# Function: testAdjustInterestRateChargesUpfrontFeeWhenPremature()

**Contract**: [test/borrowerOperations.t.sol/contract_BorrowerOperationsTest.md]

## Metadata

- **Contract**: BorrowerOperationsTest
- **Signature**: `testAdjustInterestRateChargesUpfrontFeeWhenPremature()`
- **Visibility**: public
- **Source Range**: 5108:2755:299

## Implementation

```solidity
function testAdjustInterestRateChargesUpfrontFeeWhenPremature() public {
    uint256 troveId = openTroveNoHints100pct(A, 100 ether, 10_000 ether, 0.05 ether);
    uint56[4] memory interestRate = [0.01 ether, 0.02 ether, 0.03 ether, 0.04 ether];
    vm.warp(block.timestamp + (INTEREST_RATE_ADJ_COOLDOWN / 2));
    uint256 upfrontFee = predictAdjustInterestRateUpfrontFee(troveId, interestRate[1]);
    assertGt(upfrontFee, 0);
    uint256 troveDebtBefore = troveManager.getTroveEntireDebt(troveId);
    uint256 activePoolDebtBefore = activePool.getBoldDebt();
    vm.prank(A);
    borrowerOperations.adjustTroveInterestRate(troveId, interestRate[1], 0, 0, upfrontFee);
    uint256 troveDebtAfter = troveManager.getTroveEntireDebt(troveId);
    uint256 activePoolDebtAfter = activePool.getBoldDebt();
    assertEqDecimal(troveDebtAfter - troveDebtBefore, upfrontFee, 18, "Wrong Trove debt increase 1");
    assertEqDecimal(activePoolDebtAfter - activePoolDebtBefore, upfrontFee, 18, "Wrong AP debt increase 1");
    vm.warp(block.timestamp + ((INTEREST_RATE_ADJ_COOLDOWN * 3) / 4));
    upfrontFee = predictAdjustInterestRateUpfrontFee(troveId, interestRate[2]);
    assertGt(upfrontFee, 0);
    troveDebtBefore = troveManager.getTroveEntireDebt(troveId);
    activePoolDebtBefore = activePool.getBoldDebt();
    vm.prank(A);
    borrowerOperations.adjustTroveInterestRate(troveId, interestRate[2], 0, 0, upfrontFee);
    troveDebtAfter = troveManager.getTroveEntireDebt(troveId);
    activePoolDebtAfter = activePool.getBoldDebt();
    assertEqDecimal(troveDebtAfter - troveDebtBefore, upfrontFee, 18, "Wrong Trove debt increase 2");
    assertEqDecimal(activePoolDebtAfter - activePoolDebtBefore, upfrontFee, 18, "Wrong AP debt increase 2");
    vm.warp(block.timestamp + INTEREST_RATE_ADJ_COOLDOWN);
    troveDebtBefore = troveManager.getTroveEntireDebt(troveId);
    activePoolDebtBefore = activePool.getBoldDebt();
    vm.prank(A);
    borrowerOperations.adjustTroveInterestRate(troveId, interestRate[3], 0, 0, 0);
    troveDebtAfter = troveManager.getTroveEntireDebt(troveId);
    activePoolDebtAfter = activePool.getBoldDebt();
    assertEqDecimal(troveDebtAfter - troveDebtBefore, 0, 18, "Wrong Trove debt increase 3");
    assertEqDecimal(activePoolDebtAfter - activePoolDebtBefore, 0, 18, "Wrong AP debt increase 3");
}
```

## Related Implementations

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

### predictAdjustInterestRateUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 3761:247:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:predictAdjustInterestRateUpfrontFee(uint256,uint256)`

```solidity
function predictAdjustInterestRateUpfrontFee(uint256 troveId, uint256 newInterestRate) internal view returns (uint256) {
    return hintHelpers.predictAdjustInterestRateUpfrontFee(0, troveId, newInterestRate);
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

### assertEqDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 2684:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEqDecimal(uint256,uint256,uint256,string)`

```solidity
function assertEqDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertEqDecimal(left, right, decimals, err);
}
```

## External Calls

- **Vm::warp(uint256)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **IActivePool::getBoldDebt()**
- **Vm::prank(address)**
- **IBorrowerOperationsTester::adjustTroveInterestRate(uint256,uint256,uint256,uint256,uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperationsTest.testAdjustInterestRateChargesUpfrontFeeWhenPremature() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [A, 100 ether, 10_000 ether, 0.05 ether]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.predictAdjustInterestRateUpfrontFee(uint256,uint256) (NodeID: 4)
  │   💬 Args: [troveId, interestRate[1]]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 5)
  │   💬 Args: [upfrontFee, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 6)
  │   💬 Args: [troveDebtAfter - troveDebtBefore, upfrontFee, 18, "Wrong Trove debt increase 1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [activePoolDebtAfter - activePoolDebtBefore, upfrontFee, 18, "Wrong AP debt increase 1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.predictAdjustInterestRateUpfrontFee(uint256,uint256) (NodeID: 8)
  │   💬 Args: [troveId, interestRate[2]]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 9)
  │   💬 Args: [upfrontFee, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 10)
  │   💬 Args: [troveDebtAfter - troveDebtBefore, upfrontFee, 18, "Wrong Trove debt increase 2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 11)
  │   💬 Args: [activePoolDebtAfter - activePoolDebtBefore, upfrontFee, 18, "Wrong AP debt increase 2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 12)
  │   💬 Args: [troveDebtAfter - troveDebtBefore, 0, 18, "Wrong Trove debt increase 3"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 13)
      💬 Args: [activePoolDebtAfter - activePoolDebtBefore, 0, 18, "Wrong AP debt increase 3"]
      👁️  Def: internal
```
