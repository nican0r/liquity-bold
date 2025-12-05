# Function: invariant_SystemStateMatchesGhostState()

**Contract**: [test/Invariants.t.sol/contract_InvariantsTest.md]

## Metadata

- **Contract**: InvariantsTest
- **Signature**: `invariant_SystemStateMatchesGhostState()`
- **Visibility**: external
- **Source Range**: 5532:4349:243

## Implementation

```solidity
function invariant_SystemStateMatchesGhostState() external view {
    for (uint256 i = 0; i < branches.length; ++i) {
        TestDeployer.LiquityContractsDev memory c = branches[i];
        assertEq(c.troveManager.getTroveIdsCount(), handler.numTroves(i), "Wrong number of Troves");
        assertEq(c.troveManager.lastZombieTroveId(), handler.designatedVictimId(i), "Wrong designated victim");
        assertEq(c.sortedTroves.getSize(), handler.numTroves(i) - handler.numZombies(i), "Wrong SortedTroves size");
        assertApproxEqAbsDecimal(c.activePool.calcPendingAggInterest(), handler.getPendingInterest(i), Math.max(handler.totalDebtRedist(i) / 1e15, 1e3), 18, "Wrong interest");
        assertApproxEqAbsDecimal(c.activePool.aggWeightedDebtSum(), handler.getInterestAccrual(i), Math.max(handler.totalDebtRedist(i) * 1e9, 1e22), 36, "Wrong interest accrual");
        assertApproxEqAbsDecimal(c.activePool.aggWeightedBatchManagementFeeSum(), handler.getBatchManagementFeeAccrual(i), Math.max(handler.totalDebtRedist(i) * 1e9, 1e22), 36, "Wrong batch management fee accrual");
        assertEqDecimal(weth.balanceOf(address(c.pools.gasPool)), handler.getGasPool(i), 18, "Wrong GasPool");
        assertApproxEqAbsDecimal(c.pools.collSurplusPool.getCollBalance(), handler.collSurplus(i), 10, 18, "Wrong CollSurplusPool");
        assertApproxEqAbsDecimal(c.stabilityPool.getTotalBoldDeposits(), handler.spBoldDeposits(i), 100, 18, "Wrong StabilityPool deposits");
        assertEqDecimal(c.stabilityPool.getYieldGainsOwed() + c.stabilityPool.getYieldGainsPending(), handler.spBoldYield(i), 18, "Wrong StabilityPool yield");
        assertApproxEqAbsDecimal(c.stabilityPool.getCollBalance(), handler.spColl(i), 10, 18, "Wrong StabilityPool coll");
        for (uint256 j = 0; j < handler.numTroves(i); ++j) {
            (uint256 troveId, uint256 coll, uint256 debt, ITroveManager.Status status, address batchManager, uint256 totalCollRedist, uint256 totalDebtRedist) = handler.getTrove(i, j);
            LatestTroveData memory t = c.troveManager.getLatestTroveData(troveId);
            assertApproxEqAbsDecimal(t.entireColl, coll, Math.max(totalCollRedist / 1e6, 1e5), 18, "Wrong Trove coll");
            assertApproxEqAbsDecimal(t.entireDebt, debt, Math.max(totalDebtRedist / 1e6, 1e5), 18, "Wrong Trove debt");
            assertEq(c.troveManager.getTroveStatus(troveId).toString(), status.toString(), "Wrong Trove status");
            assertEq(c.troveManager.getBatchManager(troveId), batchManager, "Wrong batch manager (TM)");
            assertEq(c.borrowerOperations.interestBatchManagerOf(troveId), batchManager, "Wrong batch manager (BO)");
            if (status == ITroveManager.Status.active) {
                assertEq(BatchId.unwrap(c.sortedTroves.getBatchOf(troveId)), batchManager, "Wrong batch manager (ST)");
            }
        }
        for (uint256 j = 0; j < actors.length; ++j) {
            LatestBatchData memory b = c.troveManager.getLatestBatchData(actors[j].account);
            assertApproxEq(b.accruedManagementFee, handler.getPendingBatchManagementFee(i, actors[j].account), 1e7, "Wrong batch management fee");
        }
    }
    assertEqDecimal(collateralRegistry.getRedemptionRateWithDecay(), handler.getRedemptionRate(), 18, "Wrong redemption rate");
}
```

