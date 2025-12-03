# Function: test_SimulateRedemption(uint256,struct RedemptionHelperTest.TroveParams[20],uint256[3],uint256[3],uint256,uint256)

**Contract**: [test/RedemptionHelper.t.sol/contract_RedemptionHelperTest.md]

## Metadata

- **Contract**: RedemptionHelperTest
- **Signature**: `test_SimulateRedemption(uint256,struct RedemptionHelperTest.TroveParams[20],uint256[3],uint256[3],uint256,uint256)`
- **Visibility**: external
- **Source Range**: 6687:2187:245

## Implementation

```solidity
function test_SimulateRedemption(uint256 delay, TroveParams[NUM_TROVES] memory troves, uint256[NUM_BRANCHES] memory spBold, uint256[NUM_BRANCHES] memory totalCollRatio, uint256 attemptedRedeemedBold, uint256 maxIterations) external {
    skip(_bound(delay, 0, 30 days));
    openTroves(A, troves);
    provideToSPs(A, spBold);
    setTotalCollRatio(totalCollRatio);
    attemptedRedeemedBold = _bound(attemptedRedeemedBold, 1, boldToken.balanceOf(A));
    maxIterations = _bound(maxIterations, 0, NUM_TROVES);
    (IRedemptionHelper.SimulationContext[] memory sim, ) = redemptionHelper.simulateRedemption(attemptedRedeemedBold, maxIterations);
    uint256 expectedRedeemedBold = 0;
    uint256 expectedMaxIterations = 0;
    for (uint256 i = 0; i < sim.length; ++i) {
        expectedRedeemedBold += sim[i].redeemedBold;
        expectedMaxIterations = Math.max(expectedMaxIterations, sim[i].iterations);
    }
    assertLeDecimal(expectedRedeemedBold, attemptedRedeemedBold, 18, "expectedRedeemedBold > attemptedRedeemedBold");
    if (maxIterations != 0) assertLe(expectedMaxIterations, maxIterations, "expectedMaxIterations > maxIterations");
    uint256 boldBalanceBefore = boldToken.balanceOf(A);
    vm.prank(A);
    collateralRegistry.redeemCollateral(attemptedRedeemedBold, expectedMaxIterations, 1 ether);
    uint256 actualRedeemedBold = boldBalanceBefore - boldToken.balanceOf(A);
    assertApproxEqAbsDecimal(actualRedeemedBold, expectedRedeemedBold, 2, 18, "actualRedeemedBold != expectedRedeemedBold");
}
```

## Related Implementations

### skip(uint256)

- **Kind**: internal
- **Source**: 24925:100:50
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:skip(uint256)`

```solidity
function skip(uint256 time) virtual internal {
    vm.warp(vm.getBlockTimestamp() + time);
}
```

### _bound(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 1646:1263:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_bound(uint256,uint256,uint256)`

```solidity
function _bound(uint256 x, uint256 min, uint256 max) virtual internal pure returns (uint256 result) {
    require(min <= max, "StdUtils bound(uint256,uint256,uint256): Max is less than min.");
    if ((x >= min) && (x <= max)) return x;
    uint256 size = (max - min) + 1;
    if ((x <= 3) && (size > x)) return min + x;
    if ((x >= (UINT256_MAX - 3)) && (size > (UINT256_MAX - x))) return max - (UINT256_MAX - x);
    if (x > max) {
        uint256 diff = x - max;
        uint256 rem = diff % size;
        if (rem == 0) return max;
        result = (min + rem) - 1;
    } else if (x < min) {
        uint256 diff = min - x;
        uint256 rem = diff % size;
        if (rem == 0) return min;
        result = (max - rem) + 1;
    }
}
```

### openTroves(address,struct RedemptionHelperTest.TroveParams[20])

- **Kind**: internal
- **Source**: 5184:514:245
- **Link**: `test/RedemptionHelper.t.sol:RedemptionHelperTest:openTroves(address,struct RedemptionHelperTest.TroveParams[20])`

```solidity
function openTroves(address owner, TroveParams[NUM_TROVES] memory trove) internal {
    for (uint256 i = 0; i < trove.length; ++i) {
        trove[i].branchIdx = _bound(trove[i].branchIdx, 0, branch.length - 1);
        trove[i].collRatio = _bound(trove[i].collRatio, params[trove[i].branchIdx].CCR, 3 ether);
        trove[i].debt = _bound(trove[i].debt, MIN_DEBT, 100 * MIN_DEBT);
        openTrove(trove[i].branchIdx, owner, i, trove[i].collRatio, trove[i].debt, 0.05 ether);
    }
}
```

