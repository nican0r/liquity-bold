# Function: test_LiquidateEmitsTroveOperation()

**Contract**: [test/events.t.sol/contract_TroveEventsTest.md]

## Metadata

- **Contract**: TroveEventsTest
- **Signature**: `test_LiquidateEmitsTroveOperation()`
- **Visibility**: external
- **Source Range**: 11740:1023:303

## Implementation

```solidity
function test_LiquidateEmitsTroveOperation() external {
    openTroveWithExactICRAndDebt(B, 0, 2 * CCR, 10_000 ether, 0.01 ether);
    (uint256 liquidatedTroveId, ) = openTroveWithExactICRAndDebt(A, 0, MCR, 10_000 ether, 0.01 ether);
    uint256 debt = troveManager.getTroveEntireDebt(liquidatedTroveId);
    uint256 coll = troveManager.getTroveEntireColl(liquidatedTroveId);
    priceFeed.setPrice((priceFeed.getPrice() * 99) / 100);
    vm.expectEmit();
    emit TroveOperation(liquidatedTroveId, Operation.liquidate, 0, 0, 0, -int256(debt), 0, -int256(coll));
    troveManager.liquidate(liquidatedTroveId);
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

## External Calls

- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **ITroveManagerTester::getTroveEntireColl(uint256)**
- **IPriceFeedTestnet::setPrice(uint256)**
- **IPriceFeedTestnet::getPrice()**
- **Vm::expectEmit()**
- **ITroveManagerTester::liquidate(uint256)**

## State Variable Reads

- **priceFeed** (`contract IPriceFeedTestnet`) [test/TestContracts/Interfaces/IPriceFeedTestnet.sol/interface_IPriceFeedTestnet.md]
- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveEventsTest.test_LiquidateEmitsTroveOperation() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [B, 0, 2 * CCR, 10_000 ether, 0.01 ether]
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
  └─ [1] ⚙️ FUNCTION: BaseTest.openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (NodeID: 6)
      💬 Args: [A, 0, MCR, 10_000 ether, 0.01 ether]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 7)
    │   💬 Args: [_debt, _interestRate]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 8)
    │ │   💬 Args: [borrowRight, interestRate]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 9)
    │     💬 Args: [borrow, interestRate]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Unknown.mulDivCeil(uint256,uint256,uint256) (NodeID: 10)
        💬 Args: [_debt, _ICR, price]
        👁️  Def: internal
```
