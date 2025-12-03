# Function: test_TruncateRedemption(uint256,struct RedemptionHelperTest.TroveParams[20],uint256[3],uint256[3],uint256,uint256)

**Contract**: [test/RedemptionHelper.t.sol/contract_RedemptionHelperTest.md]

## Metadata

- **Contract**: RedemptionHelperTest
- **Signature**: `test_TruncateRedemption(uint256,struct RedemptionHelperTest.TroveParams[20],uint256[3],uint256[3],uint256,uint256)`
- **Visibility**: external
- **Source Range**: 8880:2059:245

## Implementation

```solidity
function test_TruncateRedemption(uint256 delay, TroveParams[NUM_TROVES] memory troves, uint256[NUM_BRANCHES] memory spBold, uint256[NUM_BRANCHES] memory totalCollRatio, uint256 attemptedRedeemedBold, uint256 maxIterations) external {
    skip(_bound(delay, 0, 30 days));
    openTroves(A, troves);
    provideToSPs(A, spBold);
    setTotalCollRatio(totalCollRatio);
    attemptedRedeemedBold = _bound(attemptedRedeemedBold, 1, boldToken.balanceOf(A));
    maxIterations = _bound(maxIterations, 0, NUM_TROVES);
    (uint256 truncatedRedeemedBold, uint256 feePct, IRedemptionHelper.Redeemed[] memory expectedRedeemed) = redemptionHelper.truncateRedemption(attemptedRedeemedBold, maxIterations);
    vm.assume(truncatedRedeemedBold > 0);
    assertLeDecimal(truncatedRedeemedBold, attemptedRedeemedBold, 18, "truncatedRedeemedBold > attemptedRedeemedBold");
    uint256 boldBalanceBefore = boldToken.balanceOf(A);
    uint256[] memory collBalanceBefore = new uint256[](branch.length);
    for (uint256 i = 0; i < branch.length; ++i) {
        collBalanceBefore[i] = branch[i].collToken.balanceOf(A);
    }
    vm.prank(A);
    collateralRegistry.redeemCollateral(truncatedRedeemedBold, maxIterations, feePct);
    uint256 actualRedeemedBold = boldBalanceBefore - boldToken.balanceOf(A);
    assertApproxEqAbsDecimal(actualRedeemedBold, truncatedRedeemedBold, 1, 18, "actualRedeemedBold != truncatedRedeemedBold");
    for (uint256 i = 0; i < branch.length; ++i) {
        uint256 actualRedeemedColl = branch[i].collToken.balanceOf(A) - collBalanceBefore[i];
        assertApproxEqAbsDecimal(actualRedeemedColl, expectedRedeemed[i].coll, 10, 18, string.concat("actualRedeemedColl != expectedRedeemed[", i.toString(), "].coll"));
    }
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

### assertLeDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 14710:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLeDecimal(uint256,uint256,uint256,string)`

```solidity
function assertLeDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertLeDecimal(left, right, decimals, err);
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

### toString(uint256)

- **Kind**: internal
- **Source**: 447:696:96
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Strings.sol:Strings:toString(uint256)`

```solidity
///  @dev Converts a `uint256` to its ASCII `string` decimal representation.
function toString(uint256 value) internal pure returns (string memory) {
    unchecked {
        uint256 length = Math.log10(value) + 1;
        string memory buffer = new string(length);
        uint256 ptr;
        /// @solidity memory-safe-assembly
        assembly {
            ptr := add(buffer, add(32, length))
        }
        while (true) {
            ptr--;
            /// @solidity memory-safe-assembly
            assembly {
                mstore8(ptr, byte(mod(value, 10), _SYMBOLS))
            }
            value /= 10;
            if (value == 0) break;
        }
        return buffer;
    }
}
```

### log10(uint256)

- **Kind**: internal
- **Source**: 10139:916:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:log10(uint256)`

```solidity
///  @dev Return the log in base 10, rounded down, of a positive value.
///  Returns 0 if given 0.
function log10(uint256 value) internal pure returns (uint256) {
    uint256 result = 0;
    unchecked {
        if (value >= (10 ** 64)) {
            value /= 10 ** 64;
            result += 64;
        }
        if (value >= (10 ** 32)) {
            value /= 10 ** 32;
            result += 32;
        }
        if (value >= (10 ** 16)) {
            value /= 10 ** 16;
            result += 16;
        }
        if (value >= (10 ** 8)) {
            value /= 10 ** 8;
            result += 8;
        }
        if (value >= (10 ** 4)) {
            value /= 10 ** 4;
            result += 4;
        }
        if (value >= (10 ** 2)) {
            value /= 10 ** 2;
            result += 2;
        }
        if (value >= (10 ** 1)) {
            result += 1;
        }
    }
    return result;
}
```

## External Calls

- **IBoldToken::balanceOf(address)**
- **IRedemptionHelper::truncateRedemption(uint256,uint256)**
- **Vm::assume(bool)**
- **IERC20Metadata::balanceOf(address)**
- **Vm::prank(address)**
- **ICollateralRegistry::redeemCollateral(uint256,uint256,uint256)**

## State Variable Reads

- **redemptionHelper** (`contract IRedemptionHelper`) [src/Interfaces/IRedemptionHelper.sol/interface_IRedemptionHelper.md]
- **branch** (`struct TestDeployer.LiquityContractsDev[]`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **UINT256_MAX** (`uint256`)
- **params** (`struct TestDeployer.TroveManagerParams[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RedemptionHelperTest.test_TruncateRedemption(uint256,struct RedemptionHelperTest.TroveParams[20],uint256[3],uint256[3],uint256,uint256) (NodeID: 0)
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
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLeDecimal(uint256,uint256,uint256,string) (NodeID: 17)
  │   💬 Args: [truncatedRedeemedBold, attemptedRedeemedBold, 18, "truncatedRedeemedBold > attemptedRedeemedBold"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 18)
  │   💬 Args: [actualRedeemedBold, truncatedRedeemedBold, 1, 18, "actualRedeemedBold != truncatedRedeemedBold"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 19)
      💬 Args: [actualRedeemedColl, expectedRedeemed[i].coll, 10, 18, string.concat("actualRedeemedColl != expectedRedeemed[", i.toString(), "].coll")]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 20)
        💬 Args: [i]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 21)
          💬 Args: [value]
          👁️  Def: internal
```