## Related Implementations

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 17272:268:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)`

```solidity
function assertApproxEqAbsDecimal(uint256 left, uint256 right, uint256 maxDelta, uint256 decimals, string memory err) virtual internal pure {
    vm.assertApproxEqAbsDecimal(left, right, maxDelta, decimals, err);
}
```

### max(uint256,uint256)

- **Kind**: internal
- **Source**: 413:104:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:max(uint256,uint256)`

```solidity
///  @dev Returns the largest of two numbers.
function max(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a > b) ? a : b;
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

### assertEq(string,string,string)

- **Kind**: internal
- **Source**: 4348:146:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(string,string,string)`

```solidity
function assertEq(string memory left, string memory right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### toString(enum ITroveManager.Status)

- **Kind**: internal
- **Source**: 1879:621:243
- **Link**: `test/Invariants.t.sol:ToStringFunctions:toString(enum ITroveManager.Status)`

```solidity
function toString(ITroveManager.Status status) internal pure returns (string memory) {
    if (status == ITroveManager.Status.nonExistent) return "ITroveManager.Status.nonExistent";
    if (status == ITroveManager.Status.active) return "ITroveManager.Status.active";
    if (status == ITroveManager.Status.closedByOwner) return "ITroveManager.Status.closedByOwner";
    if (status == ITroveManager.Status.closedByLiquidation) return "ITroveManager.Status.closedByLiquidation";
    if (status == ITroveManager.Status.zombie) return "ITroveManager.Status.zombie";
    revert("Invalid status");
}
```

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 3570:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### assertApproxEq(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 1082:302:250
- **Link**: `test/TestContracts/Assertions.sol:Assertions:assertApproxEq(uint256,uint256,uint256,string)`

```solidity
function assertApproxEq(uint256 a, uint256 b, uint256 maxPercentDelta, string memory err) internal pure {
    if (b < 1e18) {
        assertApproxEqAbsDecimal(a, b, maxPercentDelta, 18, err);
    } else {
        assertApproxEqRelDecimal(a, b, maxPercentDelta, 18, err);
    }
}
```

### assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 19242:338:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string)`

```solidity
function assertApproxEqRelDecimal(uint256 left, uint256 right, uint256 maxPercentDelta, uint256 decimals, string memory err) virtual internal pure {
    vm.assertApproxEqRelDecimal(left, right, maxPercentDelta, decimals, err);
}
```

## External Calls

- **ITroveManagerTester::getTroveIdsCount()**
- **InvariantsTestHandler::numTroves(uint256)**
- **ITroveManagerTester::lastZombieTroveId()**
- **InvariantsTestHandler::designatedVictimId(uint256)**
- **ISortedTroves::getSize()**
- **InvariantsTestHandler::numZombies(uint256)**
- **IActivePool::calcPendingAggInterest()**
- **InvariantsTestHandler::getPendingInterest(uint256)**
- **InvariantsTestHandler::totalDebtRedist(uint256)**
- **IActivePool::aggWeightedDebtSum()**
- **InvariantsTestHandler::getInterestAccrual(uint256)**
- **IActivePool::aggWeightedBatchManagementFeeSum()**
- **InvariantsTestHandler::getBatchManagementFeeAccrual(uint256)**
- **IERC20::balanceOf(address)**
- **InvariantsTestHandler::getGasPool(uint256)**
- **ICollSurplusPool::getCollBalance()**
- **InvariantsTestHandler::collSurplus(uint256)**
- **IStabilityPool::getTotalBoldDeposits()**
- **InvariantsTestHandler::spBoldDeposits(uint256)**
- **IStabilityPool::getYieldGainsOwed()**
- **IStabilityPool::getYieldGainsPending()**
- **InvariantsTestHandler::spBoldYield(uint256)**
- **IStabilityPool::getCollBalance()**
- **InvariantsTestHandler::spColl(uint256)**
- **InvariantsTestHandler::getTrove(uint256,uint256)**
- **ITroveManagerTester::getLatestTroveData(uint256)**
- **ITroveManagerTester::getTroveStatus(uint256)**
- **ITroveManagerTester::getBatchManager(contract ITroveManager,uint256)**
- **IBorrowerOperationsTester::interestBatchManagerOf(uint256)**
- **ISortedTroves::getBatchOf(contract ISortedTroves,uint256)**
- **ITroveManagerTester::getLatestBatchData(address)**
- **InvariantsTestHandler::getPendingBatchManagementFee(uint256,address)**
- **ICollateralRegistry::getRedemptionRateWithDecay()**
- **InvariantsTestHandler::getRedemptionRate()**

## State Variable Reads

