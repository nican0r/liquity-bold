# Function: testSetDelegateRevertsIfTroveIsZombie()

**Contract**: [test/interestIndividualDelegation.t.sol/contract_InterestIndividualDelegationTest.md]

## Metadata

- **Contract**: InterestIndividualDelegationTest
- **Signature**: `testSetDelegateRevertsIfTroveIsZombie()`
- **Visibility**: public
- **Source Range**: 5641:768:305

## Implementation

```solidity
function testSetDelegateRevertsIfTroveIsZombie() public {
    vm.startPrank(B);
    borrowerOperations.registerBatchManager(1e16, 20e16, 5e16, 25e14, MIN_INTEREST_RATE_CHANGE_PERIOD);
    vm.stopPrank();
    uint256 troveId = openTroveNoHints100pct(A, 100e18, 5000e18, 5e16);
    redeem(A, 4000e18);
    assertEq(troveManager.checkTroveIsZombie(troveId), true, "A trove should be zombie");
    vm.startPrank(A);
    vm.expectRevert(BorrowerOperations.TroveNotActive.selector);
    borrowerOperations.setInterestIndividualDelegate(troveId, C, 1e16, 20e16, 0, 0, 0, 10000e18, 0);
    vm.stopPrank();
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

### redeem(address,uint256)

- **Kind**: internal
- **Source**: 13971:197:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:redeem(address,uint256)`

```solidity
function redeem(address _from, uint256 _boldAmount) public {
    vm.startPrank(_from);
    collateralRegistry.redeemCollateral(_boldAmount, MAX_UINT256, 1e18);
    vm.stopPrank();
}
```

### assertEq(bool,bool,string)

- **Kind**: internal
- **Source**: 2136:128:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bool,bool,string)`

```solidity
function assertEq(bool left, bool right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

## External Calls

- **Vm::startPrank(address)**
- **IBorrowerOperationsTester::registerBatchManager(uint128,uint128,uint128,uint128,uint128)**
- **Vm::stopPrank()**
- **ITroveManagerTester::checkTroveIsZombie(uint256)**
- **Vm::expectRevert(bytes4)**
- **IBorrowerOperationsTester::setInterestIndividualDelegate(uint256,address,uint128,uint128,uint256,uint256,uint256,uint256,uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestIndividualDelegationTest.testSetDelegateRevertsIfTroveIsZombie() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [A, 100e18, 5000e18, 5e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.redeem(address,uint256) (NodeID: 4)
  │   💬 Args: [A, 4000e18]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 5)
      💬 Args: [troveManager.checkTroveIsZombie(troveId), true, "A trove should be zombie"]
      👁️  Def: internal
```
