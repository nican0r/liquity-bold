# Function: test_BatchLiquidateTrovesEmitsLiquidation()

**Contract**: [test/events.t.sol/contract_TroveEventsTest.md]

## Metadata

- **Contract**: TroveEventsTest
- **Signature**: `test_BatchLiquidateTrovesEmitsLiquidation()`
- **Visibility**: external
- **Source Range**: 16954:2704:303

## Implementation

```solidity
function test_BatchLiquidateTrovesEmitsLiquidation() external {
    (, uint256 otherColl) = openTroveWithExactICRAndDebt(B, 0, 10 * CCR, 100_000 ether, 0.01 ether);
    uint256 boldInSP = 25_000 ether;
    makeSPDepositNoClaim(B, boldInSP);
    uint256[3] memory liquidatedDebt;
    liquidatedDebt[0] = 10_000 ether;
    liquidatedDebt[1] = 20_000 ether;
    liquidatedDebt[2] = 30_000 ether;
    uint256[] memory liquidatedTroveIds = new uint256[](liquidatedDebt.length);
    uint256[] memory liquidatedColl = new uint256[](liquidatedDebt.length);
    for (uint256 i = 0; i < liquidatedDebt.length; ++i) {
        (liquidatedTroveIds[i], liquidatedColl[i]) = openTroveWithExactICRAndDebt(A, i, MCR, liquidatedDebt[i], 0.01 ether);
    }
    uint256 price = (priceFeed.getPrice() * 99) / 100;
    priceFeed.setPrice(price);
    LiquidationParams memory t;
    for (uint256 i = 0; i < liquidatedDebt.length; ++i) {
        uint256 collRemaining = liquidatedColl[i];
        LiquidationParams memory l;
        l.debtOffsetBySP = Math.min(liquidatedDebt[i], (boldInSP - t.debtOffsetBySP) - 1e18);
        l.debtRedistributed = liquidatedDebt[i] - l.debtOffsetBySP;
        l.ethGasCompensation = ETH_GAS_COMPENSATION;
        uint256 collToOffset = (liquidatedColl[i] * l.debtOffsetBySP) / liquidatedDebt[i];
        collRemaining -= l.collGasCompensation = collToOffset / COLL_GAS_COMPENSATION_DIVISOR;
        collRemaining -= l.collSentToSP = Math.min(collToOffset - l.collGasCompensation, (l.debtOffsetBySP * (DECIMAL_PRECISION + LIQUIDATION_PENALTY_SP)) / price);
        l.collSurplus = collRemaining -= l.collRedistributed = Math.min(collRemaining, (l.debtRedistributed * (DECIMAL_PRECISION + LIQUIDATION_PENALTY_REDISTRIBUTION)) / price);
        t.aggregateLiquidation(l);
    }
    vm.expectEmit();
    emit Liquidation(t.debtOffsetBySP, t.debtRedistributed, t.ethGasCompensation, t.collGasCompensation, t.collSentToSP, t.collRedistributed, t.collSurplus, (t.collRedistributed * DECIMAL_PRECISION) / otherColl, (t.debtRedistributed * DECIMAL_PRECISION) / otherColl, price);
    troveManager.batchLiquidateTroves(liquidatedTroveIds);
}
```

## Related Implementations

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

### min(uint256,uint256)

- **Kind**: internal
- **Source**: 588:104:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:min(uint256,uint256)`

```solidity
///  @dev Returns the smallest of two numbers.
function min(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a < b) ? a : b;
}
```

### aggregateLiquidation(struct LiquidationParams,struct LiquidationParams)

- **Kind**: free-function
- **Source**: 491:512:303
- **Link**: `test/events.t.sol:aggregateLiquidation(struct LiquidationParams,struct LiquidationParams)`

```solidity
function aggregateLiquidation(LiquidationParams memory aggregate, LiquidationParams memory single) pure {
    aggregate.collSentToSP += single.collSentToSP;
    aggregate.collRedistributed += single.collRedistributed;
    aggregate.collGasCompensation += single.collGasCompensation;
    aggregate.collSurplus += single.collSurplus;
    aggregate.debtOffsetBySP += single.debtOffsetBySP;
    aggregate.debtRedistributed += single.debtRedistributed;
    aggregate.ethGasCompensation += single.ethGasCompensation;
}
```

## External Calls

- **IPriceFeedTestnet::getPrice()**
- **IPriceFeedTestnet::setPrice(uint256)**
- **Vm::expectEmit()**
- **ITroveManagerTester::batchLiquidateTroves(uint256[])**

## State Variable Reads

- **priceFeed** (`contract IPriceFeedTestnet`) [test/TestContracts/Interfaces/IPriceFeedTestnet.sol/interface_IPriceFeedTestnet.md]
- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveEventsTest.test_BatchLiquidateTrovesEmitsLiquidation() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [B, 0, 10 * CCR, 100_000 ether, 0.01 ether]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 2)
  │ │   💬 Args: [_debt, _interestRate]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
  │ │ │   💬 Args: [borrowRight, interestRate]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 4)
  │ │     💬 Args: [borrow, interestRate]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.mulDivCeil(uint256,uint256,uint256) (NodeID: 5)
  │     💬 Args: [_debt, _ICR, price]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositNoClaim(address,uint256) (NodeID: 6)
  │   💬 Args: [B, boldInSP]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (NodeID: 7)
  │   💬 Args: [A, i, MCR, liquidatedDebt[i], 0.01 ether]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 8)
  │ │   💬 Args: [_debt, _interestRate]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 9)
  │ │ │   💬 Args: [borrowRight, interestRate]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 10)
  │ │     💬 Args: [borrow, interestRate]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.mulDivCeil(uint256,uint256,uint256) (NodeID: 11)
  │     💬 Args: [_debt, _ICR, price]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 12)
  │   💬 Args: [liquidatedDebt[i], (boldInSP - t.debtOffsetBySP) - 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 13)
  │   💬 Args: [collToOffset - l.collGasCompensation, (l.debtOffsetBySP * (DECIMAL_PRECISION + LIQUIDATION_PENALTY_SP)) / price]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 14)
  │   💬 Args: [collRemaining, (l.debtRedistributed * (DECIMAL_PRECISION + LIQUIDATION_PENALTY_REDISTRIBUTION)) / price]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Unknown.aggregateLiquidation(struct LiquidationParams,struct LiquidationParams) (NodeID: 15)
      💬 Args: [t, l]
      👁️  Def: internal
```
