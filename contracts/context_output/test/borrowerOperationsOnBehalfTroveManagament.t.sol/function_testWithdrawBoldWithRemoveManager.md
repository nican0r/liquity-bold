# Function: testWithdrawBoldWithRemoveManager()

**Contract**: [test/borrowerOperationsOnBehalfTroveManagament.t.sol/contract_BorrowerOperationsOnBehalfTroveManagamentTest.md]

## Metadata

- **Contract**: BorrowerOperationsOnBehalfTroveManagamentTest
- **Signature**: `testWithdrawBoldWithRemoveManager()`
- **Visibility**: public
- **Source Range**: 20306:853:300

## Implementation

```solidity
function testWithdrawBoldWithRemoveManager() public {
    uint256 ATroveId = openTroveNoHints100pct(A, 100 ether, 10000e18, 1e17);
    vm.startPrank(A);
    borrowerOperations.setRemoveManager(ATroveId, B);
    vm.stopPrank();
    uint256 AInitialBoldBalance = boldToken.balanceOf(A);
    withdrawBold100pct(A, ATroveId, 10e18);
    assertEq(boldToken.balanceOf(A), AInitialBoldBalance + 10e18, "Wrong owner balance");
    uint256 BInitialBoldBalance = boldToken.balanceOf(B);
    withdrawBold100pct(B, ATroveId, 10e18);
    assertEq(boldToken.balanceOf(A), AInitialBoldBalance + 20e18, "Wrong owner balance");
    assertEq(boldToken.balanceOf(B), BInitialBoldBalance, "Wrong manager balance");
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

### withdrawBold100pct(address,uint256,uint256)

- **Kind**: internal
- **Source**: 12286:279:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:withdrawBold100pct(address,uint256,uint256)`

```solidity
function withdrawBold100pct(address _account, uint256 _troveId, uint256 _debtIncrease) public {
    vm.startPrank(_account);
    borrowerOperations.withdrawBold(_troveId, _debtIncrease, predictAdjustTroveUpfrontFee(_troveId, _debtIncrease));
    vm.stopPrank();
}
```

### predictAdjustTroveUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 4277:199:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:predictAdjustTroveUpfrontFee(uint256,uint256)`

```solidity
function predictAdjustTroveUpfrontFee(uint256 troveId, uint256 debtIncrease) internal view returns (uint256) {
    return hintHelpers.predictAdjustTroveUpfrontFee(0, troveId, debtIncrease);
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
- **IBoldToken::balanceOf(address)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperationsOnBehalfTroveManagamentTest.testWithdrawBoldWithRemoveManager() (NodeID: 0)
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
  ├─ [1] ⚙️ FUNCTION: BaseTest.withdrawBold100pct(address,uint256,uint256) (NodeID: 4)
  │   💬 Args: [A, ATroveId, 10e18]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictAdjustTroveUpfrontFee(uint256,uint256) (NodeID: 5)
  │     💬 Args: [_troveId, _debtIncrease]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
  │   💬 Args: [boldToken.balanceOf(A), AInitialBoldBalance + 10e18, "Wrong owner balance"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.withdrawBold100pct(address,uint256,uint256) (NodeID: 7)
  │   💬 Args: [B, ATroveId, 10e18]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictAdjustTroveUpfrontFee(uint256,uint256) (NodeID: 8)
  │     💬 Args: [_troveId, _debtIncrease]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 9)
  │   💬 Args: [boldToken.balanceOf(A), AInitialBoldBalance + 20e18, "Wrong owner balance"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 10)
      💬 Args: [boldToken.balanceOf(B), BInitialBoldBalance, "Wrong manager balance"]
      👁️  Def: internal
```
