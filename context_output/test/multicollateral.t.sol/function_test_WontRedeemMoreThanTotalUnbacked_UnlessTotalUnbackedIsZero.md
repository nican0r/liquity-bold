# Function: test_WontRedeemMoreThanTotalUnbacked_UnlessTotalUnbackedIsZero()

**Contract**: [test/multicollateral.t.sol/contract_CsBold013.md]

## Metadata

- **Contract**: CsBold013
- **Signature**: `test_WontRedeemMoreThanTotalUnbacked_UnlessTotalUnbackedIsZero()`
- **Visibility**: external
- **Source Range**: 41358:3341:311

## Implementation

```solidity
function test_WontRedeemMoreThanTotalUnbacked_UnlessTotalUnbackedIsZero() external {
    {
        openTroveWithExactICRAndDebt(0, A, 0, CCR_WETH, 200_000 ether, MIN_ANNUAL_INTEREST_RATE);
        vm.prank(A);
        branches[0].stabilityPool.provideToSP(100_000 ether, false);
        branches[0].priceFeed.setPrice((INITIAL_PRICE * (SCR_WETH - _1pct)) / CCR_WETH);
        branches[0].borrowerOperations.shutdown();
    }
    {
        openTroveWithExactICRAndDebt(1, A, 0, 2 * CCR_WETH, 100_000 ether, MIN_ANNUAL_INTEREST_RATE);
        vm.prank(A);
        branches[1].stabilityPool.provideToSP(99_000 ether, false);
    }
    {
        openTroveWithExactICRAndDebt(2, A, 0, 2 * CCR_WETH, 10_000 ether, MIN_ANNUAL_INTEREST_RATE);
        vm.prank(A);
        branches[2].stabilityPool.provideToSP(9_000 ether, false);
    }
    {
        (uint256 unbackedDebt, , bool redeemable) = branches[0].troveManager.getUnbackedPortionPriceAndRedeemability();
        assertFalse(redeemable);
        assertEqDecimal(unbackedDebt, 100_000 ether, 18);
    }
    {
        (uint256 unbackedDebt, , bool redeemable) = branches[1].troveManager.getUnbackedPortionPriceAndRedeemability();
        assertTrue(redeemable);
        assertEqDecimal(unbackedDebt, 1_000 ether, 18);
        assertEqDecimal(branches[1].troveManager.getEntireBranchDebt(), 100_000 ether, 18);
    }
    {
        (uint256 unbackedDebt, , bool redeemable) = branches[2].troveManager.getUnbackedPortionPriceAndRedeemability();
        assertTrue(redeemable);
        assertEqDecimal(unbackedDebt, 1_000 ether, 18);
        assertEqDecimal(branches[2].troveManager.getEntireBranchDebt(), 10_000 ether, 18);
    }
    vm.startPrank(A);
    {
        uint256 boldBefore = boldToken.balanceOf(A);
        collateralRegistry.redeemCollateral(10_000 ether, 0, 1 ether);
        uint256 actuallyRedeemed = boldBefore - boldToken.balanceOf(A);
        assertEqDecimal(actuallyRedeemed, 2_000 ether, 18, "wrong amount redeemed");
        collateralRegistry.redeemCollateral(10_800 ether, 0, 1 ether);
    }
    vm.stopPrank();
    assertEqDecimal(branches[0].troveManager.getEntireBranchDebt(), 200_000 ether, 18, "wrong branch #0 debt");
    assertEqDecimal(branches[1].troveManager.getEntireBranchDebt(), 89_100 ether, 18, "wrong branch #1 debt");
    assertEqDecimal(branches[2].troveManager.getEntireBranchDebt(), 8_100 ether, 18, "wrong branch #2 debt");
}
```

## Related Implementations

### openTroveWithExactICRAndDebt(uint256,address,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 40665:687:311
- **Link**: `test/multicollateral.t.sol:CsBold013:openTroveWithExactICRAndDebt(uint256,address,uint256,uint256,uint256,uint256)`

```solidity
function openTroveWithExactICRAndDebt(uint256 collIndex, address account, uint256 index, uint256 icr, uint256 debt, uint256 interestRate) public returns (uint256 troveId, uint256 coll) {
    (uint256 borrow, uint256 upfrontFee) = findAmountToBorrowWithOpenTrove(collIndex, debt, interestRate);
    uint256 price = branches[collIndex].priceFeed.getPrice();
    coll = Math.ceilDiv(debt * icr, price);
    vm.prank(account);
    troveId = branches[collIndex].borrowerOperations.openTrove(account, index, coll, borrow, 0, 0, interestRate, upfrontFee, address(0), address(0), address(0));
}
```

### findAmountToBorrowWithOpenTrove(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 39803:856:311
- **Link**: `test/multicollateral.t.sol:CsBold013:findAmountToBorrowWithOpenTrove(uint256,uint256,uint256)`

```solidity
function findAmountToBorrowWithOpenTrove(uint256 collIndex, uint256 targetDebt, uint256 interestRate) internal view returns (uint256 borrow, uint256 upfrontFee) {
    uint256 borrowRight = targetDebt;
    upfrontFee = predictOpenTroveUpfrontFee(collIndex, borrowRight, interestRate);
    uint256 borrowLeft = borrowRight - upfrontFee;
    for (uint256 i = 0; i < 256; ++i) {
        borrow = (borrowLeft + borrowRight) / 2;
        upfrontFee = predictOpenTroveUpfrontFee(collIndex, borrow, interestRate);
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

### predictOpenTroveUpfrontFee(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 39455:264:311
- **Link**: `test/multicollateral.t.sol:CsBold013:predictOpenTroveUpfrontFee(uint256,uint256,uint256)`

```solidity
function predictOpenTroveUpfrontFee(uint256 collIndex, uint256 borrowedAmount, uint256 interestRate) internal view returns (uint256) {
    return hintHelpers.predictOpenTroveUpfrontFee(collIndex, borrowedAmount, interestRate);
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

### assertFalse(bool)

- **Kind**: internal
- **Source**: 1808:91:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool)`

```solidity
function assertFalse(bool data) virtual internal pure {
    vm.assertFalse(data);
}
```

### assertEqDecimal(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 2526:152:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEqDecimal(uint256,uint256,uint256)`

