# Function: test_RedeemCollateral_ForwardsRedeemedColl()

**Contract**: [test/RedemptionHelper.t.sol/contract_RedemptionHelperTest.md]

## Metadata

- **Contract**: RedemptionHelperTest
- **Signature**: `test_RedeemCollateral_ForwardsRedeemedColl()`
- **Visibility**: external
- **Source Range**: 12145:1310:245

## Implementation

```solidity
function test_RedeemCollateral_ForwardsRedeemedColl() external {
    skip(100 days);
    for (uint256 i = 0; i < branch.length; ++i) {
        openTrove(i, A, 0, 2 ether, 10_000 ether, 0.05 ether);
    }
    uint256[] memory collBalanceBefore = new uint256[](branch.length);
    for (uint256 i = 0; i < branch.length; ++i) {
        collBalanceBefore[i] = branch[i].collToken.balanceOf(A);
    }
    uint256 redeemedBold = branch.length * 1_000 ether;
    vm.startPrank(A);
    boldToken.approve(address(redemptionHelper), redeemedBold);
    redemptionHelper.redeemCollateral(redeemedBold, 1, 1 ether, new uint256[](branch.length));
    vm.stopPrank();
    for (uint256 i = 0; i < branch.length; ++i) {
        uint256 actualRedeemedColl = branch[i].collToken.balanceOf(A) - collBalanceBefore[i];
        assertApproxEqAbsDecimal(actualRedeemedColl, (1_000 ether * 0.895 ether) / branch[i].priceFeed.getPrice(), 1, 18, "actualRedeemedColl");
        assertEqDecimal(branch[i].collToken.balanceOf(address(redemptionHelper)), 0, 18, "collToken.balanceOf(redemptionHelper)");
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

### assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 17272:268:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)`

```solidity
function assertApproxEqAbsDecimal(uint256 left, uint256 right, uint256 maxDelta, uint256 decimals, string memory err) virtual internal pure {
    vm.assertApproxEqAbsDecimal(left, right, maxDelta, decimals, err);
}
```

### assertEqDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 2684:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEqDecimal(uint256,uint256,uint256,string)`

```solidity
function assertEqDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertEqDecimal(left, right, decimals, err);
}
```

## External Calls

- **IERC20Metadata::balanceOf(address)**
- **Vm::startPrank(address)**
- **IBoldToken::approve(address,uint256)**
- **IRedemptionHelper::redeemCollateral(uint256,uint256,uint256,uint256[])**
- **Vm::stopPrank()**
- **IPriceFeedTestnet::getPrice()**

## State Variable Reads

- **branch** (`struct TestDeployer.LiquityContractsDev[]`)
- **redemptionHelper** (`contract IRedemptionHelper`) [src/Interfaces/IRedemptionHelper.sol/interface_IRedemptionHelper.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RedemptionHelperTest.test_RedeemCollateral_ForwardsRedeemedColl() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 1)
  │   💬 Args: [100 days]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: RedemptionHelperTest.openTrove(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 2)
  │   💬 Args: [i, A, 0, 2 ether, 10_000 ether, 0.05 ether]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: RedemptionHelperTest.findAmountToBorrow(uint256,uint256,uint256) (NodeID: 3)
  │ │   💬 Args: [branchIdx, debt, interestRate]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.ceilDiv(uint256,uint256) (NodeID: 4)
  │     💬 Args: [debt * collRatio, branch[branchIdx].priceFeed.getPrice()]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [actualRedeemedColl, (1_000 ether * 0.895 ether) / branch[i].priceFeed.getPrice(), 1, 18, "actualRedeemedColl"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 6)
      💬 Args: [branch[i].collToken.balanceOf(address(redemptionHelper)), 0, 18, "collToken.balanceOf(redemptionHelper)"]
      👁️  Def: internal
```
