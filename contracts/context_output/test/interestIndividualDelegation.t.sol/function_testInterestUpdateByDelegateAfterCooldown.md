# Function: testInterestUpdateByDelegateAfterCooldown()

**Contract**: [test/interestIndividualDelegation.t.sol/contract_InterestIndividualDelegationTest.md]

## Metadata

- **Contract**: InterestIndividualDelegationTest
- **Signature**: `testInterestUpdateByDelegateAfterCooldown()`
- **Visibility**: public
- **Source Range**: 12782:641:305

## Implementation

```solidity
function testInterestUpdateByDelegateAfterCooldown() public {
    uint256 troveId = openTroveAndSetIndividualDelegate();
    vm.warp(block.timestamp + INTEREST_RATE_ADJ_COOLDOWN);
    uint256 entireDebtBefore = troveManager.getTroveEntireDebt(troveId);
    uint256 newAnnualInterestRate = 6e16;
    vm.startPrank(B);
    borrowerOperations.adjustTroveInterestRate(troveId, newAnnualInterestRate, 0, 0, 1e24);
    vm.stopPrank();
    assertEq(troveManager.getTroveEntireDebt(troveId), entireDebtBefore);
    assertEq(troveManager.getTroveAnnualInterestRate(troveId), 6e16, "Wrong interest rate");
}
```

## Related Implementations

### openTroveAndSetIndividualDelegate()

- **Kind**: internal
- **Source**: 216:329:305
- **Link**: `test/interestIndividualDelegation.t.sol:InterestIndividualDelegationTest:openTroveAndSetIndividualDelegate()`

```solidity
function openTroveAndSetIndividualDelegate() internal returns (uint256) {
    uint256 troveId = openTroveNoHints100pct(A, 100e18, 5000e18, 5e16);
    vm.startPrank(A);
    borrowerOperations.setInterestIndividualDelegate(troveId, B, 1e16, 20e16, 0, 0, 0, 0, 0);
    vm.stopPrank();
    return troveId;
}
```

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

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
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

- **Vm::warp(uint256)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **Vm::startPrank(address)**
- **IBorrowerOperationsTester::adjustTroveInterestRate(uint256,uint256,uint256,uint256,uint256)**
- **Vm::stopPrank()**
- **ITroveManagerTester::getTroveAnnualInterestRate(uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestIndividualDelegationTest.testInterestUpdateByDelegateAfterCooldown() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: InterestIndividualDelegationTest.openTroveAndSetIndividualDelegate() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [A, 100e18, 5000e18, 5e16]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 3)
  │       💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │       👁️  Def: public
  │     └─ [4] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 4)
  │         💬 Args: [_boldAmount, _annualInterestRate]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [troveManager.getTroveEntireDebt(troveId), entireDebtBefore]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
      💬 Args: [troveManager.getTroveAnnualInterestRate(troveId), 6e16, "Wrong interest rate"]
      👁️  Def: internal
```
