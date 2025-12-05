# Function: openTroveWithExactICRAndDebt(uint256,address,uint256,uint256,uint256,uint256)

**Contract**: [test/multicollateral.t.sol/contract_CsBold013.md]

## Metadata

- **Contract**: CsBold013
- **Signature**: `openTroveWithExactICRAndDebt(uint256,address,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 40665:687:311

## Implementation

```solidity
function openTroveWithExactICRAndDebt(uint256 collIndex, address account, uint256 index, uint256 icr, uint256 debt, uint256 interestRate) public returns (uint256 troveId, uint256 coll) {
    (uint256 borrow, uint256 upfrontFee) = findAmountToBorrowWithOpenTrove(collIndex, debt, interestRate);
    uint256 price = branches[collIndex].priceFeed.getPrice();
    coll = Math.ceilDiv(debt * icr, price);
    vm.prank(account);
    troveId = branches[collIndex].borrowerOperations.openTrove(account, index, coll, borrow, 0, 0, interestRate, upfrontFee, address(0), address(0), address(0));
}
```

## Related Implementations

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

## External Calls

- **IPriceFeedTestnet::getPrice()**
- **Vm::prank(address)**
- **IBorrowerOperationsTester::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**

## State Variable Reads

- **branches** (`struct TestDeployer.LiquityContractsDev[]`)
- **hintHelpers** (`contract IHintHelpers`) [src/Interfaces/IHintHelpers.sol/interface_IHintHelpers.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CsBold013.openTroveWithExactICRAndDebt(uint256,address,uint256,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: CsBold013.findAmountToBorrowWithOpenTrove(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [collIndex, debt, interestRate]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: CsBold013.predictOpenTroveUpfrontFee(uint256,uint256,uint256) (NodeID: 2)
  │ │   💬 Args: [collIndex, borrowRight, interestRate]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: CsBold013.predictOpenTroveUpfrontFee(uint256,uint256,uint256) (NodeID: 3)
  │     💬 Args: [collIndex, borrow, interestRate]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Math.ceilDiv(uint256,uint256) (NodeID: 4)
      💬 Args: [debt * icr, price]
      👁️  Def: internal
```
