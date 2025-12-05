# Function: test_WithdrawFromSPNoClaimEmitsDepositUpdated()

**Contract**: [test/events.t.sol/contract_StabilityPoolEventsTest.md]

## Metadata

- **Contract**: StabilityPoolEventsTest
- **Signature**: `test_WithdrawFromSPNoClaimEmitsDepositUpdated()`
- **Visibility**: external
- **Source Range**: 28991:629:303

## Implementation

```solidity
function test_WithdrawFromSPNoClaimEmitsDepositUpdated() external {
    (Deposit memory deposit, StabilityPoolRewardsState memory current) = makeSPDepositAndGenerateRewards();
    uint256 withdrawal = deposit.recordedBold / 2;
    vm.expectEmit();
    emit DepositUpdated(A, ((deposit.recordedBold - deposit.pendingBoldLoss) + deposit.pendingBoldYieldGain) - withdrawal, deposit.stashedColl + deposit.pendingCollGain, current.P, current.S, current.B, current.scale);
    makeSPWithdrawalNoClaim(A, withdrawal);
}
```

## Related Implementations

### makeSPDepositAndGenerateRewards()

- **Kind**: internal
- **Source**: 24137:2638:303
- **Link**: `test/events.t.sol:StabilityPoolEventsTest:makeSPDepositAndGenerateRewards()`

```solidity
function makeSPDepositAndGenerateRewards() internal returns (Deposit memory deposit, StabilityPoolRewardsState memory current) {
    uint256 liquidatedDebt = 10_000_000_000 ether;
    openTroveWithExactICRAndDebt(A, 0, 10 * CCR, 10 * liquidatedDebt, 0.01 ether);
    uint256[3] memory liquidatedTroveId;
    (liquidatedTroveId[0], ) = openTroveWithExactICRAndDebt(B, 0, MCR, liquidatedDebt, 0.01 ether);
    (liquidatedTroveId[1], ) = openTroveWithExactICRAndDebt(C, 0, MCR, liquidatedDebt, 0.01 ether);
    (liquidatedTroveId[2], ) = openTroveWithExactICRAndDebt(D, 0, MCR, liquidatedDebt, 0.01 ether);
    priceFeed.setPrice((priceFeed.getPrice() * 99) / 100);
    makeSPDepositNoClaim(A, liquidatedDebt);
    makeSPWithdrawalAndClaim(A, 0);
    makeSPDepositNoClaim(A, liquidatedDebt / 1e9);
    troveManager.liquidate(liquidatedTroveId[1]);
    current.scale = stabilityPool.currentScale();
    assertEq(current.scale, 1, "Expected scale change");
    makeSPDepositNoClaim(A, 2 * liquidatedDebt);
    deposit.recordedBold = stabilityPool.getCompoundedBoldDeposit(A);
    assertGt(deposit.recordedBold, 0, "Recorded BOLD deposit should be > 0");
    deposit.stashedColl = stabilityPool.stashedColl(A);
    assertGt(deposit.stashedColl, 0, "Stashed Coll should be > 0");
    troveManager.liquidate(liquidatedTroveId[2]);
    current.P = stabilityPool.P();
    assertLt(current.P, stabilityPool.P_PRECISION(), "P should be < 1");
    current.S = stabilityPool.scaleToS(current.scale);
    assertGt(current.S, 0, "S should be > 0");
    deposit.pendingBoldLoss = deposit.recordedBold - stabilityPool.getCompoundedBoldDeposit(A);
    assertGt(deposit.pendingBoldLoss, 0, "Pending BOLD loss should be > 0");
    deposit.pendingCollGain = stabilityPool.getDepositorCollGain(A);
    assertGt(deposit.pendingCollGain, 0, "Pending Coll gain should be > 0");
    vm.warp(block.timestamp + 100 days);
    openTroveWithExactICRAndDebt(E, 0, MCR, 10_000 ether, 0.01 ether);
    current.B = stabilityPool.scaleToB(current.scale);
    assertGt(current.B, 0, "B should be > 0");
    deposit.pendingBoldYieldGain = stabilityPool.getDepositorYieldGain(A);
    assertGt(deposit.pendingBoldYieldGain, 0, "Pending BOLD yield gain should be > 0");
}
```

### openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 8562:619:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256)`

```solidity
function openTroveWithExactICRAndDebt(address _account, uint256 _index, uint256 _ICR, uint256 _debt, uint256 _interestRate) public returns (uint256 troveId, uint256 coll) {
    (uint256 borrow, uint256 upfrontFee) = findAmountToBorrowWithOpenTrove(_debt, _interestRate);
    uint256 price = priceFeed.getPrice();
    coll = mulDivCeil(_debt, _ICR, price);
    vm.prank(_account);
    troveId = borrowerOperations.openTrove(_account, _index, coll, borrow, 0, 0, _interestRate, upfrontFee, address(0), address(0), address(0));
}
```

### findAmountToBorrowWithOpenTrove(uint256,uint256)

- **Kind**: internal
- **Source**: 4817:815:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:findAmountToBorrowWithOpenTrove(uint256,uint256)`

```solidity
function findAmountToBorrowWithOpenTrove(uint256 targetDebt, uint256 interestRate) internal view returns (uint256 borrow, uint256 upfrontFee) {
    uint256 borrowRight = targetDebt;
    upfrontFee = predictOpenTroveUpfrontFee(borrowRight, interestRate);
    uint256 borrowLeft = borrowRight - upfrontFee;
    for (uint256 i = 0; i < 256; ++i) {
        borrow = (borrowLeft + borrowRight) / 2;
        upfrontFee = predictOpenTroveUpfrontFee(borrow, interestRate);
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

### predictOpenTroveUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 3546:209:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:predictOpenTroveUpfrontFee(uint256,uint256)`

```solidity
function predictOpenTroveUpfrontFee(uint256 borrowedAmount, uint256 interestRate) internal view returns (uint256) {
    return hintHelpers.predictOpenTroveUpfrontFee(0, borrowedAmount, interestRate);
}
```

### mulDivCeil(uint256,uint256,uint256)

- **Kind**: free-function
- **Source**: 764:186:290
- **Link**: `test/Utils/Math.sol:mulDivCeil(uint256,uint256,uint256)`

```solidity
function mulDivCeil(uint256 x, uint256 multiplier, uint256 divider) pure returns (uint256) {
    assert(divider != 0);
    return (x == 0) ? 0 : ((((x * multiplier) + divider) - 1) / divider);
}
```

### makeSPDepositNoClaim(address,uint256)

- **Kind**: internal
- **Source**: 11348:187:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:makeSPDepositNoClaim(address,uint256)`

```solidity
function makeSPDepositNoClaim(address _account, uint256 _amount) public {
    vm.startPrank(_account);
    stabilityPool.provideToSP(_amount, false);
    vm.stopPrank();
}
```

### makeSPWithdrawalAndClaim(address,uint256)

- **Kind**: internal
- **Source**: 11541:193:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:makeSPWithdrawalAndClaim(address,uint256)`

```solidity
function makeSPWithdrawalAndClaim(address _account, uint256 _amount) public {
    vm.startPrank(_account);
    stabilityPool.withdrawFromSP(_amount, true);
    vm.stopPrank();
}
```

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 13228:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertGt(left, right, err);
}
```

### assertLt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 12044:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLt(uint256,uint256,string)`

```solidity
function assertLt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertLt(left, right, err);
}
```

### makeSPWithdrawalNoClaim(address,uint256)

- **Kind**: internal
- **Source**: 11740:193:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:makeSPWithdrawalNoClaim(address,uint256)`

```solidity
function makeSPWithdrawalNoClaim(address _account, uint256 _amount) public {
    vm.startPrank(_account);
    stabilityPool.withdrawFromSP(_amount, false);
    vm.stopPrank();
}
```

## External Calls

- **Vm::expectEmit()**

## State Variable Reads

- **priceFeed** (`contract IPriceFeedTestnet`) [test/TestContracts/Interfaces/IPriceFeedTestnet.sol/interface_IPriceFeedTestnet.md]
- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPoolEventsTest.test_WithdrawFromSPNoClaimEmitsDepositUpdated() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StabilityPoolEventsTest.makeSPDepositAndGenerateRewards() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (NodeID: 2)
  │ │   💬 Args: [A, 0, 10 * CCR, 10 * liquidatedDebt, 0.01 ether]
  │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 3)
  │ │ │   💬 Args: [_debt, _interestRate]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 4)
  │ │ │ │   💬 Args: [borrowRight, interestRate]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 5)
  │ │ │     💬 Args: [borrow, interestRate]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Unknown.mulDivCeil(uint256,uint256,uint256) (NodeID: 6)
  │ │     💬 Args: [_debt, _ICR, price]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (NodeID: 7)
  │ │   💬 Args: [B, 0, MCR, liquidatedDebt, 0.01 ether]
  │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 8)
  │ │ │   💬 Args: [_debt, _interestRate]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 9)
  │ │ │ │   💬 Args: [borrowRight, interestRate]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 10)
  │ │ │     💬 Args: [borrow, interestRate]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Unknown.mulDivCeil(uint256,uint256,uint256) (NodeID: 11)
  │ │     💬 Args: [_debt, _ICR, price]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (NodeID: 12)
  │ │   💬 Args: [C, 0, MCR, liquidatedDebt, 0.01 ether]
  │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 13)
  │ │ │   💬 Args: [_debt, _interestRate]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 14)
  │ │ │ │   💬 Args: [borrowRight, interestRate]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 15)
  │ │ │     💬 Args: [borrow, interestRate]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Unknown.mulDivCeil(uint256,uint256,uint256) (NodeID: 16)
  │ │     💬 Args: [_debt, _ICR, price]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (NodeID: 17)
  │ │   💬 Args: [D, 0, MCR, liquidatedDebt, 0.01 ether]
  │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 18)
  │ │ │   💬 Args: [_debt, _interestRate]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 19)
  │ │ │ │   💬 Args: [borrowRight, interestRate]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 20)
  │ │ │     💬 Args: [borrow, interestRate]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Unknown.mulDivCeil(uint256,uint256,uint256) (NodeID: 21)
  │ │     💬 Args: [_debt, _ICR, price]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.makeSPDepositNoClaim(address,uint256) (NodeID: 22)
  │ │   💬 Args: [A, liquidatedDebt]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.makeSPWithdrawalAndClaim(address,uint256) (NodeID: 23)
  │ │   💬 Args: [A, 0]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.makeSPDepositNoClaim(address,uint256) (NodeID: 24)
  │ │   💬 Args: [A, liquidatedDebt / 1e9]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 25)
  │ │   💬 Args: [current.scale, 1, "Expected scale change"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.makeSPDepositNoClaim(address,uint256) (NodeID: 26)
  │ │   💬 Args: [A, 2 * liquidatedDebt]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 27)
  │ │   💬 Args: [deposit.recordedBold, 0, "Recorded BOLD deposit should be > 0"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 28)
  │ │   💬 Args: [deposit.stashedColl, 0, "Stashed Coll should be > 0"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 29)
  │ │   💬 Args: [current.P, stabilityPool.P_PRECISION(), "P should be < 1"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 30)
  │ │   💬 Args: [current.S, 0, "S should be > 0"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 31)
  │ │   💬 Args: [deposit.pendingBoldLoss, 0, "Pending BOLD loss should be > 0"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 32)
  │ │   💬 Args: [deposit.pendingCollGain, 0, "Pending Coll gain should be > 0"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (NodeID: 33)
  │ │   💬 Args: [E, 0, MCR, 10_000 ether, 0.01 ether]
  │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 34)
  │ │ │   💬 Args: [_debt, _interestRate]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 35)
  │ │ │ │   💬 Args: [borrowRight, interestRate]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 36)
  │ │ │     💬 Args: [borrow, interestRate]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Unknown.mulDivCeil(uint256,uint256,uint256) (NodeID: 37)
  │ │     💬 Args: [_debt, _ICR, price]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 38)
  │ │   💬 Args: [current.B, 0, "B should be > 0"]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 39)
  │     💬 Args: [deposit.pendingBoldYieldGain, 0, "Pending BOLD yield gain should be > 0"]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseTest.makeSPWithdrawalNoClaim(address,uint256) (NodeID: 40)
      💬 Args: [A, withdrawal]
      👁️  Def: public
```
