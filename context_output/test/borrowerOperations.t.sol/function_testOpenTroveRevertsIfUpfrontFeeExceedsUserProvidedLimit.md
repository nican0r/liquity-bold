# Function: testOpenTroveRevertsIfUpfrontFeeExceedsUserProvidedLimit()

**Contract**: [test/borrowerOperations.t.sol/contract_BorrowerOperationsTest.md]

## Metadata

- **Contract**: BorrowerOperationsTest
- **Signature**: `testOpenTroveRevertsIfUpfrontFeeExceedsUserProvidedLimit()`
- **Visibility**: public
- **Source Range**: 2735:528:299

## Implementation

```solidity
function testOpenTroveRevertsIfUpfrontFeeExceedsUserProvidedLimit() public {
    uint256 borrow = 10_000 ether;
    uint256 interestRate = 0.05 ether;
    uint256 upfrontFee = predictOpenTroveUpfrontFee(borrow, interestRate);
    assertGt(upfrontFee, 0);
    vm.prank(A);
    vm.expectRevert(BorrowerOperations.UpfrontFeeTooHigh.selector);
    borrowerOperations.openTrove(A, 0, 100 ether, borrow, 0, 0, interestRate, upfrontFee - 1, address(0), address(0), address(0));
}
```

## Related Implementations

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

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **IBorrowerOperationsTester::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**

## State Variable Reads

- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperationsTest.testOpenTroveRevertsIfUpfrontFeeExceedsUserProvidedLimit() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 1)
  │   💬 Args: [borrow, interestRate]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 2)
      💬 Args: [upfrontFee, 0]
      👁️  Def: internal
```
