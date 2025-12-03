# Function: test_GetApproxHintNeverReturnsZombies(uint256)

**Contract**: [test/HintHelpers.t.sol/contract_HintHelpersTest.md]

## Metadata

- **Contract**: HintHelpersTest
- **Signature**: `test_GetApproxHintNeverReturnsZombies(uint256)`
- **Visibility**: external
- **Source Range**: 148:902:233

## Implementation

```solidity
function test_GetApproxHintNeverReturnsZombies(uint256 seed) external {
    for (uint256 i = 1; i <= 10; ++i) {
        openTroveHelper(A, i, 100 ether, 10_000 ether, i * 0.01 ether);
    }
    uint256 redeemedTroveId = sortedTroves.getLast();
    uint256 redeemable = troveManager.getTroveEntireDebt(redeemedTroveId);
    redeem(A, redeemable);
    assertEq(uint8(troveManager.getTroveStatus(redeemedTroveId)), uint8(ITroveManager.Status.zombie), "Redeemed Trove should have become a zombie");
    uint256 interestRate = troveManager.getTroveAnnualInterestRate(redeemedTroveId) + 1;
    (uint256 hintId, , ) = hintHelpers.getApproxHint(0, interestRate, 10, seed);
    assertNotEq(hintId, redeemedTroveId, "Zombies should not be hints");
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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### assertNotEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 7308:140:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertNotEq(uint256,uint256,string)`

```solidity
function assertNotEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertNotEq(left, right, err);
}
```

## External Calls

- **ISortedTroves::getLast()**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **ITroveManagerTester::getTroveStatus(uint256)**
- **ITroveManagerTester::getTroveAnnualInterestRate(uint256)**
- **HintHelpers::getApproxHint(uint256,uint256,uint256,uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HintHelpersTest.test_GetApproxHintNeverReturnsZombies(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [A, i, 100 ether, 10_000 ether, i * 0.01 ether]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 2)
  │     💬 Args: [_boldAmount, _annualInterestRate]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.redeem(address,uint256) (NodeID: 3)
  │   💬 Args: [A, redeemable]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [uint8(troveManager.getTroveStatus(redeemedTroveId)), uint8(ITroveManager.Status.zombie), "Redeemed Trove should have become a zombie"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(uint256,uint256,string) (NodeID: 5)
      💬 Args: [hintId, redeemedTroveId, "Zombies should not be hints"]
      👁️  Def: internal
```