```solidity
function assertEqDecimal(uint256 left, uint256 right, uint256 decimals) virtual internal pure {
    vm.assertEqDecimal(left, right, decimals);
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

- **Vm::prank(address)**
- **IStabilityPool::provideToSP(uint256,bool)**
- **IPriceFeedTestnet::setPrice(uint256)**
- **IBorrowerOperationsTester::shutdown()**
- **ITroveManagerTester::getUnbackedPortionPriceAndRedeemability()**
- **ITroveManagerTester::getEntireBranchDebt()**
- **Vm::startPrank(address)**
- **IBoldToken::balanceOf(address)**
- **ICollateralRegistry::redeemCollateral(uint256,uint256,uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **branches** (`struct TestDeployer.LiquityContractsDev[]`)
- **INITIAL_PRICE** (`uint256`)
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]
- **hintHelpers** (`contract IHintHelpers`) [src/Interfaces/IHintHelpers.sol/interface_IHintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CsBold013.test_WontRedeemMoreThanTotalUnbacked_UnlessTotalUnbackedIsZero() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: CsBold013.openTroveWithExactICRAndDebt(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [0, A, 0, CCR_WETH, 200_000 ether, MIN_ANNUAL_INTEREST_RATE]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: CsBold013.findAmountToBorrowWithOpenTrove(uint256,uint256,uint256) (NodeID: 2)
  │ │   💬 Args: [collIndex, debt, interestRate]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: CsBold013.predictOpenTroveUpfrontFee(uint256,uint256,uint256) (NodeID: 3)
  │ │ │   💬 Args: [collIndex, borrowRight, interestRate]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: CsBold013.predictOpenTroveUpfrontFee(uint256,uint256,uint256) (NodeID: 4)
  │ │     💬 Args: [collIndex, borrow, interestRate]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.ceilDiv(uint256,uint256) (NodeID: 5)
  │     💬 Args: [debt * icr, price]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: CsBold013.openTroveWithExactICRAndDebt(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 6)
  │   💬 Args: [1, A, 0, 2 * CCR_WETH, 100_000 ether, MIN_ANNUAL_INTEREST_RATE]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: CsBold013.findAmountToBorrowWithOpenTrove(uint256,uint256,uint256) (NodeID: 7)
  │ │   💬 Args: [collIndex, debt, interestRate]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: CsBold013.predictOpenTroveUpfrontFee(uint256,uint256,uint256) (NodeID: 8)
  │ │ │   💬 Args: [collIndex, borrowRight, interestRate]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: CsBold013.predictOpenTroveUpfrontFee(uint256,uint256,uint256) (NodeID: 9)
  │ │     💬 Args: [collIndex, borrow, interestRate]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.ceilDiv(uint256,uint256) (NodeID: 10)
  │     💬 Args: [debt * icr, price]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: CsBold013.openTroveWithExactICRAndDebt(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 11)
  │   💬 Args: [2, A, 0, 2 * CCR_WETH, 10_000 ether, MIN_ANNUAL_INTEREST_RATE]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: CsBold013.findAmountToBorrowWithOpenTrove(uint256,uint256,uint256) (NodeID: 12)
  │ │   💬 Args: [collIndex, debt, interestRate]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: CsBold013.predictOpenTroveUpfrontFee(uint256,uint256,uint256) (NodeID: 13)
  │ │ │   💬 Args: [collIndex, borrowRight, interestRate]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: CsBold013.predictOpenTroveUpfrontFee(uint256,uint256,uint256) (NodeID: 14)
  │ │     💬 Args: [collIndex, borrow, interestRate]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.ceilDiv(uint256,uint256) (NodeID: 15)
  │     💬 Args: [debt * icr, price]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool) (NodeID: 16)
  │   💬 Args: [redeemable]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256) (NodeID: 17)
  │   💬 Args: [unbackedDebt, 100_000 ether, 18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 18)
  │   💬 Args: [redeemable]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256) (NodeID: 19)
  │   💬 Args: [unbackedDebt, 1_000 ether, 18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256) (NodeID: 20)
  │   💬 Args: [branches[1].troveManager.getEntireBranchDebt(), 100_000 ether, 18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 21)
  │   💬 Args: [redeemable]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256) (NodeID: 22)
  │   💬 Args: [unbackedDebt, 1_000 ether, 18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256) (NodeID: 23)
  │   💬 Args: [branches[2].troveManager.getEntireBranchDebt(), 10_000 ether, 18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 24)
  │   💬 Args: [actuallyRedeemed, 2_000 ether, 18, "wrong amount redeemed"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 25)
  │   💬 Args: [branches[0].troveManager.getEntireBranchDebt(), 200_000 ether, 18, "wrong branch #0 debt"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 26)
  │   💬 Args: [branches[1].troveManager.getEntireBranchDebt(), 89_100 ether, 18, "wrong branch #1 debt"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 27)
      💬 Args: [branches[2].troveManager.getEntireBranchDebt(), 8_100 ether, 18, "wrong branch #2 debt"]
      👁️  Def: internal
```
