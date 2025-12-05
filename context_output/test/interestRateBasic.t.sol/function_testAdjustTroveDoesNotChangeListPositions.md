# Function: testAdjustTroveDoesNotChangeListPositions()

**Contract**: [test/interestRateBasic.t.sol/contract_InterestRateBasic.md]

## Metadata

- **Contract**: InterestRateBasic
- **Signature**: `testAdjustTroveDoesNotChangeListPositions()`
- **Visibility**: public
- **Source Range**: 11398:1820:307

## Implementation

```solidity
function testAdjustTroveDoesNotChangeListPositions() public {
    priceFeed.setPrice(2000e18);
    uint256 ATroveId = openTroveNoHints100pct(A, 2 ether, 2000e18, 1e17);
    uint256 BTroveId = openTroveNoHints100pct(B, 2 ether, 2000e18, 2e17);
    uint256 CTroveId = openTroveNoHints100pct(C, 2 ether, 2000e18, 3e17);
    uint256 DTroveId = openTroveNoHints100pct(D, 2 ether, 2000e18, 4e17);
    uint256 ETroveId = openTroveNoHints100pct(E, 2 ether, 2000e18, 5e17);
    assertEq(sortedTroves.getNext(ATroveId), 0);
    assertEq(sortedTroves.getPrev(ATroveId), BTroveId);
    adjustTrove100pct(A, ATroveId, 10 ether, 5000e18, true, true);
    assertEq(sortedTroves.getNext(ATroveId), 0);
    assertEq(sortedTroves.getPrev(ATroveId), BTroveId);
    assertEq(sortedTroves.getNext(CTroveId), BTroveId);
    assertEq(sortedTroves.getPrev(CTroveId), DTroveId);
    adjustTrove100pct(C, CTroveId, 10 ether, 5000e18, true, true);
    assertEq(sortedTroves.getNext(CTroveId), BTroveId);
    assertEq(sortedTroves.getPrev(CTroveId), DTroveId);
    assertEq(sortedTroves.getNext(ETroveId), DTroveId);
    assertEq(sortedTroves.getPrev(ETroveId), 0);
    adjustTrove100pct(E, ETroveId, 10 ether, 5000e18, true, true);
    assertEq(sortedTroves.getNext(ETroveId), DTroveId);
    assertEq(sortedTroves.getPrev(ETroveId), 0);
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

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
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

## External Calls

- **IPriceFeedTestnet::setPrice(uint256)**
- **ISortedTroves::getNext(uint256)**
- **ISortedTroves::getPrev(uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestRateBasic.testAdjustTroveDoesNotChangeListPositions() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [A, 2 ether, 2000e18, 1e17]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 4)
  │   💬 Args: [B, 2 ether, 2000e18, 2e17]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 5)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 6)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 7)
  │   💬 Args: [C, 2 ether, 2000e18, 3e17]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 8)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 9)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 10)
  │   💬 Args: [D, 2 ether, 2000e18, 4e17]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 11)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 12)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 13)
  │   💬 Args: [E, 2 ether, 2000e18, 5e17]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 14)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 15)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 16)
  │   💬 Args: [sortedTroves.getNext(ATroveId), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 17)
  │   💬 Args: [sortedTroves.getPrev(ATroveId), BTroveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.adjustTrove100pct(address,uint256,uint256,uint256,bool,bool) (NodeID: 18)
  │   💬 Args: [A, ATroveId, 10 ether, 5000e18, true, true]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictAdjustTroveUpfrontFee(uint256,uint256) (NodeID: 19)
  │     💬 Args: [_troveId, _isDebtIncrease ? _boldChange : 0]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 20)
  │   💬 Args: [sortedTroves.getNext(ATroveId), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 21)
  │   💬 Args: [sortedTroves.getPrev(ATroveId), BTroveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 22)
  │   💬 Args: [sortedTroves.getNext(CTroveId), BTroveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 23)
  │   💬 Args: [sortedTroves.getPrev(CTroveId), DTroveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.adjustTrove100pct(address,uint256,uint256,uint256,bool,bool) (NodeID: 24)
  │   💬 Args: [C, CTroveId, 10 ether, 5000e18, true, true]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictAdjustTroveUpfrontFee(uint256,uint256) (NodeID: 25)
  │     💬 Args: [_troveId, _isDebtIncrease ? _boldChange : 0]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 26)
  │   💬 Args: [sortedTroves.getNext(CTroveId), BTroveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 27)
  │   💬 Args: [sortedTroves.getPrev(CTroveId), DTroveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 28)
  │   💬 Args: [sortedTroves.getNext(ETroveId), DTroveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 29)
  │   💬 Args: [sortedTroves.getPrev(ETroveId), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.adjustTrove100pct(address,uint256,uint256,uint256,bool,bool) (NodeID: 30)
  │   💬 Args: [E, ETroveId, 10 ether, 5000e18, true, true]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictAdjustTroveUpfrontFee(uint256,uint256) (NodeID: 31)
  │     💬 Args: [_troveId, _isDebtIncrease ? _boldChange : 0]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 32)
  │   💬 Args: [sortedTroves.getNext(ETroveId), DTroveId]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 33)
      💬 Args: [sortedTroves.getPrev(ETroveId), 0]
      👁️  Def: internal
```
