# Function: testAdjustTroveInterestRateSetsCorrectNewRate()

**Contract**: [test/interestRateBasic.t.sol/contract_InterestRateBasic.md]

## Metadata

- **Contract**: InterestRateBasic
- **Signature**: `testAdjustTroveInterestRateSetsCorrectNewRate()`
- **Visibility**: public
- **Source Range**: 4849:1063:307

## Implementation

```solidity
function testAdjustTroveInterestRateSetsCorrectNewRate() public {
    priceFeed.setPrice(2000e18);
    uint256 ATroveId = openTroveNoHints100pct(A, 2 ether, 2000e18, 5e17);
    uint256 BTroveId = openTroveNoHints100pct(B, 2 ether, 2000e18, 5e17);
    uint256 CTroveId = openTroveNoHints100pct(C, 2 ether, 2000e18, 5e17);
    assertEq(troveManager.getTroveAnnualInterestRate(ATroveId), 5e17);
    assertEq(troveManager.getTroveAnnualInterestRate(BTroveId), 5e17);
    assertEq(troveManager.getTroveAnnualInterestRate(CTroveId), 5e17);
    changeInterestRateNoHints(A, ATroveId, MIN_ANNUAL_INTEREST_RATE);
    assertEq(troveManager.getTroveAnnualInterestRate(ATroveId), MIN_ANNUAL_INTEREST_RATE);
    changeInterestRateNoHints(B, BTroveId, 6e17);
    assertEq(troveManager.getTroveAnnualInterestRate(BTroveId), 6e17);
    changeInterestRateNoHints(C, CTroveId, 1e18);
    assertEq(troveManager.getTroveAnnualInterestRate(CTroveId), 1e18);
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
- **ITroveManagerTester::getTroveAnnualInterestRate(uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestRateBasic.testAdjustTroveInterestRateSetsCorrectNewRate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [A, 2 ether, 2000e18, 5e17]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 4)
  │   💬 Args: [B, 2 ether, 2000e18, 5e17]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 5)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 6)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 7)
  │   💬 Args: [C, 2 ether, 2000e18, 5e17]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 8)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 9)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 10)
  │   💬 Args: [troveManager.getTroveAnnualInterestRate(ATroveId), 5e17]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 11)
  │   💬 Args: [troveManager.getTroveAnnualInterestRate(BTroveId), 5e17]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 12)
  │   💬 Args: [troveManager.getTroveAnnualInterestRate(CTroveId), 5e17]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.changeInterestRateNoHints(address,uint256,uint256) (NodeID: 13)
  │   💬 Args: [A, ATroveId, MIN_ANNUAL_INTEREST_RATE]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictAdjustInterestRateUpfrontFee(uint256,uint256) (NodeID: 14)
  │     💬 Args: [_troveId, _newAnnualInterestRate]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 15)
  │   💬 Args: [troveManager.getTroveAnnualInterestRate(ATroveId), MIN_ANNUAL_INTEREST_RATE]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.changeInterestRateNoHints(address,uint256,uint256) (NodeID: 16)
  │   💬 Args: [B, BTroveId, 6e17]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictAdjustInterestRateUpfrontFee(uint256,uint256) (NodeID: 17)
  │     💬 Args: [_troveId, _newAnnualInterestRate]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 18)
  │   💬 Args: [troveManager.getTroveAnnualInterestRate(BTroveId), 6e17]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.changeInterestRateNoHints(address,uint256,uint256) (NodeID: 19)
  │   💬 Args: [C, CTroveId, 1e18]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictAdjustInterestRateUpfrontFee(uint256,uint256) (NodeID: 20)
  │     💬 Args: [_troveId, _newAnnualInterestRate]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 21)
      💬 Args: [troveManager.getTroveAnnualInterestRate(CTroveId), 1e18]
      👁️  Def: internal
```
