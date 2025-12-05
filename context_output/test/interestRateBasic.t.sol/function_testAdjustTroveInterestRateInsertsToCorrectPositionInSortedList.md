# Function: testAdjustTroveInterestRateInsertsToCorrectPositionInSortedList()

**Contract**: [test/interestRateBasic.t.sol/contract_InterestRateBasic.md]

## Metadata

- **Contract**: InterestRateBasic
- **Signature**: `testAdjustTroveInterestRateInsertsToCorrectPositionInSortedList()`
- **Visibility**: public
- **Source Range**: 9310:2082:307

## Implementation

```solidity
function testAdjustTroveInterestRateInsertsToCorrectPositionInSortedList() public {
    priceFeed.setPrice(2000e18);
    uint256 ATroveId = openTroveNoHints100pct(A, 2 ether, 2000e18, 1e17);
    uint256 BTroveId = openTroveNoHints100pct(B, 2 ether, 2000e18, 2e17);
    uint256 CTroveId = openTroveNoHints100pct(C, 2 ether, 2000e18, 3e17);
    uint256 DTroveId = openTroveNoHints100pct(D, 2 ether, 2000e18, 4e17);
    uint256 ETroveId = openTroveNoHints100pct(E, 2 ether, 2000e18, 5e17);
    assertEq(sortedTroves.getNext(ATroveId), 0);
    assertEq(sortedTroves.getPrev(ATroveId), BTroveId);
    assertEq(sortedTroves.getNext(BTroveId), ATroveId);
    assertEq(sortedTroves.getPrev(BTroveId), CTroveId);
    assertEq(sortedTroves.getNext(CTroveId), BTroveId);
    assertEq(sortedTroves.getPrev(CTroveId), DTroveId);
    assertEq(sortedTroves.getNext(DTroveId), CTroveId);
    assertEq(sortedTroves.getPrev(DTroveId), ETroveId);
    assertEq(sortedTroves.getNext(ETroveId), DTroveId);
    assertEq(sortedTroves.getPrev(ETroveId), 0);
    changeInterestRateNoHints(C, CTroveId, MIN_ANNUAL_INTEREST_RATE);
    assertEq(sortedTroves.getNext(CTroveId), 0);
    assertEq(sortedTroves.getPrev(CTroveId), ATroveId);
    changeInterestRateNoHints(D, DTroveId, 7e17);
    assertEq(sortedTroves.getNext(DTroveId), ETroveId);
    assertEq(sortedTroves.getPrev(DTroveId), 0);
    changeInterestRateNoHints(A, ATroveId, 6e17);
    assertEq(sortedTroves.getNext(ATroveId), ETroveId);
    assertEq(sortedTroves.getPrev(ATroveId), DTroveId);
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

### changeInterestRateNoHints(address,uint256,uint256)

- **Kind**: internal
- **Source**: 10473:420:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:changeInterestRateNoHints(address,uint256,uint256)`

```solidity
function changeInterestRateNoHints(address _account, uint256 _troveId, uint256 _newAnnualInterestRate) public returns (uint256 upfrontFee) {
    upfrontFee = predictAdjustInterestRateUpfrontFee(_troveId, _newAnnualInterestRate);
    vm.startPrank(_account);
    borrowerOperations.adjustTroveInterestRate(_troveId, _newAnnualInterestRate, 0, 0, upfrontFee);
    vm.stopPrank();
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
┌─ [0] ⚙️ FUNCTION: InterestRateBasic.testAdjustTroveInterestRateInsertsToCorrectPositionInSortedList() (NodeID: 0)
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
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 18)
  │   💬 Args: [sortedTroves.getNext(BTroveId), ATroveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 19)
  │   💬 Args: [sortedTroves.getPrev(BTroveId), CTroveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 20)
  │   💬 Args: [sortedTroves.getNext(CTroveId), BTroveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 21)
  │   💬 Args: [sortedTroves.getPrev(CTroveId), DTroveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 22)
  │   💬 Args: [sortedTroves.getNext(DTroveId), CTroveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 23)
  │   💬 Args: [sortedTroves.getPrev(DTroveId), ETroveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 24)
  │   💬 Args: [sortedTroves.getNext(ETroveId), DTroveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 25)
  │   💬 Args: [sortedTroves.getPrev(ETroveId), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.changeInterestRateNoHints(address,uint256,uint256) (NodeID: 26)
  │   💬 Args: [C, CTroveId, MIN_ANNUAL_INTEREST_RATE]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictAdjustInterestRateUpfrontFee(uint256,uint256) (NodeID: 27)
  │     💬 Args: [_troveId, _newAnnualInterestRate]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 28)
  │   💬 Args: [sortedTroves.getNext(CTroveId), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 29)
  │   💬 Args: [sortedTroves.getPrev(CTroveId), ATroveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.changeInterestRateNoHints(address,uint256,uint256) (NodeID: 30)
  │   💬 Args: [D, DTroveId, 7e17]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictAdjustInterestRateUpfrontFee(uint256,uint256) (NodeID: 31)
  │     💬 Args: [_troveId, _newAnnualInterestRate]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 32)
  │   💬 Args: [sortedTroves.getNext(DTroveId), ETroveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 33)
  │   💬 Args: [sortedTroves.getPrev(DTroveId), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.changeInterestRateNoHints(address,uint256,uint256) (NodeID: 34)
  │   💬 Args: [A, ATroveId, 6e17]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictAdjustInterestRateUpfrontFee(uint256,uint256) (NodeID: 35)
  │     💬 Args: [_troveId, _newAnnualInterestRate]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 36)
  │   💬 Args: [sortedTroves.getNext(ATroveId), ETroveId]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 37)
      💬 Args: [sortedTroves.getPrev(ATroveId), DTroveId]
      👁️  Def: internal
```
