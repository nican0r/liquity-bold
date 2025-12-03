# Function: openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256)

**Contract**: [test/TestContracts/BaseTest.sol/contract_BaseTest.md]

## Metadata

- **Contract**: BaseTest
- **Signature**: `openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 8562:619:254

## Implementation

```solidity
function openTroveWithExactICRAndDebt(address _account, uint256 _index, uint256 _ICR, uint256 _debt, uint256 _interestRate) public returns (uint256 troveId, uint256 coll) {
    (uint256 borrow, uint256 upfrontFee) = findAmountToBorrowWithOpenTrove(_debt, _interestRate);
    uint256 price = priceFeed.getPrice();
    coll = mulDivCeil(_debt, _ICR, price);
    vm.prank(_account);
    troveId = borrowerOperations.openTrove(_account, _index, coll, borrow, 0, 0, _interestRate, upfrontFee, address(0), address(0), address(0));
}
```

## Related Implementations

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

- **IPriceFeedTestnet::getPrice()**
- **Vm::prank(address)**
- **IBorrowerOperationsTester::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**

## State Variable Reads

- **priceFeed** (`contract IPriceFeedTestnet`) [test/TestContracts/Interfaces/IPriceFeedTestnet.sol/interface_IPriceFeedTestnet.md]
- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 1)
  │   💬 Args: [_debt, _interestRate]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 2)
  │ │   💬 Args: [borrowRight, interestRate]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
  │     💬 Args: [borrow, interestRate]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Unknown.mulDivCeil(uint256,uint256,uint256) (NodeID: 4)
      💬 Args: [_debt, _ICR, price]
      👁️  Def: internal
```
