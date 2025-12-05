# Function: test_CloseTroveEmitsTroveOperation()

**Contract**: [test/events.t.sol/contract_TroveEventsTest.md]

## Metadata

- **Contract**: TroveEventsTest
- **Signature**: `test_CloseTroveEmitsTroveOperation()`
- **Visibility**: external
- **Source Range**: 9904:1066:303

## Implementation

```solidity
function test_CloseTroveEmitsTroveOperation() external {
    uint256 coll = 100 ether;
    (uint256 troveId, ) = openTroveHelper(A, 0, coll, 10_000 ether, 0.01 ether);
    openTroveHelper(B, 0, 100 ether, 10_000 ether, 0.01 ether);
    uint256 debt = troveManager.getTroveEntireDebt(troveId);
    uint256 balance = boldToken.balanceOf(A);
    assertGe(debt, balance, "expected debt >= balance");
    vm.prank(B);
    boldToken.transfer(A, debt - balance);
    vm.expectEmit();
    emit TroveOperation(troveId, Operation.closeTrove, 0, 0, 0, -int256(debt), 0, -int256(coll));
    vm.prank(A);
    borrowerOperations.closeTrove(troveId);
}
```

## Related Implementations

### openTroveHelper(address,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 7338:704:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:openTroveHelper(address,uint256,uint256,uint256,uint256)`

```solidity
function openTroveHelper(address _account, uint256 _index, uint256 _coll, uint256 _boldAmount, uint256 _annualInterestRate) public returns (uint256 troveId, uint256 upfrontFee) {
    upfrontFee = predictOpenTroveUpfrontFee(_boldAmount, _annualInterestRate);
    vm.startPrank(_account);
    troveId = borrowerOperations.openTrove(_account, _index, _coll, _boldAmount, 0, 0, _annualInterestRate, upfrontFee, address(0), address(0), address(0));
    vm.stopPrank();
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

### assertGe(uint256,uint256,string)

- **Kind**: internal
- **Source**: 15596:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGe(uint256,uint256,string)`

```solidity
function assertGe(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertGe(left, right, err);
}
```

## External Calls

- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **IBoldToken::balanceOf(address)**
- **Vm::prank(address)**
- **IBoldToken::transfer(address,uint256)**
- **Vm::expectEmit()**
- **IBorrowerOperationsTester::closeTrove(uint256)**

## Native Transfers

- **boldToken** (computed)

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveEventsTest.test_CloseTroveEmitsTroveOperation() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [A, 0, coll, 10_000 ether, 0.01 ether]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 2)
  │     💬 Args: [_boldAmount, _annualInterestRate]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 3)
  │   💬 Args: [B, 0, 100 ether, 10_000 ether, 0.01 ether]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 4)
  │     💬 Args: [_boldAmount, _annualInterestRate]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 5)
      💬 Args: [debt, balance, "expected debt >= balance"]
      👁️  Def: internal
```
