# Function: testWithdrawCollWithRemoveManager()

**Contract**: [test/borrowerOperationsOnBehalfTroveManagament.t.sol/contract_BorrowerOperationsOnBehalfTroveManagamentTest.md]

## Metadata

- **Contract**: BorrowerOperationsOnBehalfTroveManagamentTest
- **Signature**: `testWithdrawCollWithRemoveManager()`
- **Visibility**: public
- **Source Range**: 14395:1244:300

## Implementation

```solidity
function testWithdrawCollWithRemoveManager() public {
    uint256 ATroveId = openTroveNoHints100pct(A, 100 ether, 10000e18, 1e17);
    vm.startPrank(A);
    borrowerOperations.setRemoveManager(ATroveId, B);
    vm.stopPrank();
    vm.startPrank(A);
    uint256 AInitialCollBalance = collToken.balanceOf(A);
    uint256 initialColl = troveManager.getTroveColl(ATroveId);
    borrowerOperations.withdrawColl(ATroveId, 1 ether);
    vm.stopPrank();
    assertEq(troveManager.getTroveColl(ATroveId), initialColl - 1 ether, "Wrong trove coll");
    assertEq(collToken.balanceOf(A), AInitialCollBalance + 1 ether, "Wrong owner balance");
    vm.startPrank(B);
    uint256 BInitialCollBalance = collToken.balanceOf(B);
    borrowerOperations.withdrawColl(ATroveId, 1 ether);
    vm.stopPrank();
    assertEq(troveManager.getTroveColl(ATroveId), initialColl - 2 ether, "Wrong trove coll");
    assertEq(collToken.balanceOf(A), AInitialCollBalance + 2 ether, "Wrong owner balance");
    assertEq(collToken.balanceOf(B), BInitialCollBalance, "Wrong manager balance");
}
```

## Related Implementations

### openTroveNoHints100pct(address,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 6736:267:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:openTroveNoHints100pct(address,uint256,uint256,uint256)`

```solidity
function openTroveNoHints100pct(address _account, uint256 _coll, uint256 _boldAmount, uint256 _annualInterestRate) public returns (uint256 troveId) {
    (troveId, ) = openTroveHelper(_account, 0, _coll, _boldAmount, _annualInterestRate);
}
```

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

## External Calls

- **Vm::startPrank(address)**
- **IBorrowerOperationsTester::setRemoveManager(uint256,address)**
- **Vm::stopPrank()**
- **IERC20::balanceOf(address)**
- **ITroveManagerTester::getTroveColl(uint256)**
- **IBorrowerOperationsTester::withdrawColl(uint256,uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperationsOnBehalfTroveManagamentTest.testWithdrawCollWithRemoveManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [A, 100 ether, 10000e18, 1e17]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [troveManager.getTroveColl(ATroveId), initialColl - 1 ether, "Wrong trove coll"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [collToken.balanceOf(A), AInitialCollBalance + 1 ether, "Wrong owner balance"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
  │   💬 Args: [troveManager.getTroveColl(ATroveId), initialColl - 2 ether, "Wrong trove coll"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [collToken.balanceOf(A), AInitialCollBalance + 2 ether, "Wrong owner balance"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 8)
      💬 Args: [collToken.balanceOf(B), BInitialCollBalance, "Wrong manager balance"]
      👁️  Def: internal
```