### openTrove(uint256,address,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 4317:861:245
- **Link**: `test/RedemptionHelper.t.sol:RedemptionHelperTest:openTrove(uint256,address,uint256,uint256,uint256,uint256)`

```solidity
function openTrove(uint256 branchIdx, address owner, uint256 ownerIdx, uint256 collRatio, uint256 debt, uint256 interestRate) internal {
    (uint256 borrow, uint256 upfrontFee) = findAmountToBorrow(branchIdx, debt, interestRate);
    uint256 coll = Math.ceilDiv(debt * collRatio, branch[branchIdx].priceFeed.getPrice());
    vm.prank(owner);
    branch[branchIdx].borrowerOperations.openTrove({_owner: owner, _ownerIndex: ownerIdx, _ETHAmount: coll, _boldAmount: borrow, _upperHint: 0, _lowerHint: 0, _annualInterestRate: interestRate, _maxUpfrontFee: upfrontFee, _addManager: address(0), _removeManager: address(0), _receiver: address(0)});
}
```

### findAmountToBorrow(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 3444:867:245
- **Link**: `test/RedemptionHelper.t.sol:RedemptionHelperTest:findAmountToBorrow(uint256,uint256,uint256)`

```solidity
function findAmountToBorrow(uint256 branchIdx, uint256 targetDebt, uint256 interestRate) internal view returns (uint256 borrow, uint256 upfrontFee) {
    uint256 borrowRight = targetDebt;
    upfrontFee = hintHelpers.predictOpenTroveUpfrontFee(branchIdx, borrowRight, interestRate);
    uint256 borrowLeft = borrowRight - upfrontFee;
    for (uint256 i = 0; i < 256; ++i) {
        borrow = (borrowLeft + borrowRight) / 2;
        upfrontFee = hintHelpers.predictOpenTroveUpfrontFee(branchIdx, borrow, interestRate);
        uint256 actualDebt = borrow + upfrontFee;
        if (actualDebt == targetDebt) {
            break;
        } else if (actualDebt < targetDebt) {
            borrowLeft = borrow;
        } else {
            borrowRight = borrow;
        }
    }
}
```

### ceilDiv(uint256,uint256)

- **Kind**: internal
- **Source**: 1157:194:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:ceilDiv(uint256,uint256)`

```solidity
///  @dev Returns the ceiling of the division of two numbers.
///  This differs from standard division with `/` in that it rounds up instead
///  of rounding down.
function ceilDiv(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a == 0) ? 0 : (((a - 1) / b) + 1);
}
```

### provideToSPs(address,uint256[3])

- **Kind**: internal
- **Source**: 5887:289:245
- **Link**: `test/RedemptionHelper.t.sol:RedemptionHelperTest:provideToSPs(address,uint256[3])`

```solidity
function provideToSPs(address account, uint256[NUM_BRANCHES] memory bold) public {
    for (uint256 i = 0; i < bold.length; ++i) {
        bold[i] = _bound(bold[i], 0, boldToken.balanceOf(account) - 1);
        if (bold[i] > 0) provideToSP(i, account, bold[i]);
    }
}
```

### provideToSP(uint256,address,uint256)

- **Kind**: internal
- **Source**: 5704:177:245
- **Link**: `test/RedemptionHelper.t.sol:RedemptionHelperTest:provideToSP(uint256,address,uint256)`

```solidity
function provideToSP(uint256 branchIdx, address account, uint256 bold) public {
    vm.prank(account);
    branch[branchIdx].stabilityPool.provideToSP(bold, true);
}
```

### setTotalCollRatio(uint256[3])

- **Kind**: internal
- **Source**: 6182:499:245
- **Link**: `test/RedemptionHelper.t.sol:RedemptionHelperTest:setTotalCollRatio(uint256[3])`

```solidity
function setTotalCollRatio(uint256[NUM_BRANCHES] memory totalCollRatio) internal {
    for (uint256 i = 0; i < totalCollRatio.length; ++i) {
        totalCollRatio[i] = _bound(totalCollRatio[i], 0.9 ether, 3 ether);
        uint256 totalColl = branch[i].troveManager.getEntireBranchColl();
        uint256 totalDebt = branch[i].troveManager.getEntireBranchDebt();
        if (totalColl > 0) branch[i].priceFeed.setPrice((totalCollRatio[i] * totalDebt) / totalColl);
    }
}
```

### max(uint256,uint256)

- **Kind**: internal
- **Source**: 413:104:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:max(uint256,uint256)`

