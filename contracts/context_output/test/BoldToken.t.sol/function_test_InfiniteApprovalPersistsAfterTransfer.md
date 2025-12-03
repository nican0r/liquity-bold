# Function: test_InfiniteApprovalPersistsAfterTransfer()

**Contract**: [test/BoldToken.t.sol/contract_BoldTokenTest.md]

## Metadata

- **Contract**: BoldTokenTest
- **Signature**: `test_InfiniteApprovalPersistsAfterTransfer()`
- **Visibility**: external
- **Source Range**: 251:865:229

## Implementation

```solidity
function test_InfiniteApprovalPersistsAfterTransfer() external {
    uint256 initialBalance_A = 10_000 ether;
    openTroveHelper(A, 0, 100 ether, initialBalance_A, 0.01 ether);
    assertEq(boldToken.balanceOf(A), initialBalance_A, "A's balance is wrong");
    vm.prank(A);
    assertTrue(boldToken.approve(B, UINT256_MAX));
    assertEq(boldToken.allowance(A, B), UINT256_MAX, "Allowance should be infinite");
    uint256 value = 1_000 ether;
    vm.prank(B);
    assertTrue(boldToken.transferFrom(A, C, value));
    assertEq(boldToken.balanceOf(A), initialBalance_A - value, "A's balance should have decreased by value");
    assertEq(boldToken.balanceOf(C), value, "C's balance should have increased by value");
    assertEq(boldToken.allowance(A, B), UINT256_MAX, "Allowance should still be infinite");
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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
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

## External Calls

- **IBoldToken::balanceOf(address)**
- **Vm::prank(address)**
- **IBoldToken::approve(address,uint256)**
- **IBoldToken::allowance(address,address)**
- **IBoldToken::transferFrom(address,address,uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BoldTokenTest.test_InfiniteApprovalPersistsAfterTransfer() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [A, 0, 100 ether, initialBalance_A, 0.01 ether]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 2)
  │     💬 Args: [_boldAmount, _annualInterestRate]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [boldToken.balanceOf(A), initialBalance_A, "A's balance is wrong"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 4)
  │   💬 Args: [boldToken.approve(B, UINT256_MAX)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [boldToken.allowance(A, B), UINT256_MAX, "Allowance should be infinite"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 6)
  │   💬 Args: [boldToken.transferFrom(A, C, value)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [boldToken.balanceOf(A), initialBalance_A - value, "A's balance should have decreased by value"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 8)
  │   💬 Args: [boldToken.balanceOf(C), value, "C's balance should have increased by value"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 9)
      💬 Args: [boldToken.allowance(A, B), UINT256_MAX, "Allowance should still be infinite"]
      👁️  Def: internal
```
