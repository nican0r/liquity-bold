# Function: testBatchLiquidationsRedistribution()

**Contract**: [test/liquidationCosts.t.sol/contract_LiquidationCostsTest.md]

## Metadata

- **Contract**: LiquidationCostsTest
- **Signature**: `testBatchLiquidationsRedistribution()`
- **Visibility**: public
- **Source Range**: 1443:1166:308

## Implementation

```solidity
function testBatchLiquidationsRedistribution() public {
    priceFeed.setPrice(2000e18);
    for (uint256 i = 0; i < N_TROVES; i++) {
        openTroveNoHints100pctWithIndex(A, i, 10 ether, 5000e18, 1e16);
    }
    uint256[] memory trovesToLiq = new uint256[](N_TROVES);
    for (uint256 i = 0; i < N_TROVES; i++) {
        uint256 troveId = openTroveNoHints100pctWithIndex(B, i, 219e16, 2000e18, 1e16);
        trovesToLiq[i] = troveId;
    }
    priceFeed.setPrice(1000e18);
    (uint256 price, ) = priceFeed.fetchPrice();
    assertEq(troveManager.checkBelowCriticalThreshold(price), false, "System should not be below CT");
    batchLiquidateTroves(A, trovesToLiq);
    for (uint256 i = 0; i < N_TROVES; i++) {
        assertEq(uint8(troveManager.getTroveStatus(trovesToLiq[i])), uint8(ITroveManager.Status.closedByLiquidation), "Trove should have been liquidated");
    }
}
```

## Related Implementations

### openTroveNoHints100pctWithIndex(address,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 7009:323:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:openTroveNoHints100pctWithIndex(address,uint256,uint256,uint256,uint256)`

```solidity
function openTroveNoHints100pctWithIndex(address _account, uint256 _index, uint256 _coll, uint256 _boldAmount, uint256 _annualInterestRate) public returns (uint256 troveId) {
    (troveId, ) = openTroveHelper(_account, _index, _coll, _boldAmount, _annualInterestRate);
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

### assertEq(bool,bool,string)

- **Kind**: internal
- **Source**: 2136:128:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bool,bool,string)`

```solidity
function assertEq(bool left, bool right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### batchLiquidateTroves(address,uint256[])

- **Kind**: internal
- **Source**: 13766:199:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:batchLiquidateTroves(address,uint256[])`

```solidity
function batchLiquidateTroves(address _from, uint256[] memory _trovesList) public {
    vm.startPrank(_from);
    troveManager.batchLiquidateTroves(_trovesList);
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

## External Calls

- **IPriceFeedTestnet::setPrice(uint256)**
- **IPriceFeedTestnet::fetchPrice()**
- **ITroveManagerTester::checkBelowCriticalThreshold(uint256)**
- **ITroveManagerTester::getTroveStatus(uint256)**

## State Variable Reads

- **N_TROVES** (`uint256`)
- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **troveManager** (`contract ITroveManagerTester`) [test/TestContracts/Interfaces/ITroveManagerTester.sol/interface_ITroveManagerTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LiquidationCostsTest.testBatchLiquidationsRedistribution() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pctWithIndex(address,uint256,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [A, i, 10 ether, 5000e18, 1e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [_account, _index, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pctWithIndex(address,uint256,uint256,uint256,uint256) (NodeID: 4)
  │   💬 Args: [B, i, 219e16, 2000e18, 1e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 5)
  │     💬 Args: [_account, _index, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 6)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 7)
  │   💬 Args: [troveManager.checkBelowCriticalThreshold(price), false, "System should not be below CT"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.batchLiquidateTroves(address,uint256[]) (NodeID: 8)
  │   💬 Args: [A, trovesToLiq]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 9)
      💬 Args: [uint8(troveManager.getTroveStatus(trovesToLiq[i])), uint8(ITroveManager.Status.closedByLiquidation), "Trove should have been liquidated"]
      👁️  Def: internal
```
