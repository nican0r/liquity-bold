# Function: testOpenTroveChargesUpfrontFee()

**Contract**: [test/borrowerOperations.t.sol/contract_BorrowerOperationsTest.md]

## Metadata

- **Contract**: BorrowerOperationsTest
- **Signature**: `testOpenTroveChargesUpfrontFee()`
- **Visibility**: public
- **Source Range**: 1844:885:299

## Implementation

```solidity
function testOpenTroveChargesUpfrontFee() public {
    uint256 borrow = 10_000 ether;
    uint256 interestRate = 0.05 ether;
    uint256 upfrontFee = predictOpenTroveUpfrontFee(borrow, interestRate);
    assertGt(upfrontFee, 0);
    uint256 activePoolDebtBefore = activePool.getBoldDebt();
    vm.prank(A);
    uint256 troveId = borrowerOperations.openTrove(A, 0, 100 ether, borrow, 0, 0, interestRate, upfrontFee, address(0), address(0), address(0));
    uint256 troveDebt = troveManager.getTroveEntireDebt(troveId);
    uint256 activePoolDebtAfter = activePool.getBoldDebt();
    uint256 expectedDebt = borrow + upfrontFee;
    assertEqDecimal(troveDebt, expectedDebt, 18, "Wrong Trove debt");
    assertEqDecimal(activePoolDebtAfter - activePoolDebtBefore, expectedDebt, 18, "Wrong AP debt increase");
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

- **IActivePool::getBoldDebt()**
- **Vm::prank(address)**
- **IBorrowerOperationsTester::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**

## State Variable Reads

- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperationsTest.testOpenTroveChargesUpfrontFee() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 1)
  │   💬 Args: [borrow, interestRate]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 2)
  │   💬 Args: [upfrontFee, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [troveDebt, expectedDebt, 18, "Wrong Trove debt"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 4)
      💬 Args: [activePoolDebtAfter - activePoolDebtBefore, expectedDebt, 18, "Wrong AP debt increase"]
      👁️  Def: internal
```
