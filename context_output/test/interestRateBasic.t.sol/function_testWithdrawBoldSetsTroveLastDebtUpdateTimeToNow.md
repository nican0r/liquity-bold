# Function: testWithdrawBoldSetsTroveLastDebtUpdateTimeToNow()

**Contract**: [test/interestRateBasic.t.sol/contract_InterestRateBasic.md]

## Metadata

- **Contract**: InterestRateBasic
- **Signature**: `testWithdrawBoldSetsTroveLastDebtUpdateTimeToNow()`
- **Visibility**: public
- **Source Range**: 13253:634:307

## Implementation

```solidity
function testWithdrawBoldSetsTroveLastDebtUpdateTimeToNow() public {
    priceFeed.setPrice(2000e18);
    uint256 troveDebtRequest = 2000e18;
    uint256 interestRate = 25e16;
    uint256 boldWithdrawal = 500e18;
    uint256 ATroveId = openTroveNoHints100pct(A, 3 ether, troveDebtRequest, interestRate);
    vm.warp(block.timestamp + 1 days);
    assertLt(troveManager.getTroveLastDebtUpdateTime(ATroveId), block.timestamp);
    withdrawBold100pct(A, ATroveId, boldWithdrawal);
    assertEq(troveManager.getTroveLastDebtUpdateTime(ATroveId), block.timestamp);
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

### assertLt(uint256,uint256)

- **Kind**: internal
- **Source**: 11928:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLt(uint256,uint256)`

```solidity
function assertLt(uint256 left, uint256 right) virtual internal pure {
    vm.assertLt(left, right);
}
```

### withdrawBold100pct(address,uint256,uint256)

- **Kind**: internal
- **Source**: 12286:279:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:withdrawBold100pct(address,uint256,uint256)`

```solidity
function withdrawBold100pct(address _account, uint256 _troveId, uint256 _debtIncrease) public {
    vm.startPrank(_account);
    borrowerOperations.withdrawBold(_troveId, _debtIncrease, predictAdjustTroveUpfrontFee(_troveId, _debtIncrease));
    vm.stopPrank();
}
```

### predictAdjustTroveUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 4277:199:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:predictAdjustTroveUpfrontFee(uint256,uint256)`

```solidity
function predictAdjustTroveUpfrontFee(uint256 troveId, uint256 debtIncrease) internal view returns (uint256) {
    return hintHelpers.predictAdjustTroveUpfrontFee(0, troveId, debtIncrease);
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

## External Calls

- **IPriceFeedTestnet::setPrice(uint256)**
- **Vm::warp(uint256)**
- **ITroveManagerTester::getTroveLastDebtUpdateTime(uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestRateBasic.testWithdrawBoldSetsTroveLastDebtUpdateTimeToNow() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [A, 3 ether, troveDebtRequest, interestRate]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 4)
  │   💬 Args: [troveManager.getTroveLastDebtUpdateTime(ATroveId), block.timestamp]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.withdrawBold100pct(address,uint256,uint256) (NodeID: 5)
  │   💬 Args: [A, ATroveId, boldWithdrawal]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictAdjustTroveUpfrontFee(uint256,uint256) (NodeID: 6)
  │     💬 Args: [_troveId, _debtIncrease]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 7)
      💬 Args: [troveManager.getTroveLastDebtUpdateTime(ATroveId), block.timestamp]
      👁️  Def: internal
```
