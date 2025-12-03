# Function: testAdjustTrove()

**Contract**: [test/basicOps.t.sol/contract_BasicOps.md]

## Metadata

- **Contract**: BasicOps
- **Signature**: `testAdjustTrove()`
- **Visibility**: public
- **Source Range**: 2363:800:297

## Implementation

```solidity
function testAdjustTrove() public {
    priceFeed.setPrice(2000e18);
    vm.startPrank(A);
    uint256 A_Id = borrowerOperations.openTrove(A, 0, 2e18, 2000e18, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    uint256 debt_1 = troveManager.getTroveDebt(A_Id);
    assertGt(debt_1, 0);
    uint256 coll_1 = troveManager.getTroveColl(A_Id);
    assertGt(coll_1, 0);
    adjustTrove100pct(A, A_Id, 1e18, 500e18, true, true);
    uint256 debt_2 = troveManager.getTroveDebt(A_Id);
    assertGt(debt_2, debt_1);
    uint256 coll_2 = troveManager.getTroveColl(A_Id);
    assertGt(coll_2, coll_1);
}
```

## Related Implementations

### assertGt(uint256,uint256)

- **Kind**: internal
- **Source**: 13112:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256)`

```solidity
function assertGt(uint256 left, uint256 right) virtual internal pure {
    vm.assertGt(left, right);
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
- **Vm::startPrank(address)**
- **IBorrowerOperationsTester::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**
- **ITroveManagerTester::getTroveDebt(uint256)**
- **ITroveManagerTester::getTroveColl(uint256)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BasicOps.testAdjustTrove() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 1)
  │   💬 Args: [debt_1, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 2)
  │   💬 Args: [coll_1, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.adjustTrove100pct(address,uint256,uint256,uint256,bool,bool) (NodeID: 3)
  │   💬 Args: [A, A_Id, 1e18, 500e18, true, true]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictAdjustTroveUpfrontFee(uint256,uint256) (NodeID: 4)
  │     💬 Args: [_troveId, _isDebtIncrease ? _boldChange : 0]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 5)
  │   💬 Args: [debt_2, debt_1]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 6)
      💬 Args: [coll_2, coll_1]
      👁️  Def: internal
```