- **handler** (`contract InvariantsTestHandler`) [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTest.invariant_SystemStateMatchesGhostState() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [c.troveManager.getTroveIdsCount(), handler.numTroves(i), "Wrong number of Troves"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [c.troveManager.lastZombieTroveId(), handler.designatedVictimId(i), "Wrong designated victim"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [c.sortedTroves.getSize(), handler.numTroves(i) - handler.numZombies(i), "Wrong SortedTroves size"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [c.activePool.calcPendingAggInterest(), handler.getPendingInterest(i), Math.max(handler.totalDebtRedist(i) / 1e15, 1e3), 18, "Wrong interest"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.max(uint256,uint256) (NodeID: 5)
  │     💬 Args: [handler.totalDebtRedist(i) / 1e15, 1e3]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 6)
  │   💬 Args: [c.activePool.aggWeightedDebtSum(), handler.getInterestAccrual(i), Math.max(handler.totalDebtRedist(i) * 1e9, 1e22), 36, "Wrong interest accrual"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.max(uint256,uint256) (NodeID: 7)
  │     💬 Args: [handler.totalDebtRedist(i) * 1e9, 1e22]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 8)
  │   💬 Args: [c.activePool.aggWeightedBatchManagementFeeSum(), handler.getBatchManagementFeeAccrual(i), Math.max(handler.totalDebtRedist(i) * 1e9, 1e22), 36, "Wrong batch management fee accrual"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.max(uint256,uint256) (NodeID: 9)
  │     💬 Args: [handler.totalDebtRedist(i) * 1e9, 1e22]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 10)
  │   💬 Args: [weth.balanceOf(address(c.pools.gasPool)), handler.getGasPool(i), 18, "Wrong GasPool"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 11)
  │   💬 Args: [c.pools.collSurplusPool.getCollBalance(), handler.collSurplus(i), 10, 18, "Wrong CollSurplusPool"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 12)
  │   💬 Args: [c.stabilityPool.getTotalBoldDeposits(), handler.spBoldDeposits(i), 100, 18, "Wrong StabilityPool deposits"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 13)
  │   💬 Args: [c.stabilityPool.getYieldGainsOwed() + c.stabilityPool.getYieldGainsPending(), handler.spBoldYield(i), 18, "Wrong StabilityPool yield"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 14)
  │   💬 Args: [c.stabilityPool.getCollBalance(), handler.spColl(i), 10, 18, "Wrong StabilityPool coll"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 15)
  │   💬 Args: [t.entireColl, coll, Math.max(totalCollRedist / 1e6, 1e5), 18, "Wrong Trove coll"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.max(uint256,uint256) (NodeID: 16)
  │     💬 Args: [totalCollRedist / 1e6, 1e5]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 17)
  │   💬 Args: [t.entireDebt, debt, Math.max(totalDebtRedist / 1e6, 1e5), 18, "Wrong Trove debt"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.max(uint256,uint256) (NodeID: 18)
  │     💬 Args: [totalDebtRedist / 1e6, 1e5]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string,string) (NodeID: 19)
  │   💬 Args: [c.troveManager.getTroveStatus(troveId).toString(), status.toString(), "Wrong Trove status"]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ToStringFunctions.toString(enum ITroveManager.Status) (NodeID: 20)
  │ │   💬 Args: [c.troveManager.getTroveStatus(troveId)]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ToStringFunctions.toString(enum ITroveManager.Status) (NodeID: 21)
  │     💬 Args: [status]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 22)
  │   💬 Args: [c.troveManager.getBatchManager(troveId), batchManager, "Wrong batch manager (TM)"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 23)
  │   💬 Args: [c.borrowerOperations.interestBatchManagerOf(troveId), batchManager, "Wrong batch manager (BO)"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 24)
  │   💬 Args: [BatchId.unwrap(c.sortedTroves.getBatchOf(troveId)), batchManager, "Wrong batch manager (ST)"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Assertions.assertApproxEq(uint256,uint256,uint256,string) (NodeID: 25)
  │   💬 Args: [b.accruedManagementFee, handler.getPendingBatchManagementFee(i, actors[j].account), 1e7, "Wrong batch management fee"]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 26)
  │ │   💬 Args: [a, b, maxPercentDelta, 18, err]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 27)
  │     💬 Args: [a, b, maxPercentDelta, 18, err]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 28)
      💬 Args: [collateralRegistry.getRedemptionRateWithDecay(), handler.getRedemptionRate(), 18, "Wrong redemption rate"]
      👁️  Def: internal
```