```solidity
///  @dev Returns the largest of two numbers.
function max(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a > b) ? a : b;
}
```

### assertLeDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 14710:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLeDecimal(uint256,uint256,uint256,string)`

```solidity
function assertLeDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertLeDecimal(left, right, decimals, err);
}
```

### assertLe(uint256,uint256,string)

- **Kind**: internal
- **Source**: 14412:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLe(uint256,uint256,string)`

```solidity
function assertLe(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertLe(left, right, err);
}
```

### assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 17272:268:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)`

```solidity
function assertApproxEqAbsDecimal(uint256 left, uint256 right, uint256 maxDelta, uint256 decimals, string memory err) virtual internal pure {
    vm.assertApproxEqAbsDecimal(left, right, maxDelta, decimals, err);
}
```

## External Calls

- **IBoldToken::balanceOf(address)**
- **IRedemptionHelper::simulateRedemption(uint256,uint256)**
- **Vm::prank(address)**
- **ICollateralRegistry::redeemCollateral(uint256,uint256,uint256)**

## State Variable Reads

- **redemptionHelper** (`contract IRedemptionHelper`) [src/Interfaces/IRedemptionHelper.sol/interface_IRedemptionHelper.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **UINT256_MAX** (`uint256`)
- **branch** (`struct TestDeployer.LiquityContractsDev[]`)
- **params** (`struct TestDeployer.TroveManagerParams[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RedemptionHelperTest.test_SimulateRedemption(uint256,struct RedemptionHelperTest.TroveParams[20],uint256[3],uint256[3],uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 1)
  │   💬 Args: [_bound(delay, 0, 30 days)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [delay, 0, 30 days]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: RedemptionHelperTest.openTroves(address,struct RedemptionHelperTest.TroveParams[20]) (NodeID: 3)
  │   💬 Args: [A, troves]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 4)
  │ │   💬 Args: [trove[i].branchIdx, 0, branch.length - 1]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 5)
  │ │   💬 Args: [trove[i].collRatio, params[trove[i].branchIdx].CCR, 3 ether]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 6)
  │ │   💬 Args: [trove[i].debt, MIN_DEBT, 100 * MIN_DEBT]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: RedemptionHelperTest.openTrove(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 7)
  │     💬 Args: [trove[i].branchIdx, owner, i, trove[i].collRatio, trove[i].debt, 0.05 ether]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: RedemptionHelperTest.findAmountToBorrow(uint256,uint256,uint256) (NodeID: 8)
  │   │   💬 Args: [branchIdx, debt, interestRate]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Math.ceilDiv(uint256,uint256) (NodeID: 9)
  │       💬 Args: [debt * collRatio, branch[branchIdx].priceFeed.getPrice()]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: RedemptionHelperTest.provideToSPs(address,uint256[3]) (NodeID: 10)
  │   💬 Args: [A, spBold]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 11)
  │ │   💬 Args: [bold[i], 0, boldToken.balanceOf(account) - 1]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: RedemptionHelperTest.provideToSP(uint256,address,uint256) (NodeID: 12)
  │     💬 Args: [i, account, bold[i]]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: RedemptionHelperTest.setTotalCollRatio(uint256[3]) (NodeID: 13)
  │   💬 Args: [totalCollRatio]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 14)
  │     💬 Args: [totalCollRatio[i], 0.9 ether, 3 ether]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 15)
  │   💬 Args: [attemptedRedeemedBold, 1, boldToken.balanceOf(A)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 16)
  │   💬 Args: [maxIterations, 0, NUM_TROVES]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.max(uint256,uint256) (NodeID: 17)
  │   💬 Args: [expectedMaxIterations, sim[i].iterations]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLeDecimal(uint256,uint256,uint256,string) (NodeID: 18)
  │   💬 Args: [expectedRedeemedBold, attemptedRedeemedBold, 18, "expectedRedeemedBold > attemptedRedeemedBold"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256,string) (NodeID: 19)
  │   💬 Args: [expectedMaxIterations, maxIterations, "expectedMaxIterations > maxIterations"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 20)
      💬 Args: [actualRedeemedBold, expectedRedeemedBold, 2, 18, "actualRedeemedBold != expectedRedeemedBold"]
      👁️  Def: internal
```
