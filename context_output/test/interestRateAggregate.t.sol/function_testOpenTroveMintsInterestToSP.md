# Function: testOpenTroveMintsInterestToSP()

**Contract**: [test/interestRateAggregate.t.sol/contract_InterestRateAggregate.md]

## Metadata

- **Contract**: InterestRateAggregate
- **Signature**: `testOpenTroveMintsInterestToSP()`
- **Visibility**: public
- **Source Range**: 8470:1523:306

## Implementation

```solidity
function testOpenTroveMintsInterestToSP() public {
    priceFeed.setPrice(2000e18);
    assertEq(boldToken.balanceOf(address(stabilityPool)), 0);
    openTroveHelper(A, 0, 5 ether, 3000e18, 25e16);
    vm.warp(block.timestamp + 1 days);
    uint256 pendingAggInterest_1 = activePool.calcPendingAggInterest();
    assertGt(pendingAggInterest_1, 0);
    uint256 boldBalSP_0 = boldToken.balanceOf(address(stabilityPool));
    (, uint256 upfrontFee_1) = openTroveHelper(B, 0, 2 ether, 2000e18, 25e16);
    uint256 expectedSPYield_1 = _getSPYield(pendingAggInterest_1 + upfrontFee_1);
    uint256 boldBalSP_1 = boldToken.balanceOf(address(stabilityPool));
    assertEq(boldBalSP_1 - boldBalSP_0, expectedSPYield_1);
    vm.warp(block.timestamp + 1 days);
    uint256 pendingAggInterest_2 = activePool.calcPendingAggInterest();
    assertGt(pendingAggInterest_2, 0);
    (, uint256 upfrontFee_2) = openTroveHelper(C, 0, 2 ether, 2000e18, 25e16);
    uint256 expectedSPYield_2 = _getSPYield(pendingAggInterest_2 + upfrontFee_2);
    uint256 boldBalSP_2 = boldToken.balanceOf(address(stabilityPool));
    assertEq(boldBalSP_2 - boldBalSP_1, expectedSPYield_2);
}
```

## Related Implementations

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
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

## External Calls

- **IPriceFeedTestnet::setPrice(uint256)**
- **IBoldToken::balanceOf(address)**
- **Vm::warp(uint256)**
- **IActivePool::calcPendingAggInterest()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestRateAggregate.testOpenTroveMintsInterestToSP() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [boldToken.balanceOf(address(stabilityPool)), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 2)
  │   💬 Args: [A, 0, 5 ether, 3000e18, 25e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
  │     💬 Args: [_boldAmount, _annualInterestRate]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 4)
  │   💬 Args: [pendingAggInterest_1, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 5)
  │   💬 Args: [B, 0, 2 ether, 2000e18, 25e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 6)
  │     💬 Args: [_boldAmount, _annualInterestRate]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: DevTestSetup._getSPYield(uint256) (NodeID: 7)
  │   💬 Args: [pendingAggInterest_1 + upfrontFee_1]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 8)
  │ │   💬 Args: [spYield, 0]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 9)
  │     💬 Args: [spYield, _aggInterest]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 10)
  │   💬 Args: [boldBalSP_1 - boldBalSP_0, expectedSPYield_1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 11)
  │   💬 Args: [pendingAggInterest_2, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 12)
  │   💬 Args: [C, 0, 2 ether, 2000e18, 25e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 13)
  │     💬 Args: [_boldAmount, _annualInterestRate]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: DevTestSetup._getSPYield(uint256) (NodeID: 14)
  │   💬 Args: [pendingAggInterest_2 + upfrontFee_2]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 15)
  │ │   💬 Args: [spYield, 0]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 16)
  │     💬 Args: [spYield, _aggInterest]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 17)
      💬 Args: [boldBalSP_2 - boldBalSP_1, expectedSPYield_2]
      👁️  Def: internal
```
