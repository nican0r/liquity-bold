# Function: testApplyTroveInterestPermissionlessMintsPendingAggInterestToSP()

**Contract**: [test/interestRateAggregate.t.sol/contract_InterestRateAggregate.md]

## Metadata

- **Contract**: InterestRateAggregate
- **Signature**: `testApplyTroveInterestPermissionlessMintsPendingAggInterestToSP()`
- **Visibility**: public
- **Source Range**: 49886:1003:306

## Implementation

```solidity
function testApplyTroveInterestPermissionlessMintsPendingAggInterestToSP() public {
    uint256 troveDebtRequest = 2000e18;
    priceFeed.setPrice(2000e18);
    uint256 ATroveId = openTroveNoHints100pct(A, 3 ether, troveDebtRequest, 25e16);
    vm.warp((block.timestamp + STALE_TROVE_DURATION) + 1);
    assertTrue(troveManager.troveIsStale(ATroveId));
    uint256 balanceBefore = boldToken.balanceOf(address(stabilityPool));
    uint256 pendingAggInterest = activePool.calcPendingAggInterest();
    assertGt(pendingAggInterest, 0);
    uint256 expectedSPYield = _getSPYield(pendingAggInterest);
    applyPendingDebt(B, ATroveId);
    assertEq(boldToken.balanceOf(address(stabilityPool)) - balanceBefore, expectedSPYield);
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

### assertTrue(bool)

- **Kind**: internal
- **Source**: 1594:89:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool)`

```solidity
function assertTrue(bool data) virtual internal pure {
    vm.assertTrue(data);
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

### _getSPYield(uint256)

- **Kind**: internal
- **Source**: 14591:241:261
- **Link**: `test/TestContracts/DevTestSetup.sol:DevTestSetup:_getSPYield(uint256)`

```solidity
function _getSPYield(uint256 _aggInterest) internal pure returns (uint256) {
    uint256 spYield = (SP_YIELD_SPLIT * _aggInterest) / 1e18;
    assertGt(spYield, 0);
    assertLe(spYield, _aggInterest);
    return spYield;
}
```

### assertLe(uint256,uint256)

- **Kind**: internal
- **Source**: 14296:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLe(uint256,uint256)`

```solidity
function assertLe(uint256 left, uint256 right) virtual internal pure {
    vm.assertLe(left, right);
}
```

### applyPendingDebt(address,uint256)

- **Kind**: internal
- **Source**: 13227:182:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:applyPendingDebt(address,uint256)`

```solidity
function applyPendingDebt(address _from, uint256 _troveId) public {
    vm.startPrank(_from);
    borrowerOperations.applyPendingDebt(_troveId);
    vm.stopPrank();
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
- **ITroveManagerTester::troveIsStale(uint256)**
- **IBoldToken::balanceOf(address)**
- **IActivePool::calcPendingAggInterest()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestRateAggregate.testApplyTroveInterestPermissionlessMintsPendingAggInterestToSP() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [A, 3 ether, troveDebtRequest, 25e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 4)
  │   💬 Args: [troveManager.troveIsStale(ATroveId)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 5)
  │   💬 Args: [pendingAggInterest, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: DevTestSetup._getSPYield(uint256) (NodeID: 6)
  │   💬 Args: [pendingAggInterest]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 7)
  │ │   💬 Args: [spYield, 0]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 8)
  │     💬 Args: [spYield, _aggInterest]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.applyPendingDebt(address,uint256) (NodeID: 9)
  │   💬 Args: [B, ATroveId]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 10)
      💬 Args: [boldToken.balanceOf(address(stabilityPool)) - balanceBefore, expectedSPYield]
      👁️  Def: internal
```
