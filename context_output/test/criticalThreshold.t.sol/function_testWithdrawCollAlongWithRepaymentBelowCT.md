# Function: testWithdrawCollAlongWithRepaymentBelowCT()

**Contract**: [test/criticalThreshold.t.sol/contract_CriticalThresholdTest.md]

## Metadata

- **Contract**: CriticalThresholdTest
- **Signature**: `testWithdrawCollAlongWithRepaymentBelowCT()`
- **Visibility**: public
- **Source Range**: 2951:339:301

## Implementation

```solidity
function testWithdrawCollAlongWithRepaymentBelowCT() public {
    (uint256 ATroveId, , ) = setUpBelowCT();
    uint256 initialColl = troveManager.getTroveEntireColl(ATroveId);
    adjustTrove100pct(A, ATroveId, 1e18, 1499e18, false, false);
    assertEq(troveManager.getTroveEntireColl(ATroveId), initialColl - 1e18);
}
```

## Related Implementations

### setUpBelowCT()

- **Kind**: internal
- **Source**: 156:543:301
- **Link**: `test/criticalThreshold.t.sol:CriticalThresholdTest:setUpBelowCT()`

```solidity
function setUpBelowCT() internal returns (uint256, uint256, uint256) {
    priceFeed.setPrice(2000e18);
    uint256 ATroveId = openTroveNoHints100pct(A, 100 ether, 90000e18, 1e17);
    uint256 BTroveId = openTroveNoHints100pct(B, 100 ether, 110000e18, 1e17);
    uint256 newPrice = 1499e18;
    priceFeed.setPrice(newPrice);
    assert(troveManager.checkBelowCriticalThreshold(newPrice));
    return (ATroveId, BTroveId, newPrice);
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

### adjustTrove100pct(address,uint256,uint256,uint256,bool,bool)

- **Kind**: internal
- **Source**: 9187:605:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:adjustTrove100pct(address,uint256,uint256,uint256,bool,bool)`

```solidity
function adjustTrove100pct(address _account, uint256 _troveId, uint256 _collChange, uint256 _boldChange, bool _isCollIncrease, bool _isDebtIncrease) public {
    vm.startPrank(_account);
    borrowerOperations.adjustTrove(_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, predictAdjustTroveUpfrontFee(_troveId, _isDebtIncrease ? _boldChange : 0));
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

- **ITroveManagerTester::getTroveEntireColl(uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CriticalThresholdTest.testWithdrawCollAlongWithRepaymentBelowCT() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: CriticalThresholdTest.setUpBelowCT() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 2)
  │ │   💬 Args: [A, 100 ether, 90000e18, 1e17]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 3)
  │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │     👁️  Def: public
  │ │   └─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 4)
  │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 5)
  │     💬 Args: [B, 100 ether, 110000e18, 1e17]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 6)
  │       💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │       👁️  Def: public
  │     └─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 7)
  │         💬 Args: [_boldAmount, _annualInterestRate]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.adjustTrove100pct(address,uint256,uint256,uint256,bool,bool) (NodeID: 8)
  │   💬 Args: [A, ATroveId, 1e18, 1499e18, false, false]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictAdjustTroveUpfrontFee(uint256,uint256) (NodeID: 9)
  │     💬 Args: [_troveId, _isDebtIncrease ? _boldChange : 0]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 10)
      💬 Args: [troveManager.getTroveEntireColl(ATroveId), initialColl - 1e18]
      👁️  Def: internal
```
