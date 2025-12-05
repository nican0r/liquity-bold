# Function: invariant_AllBoldBackedByTroveDebt()

**Contract**: [test/Invariants.t.sol/contract_InvariantsTest.md]

## Metadata

- **Contract**: InvariantsTest
- **Signature**: `invariant_AllBoldBackedByTroveDebt()`
- **Visibility**: external
- **Source Range**: 10901:1628:243

## Implementation

```solidity
function invariant_AllBoldBackedByTroveDebt() external view {
    uint256 totalBold = boldToken.totalSupply();
    uint256 totalPendingInterest = 0;
    uint256 totalPendingBatchManagementFees = 0;
    uint256 totalDebt = 0;
    for (uint256 j = 0; j < branches.length; ++j) {
        TestDeployer.LiquityContractsDev memory c = branches[j];
        uint256 numTroves = c.troveManager.getTroveIdsCount();
        totalPendingInterest += c.activePool.calcPendingAggInterest();
        totalPendingBatchManagementFees += c.activePool.aggBatchManagementFees();
        totalPendingBatchManagementFees += c.activePool.calcPendingAggBatchManagementFee();
        for (uint256 i = 0; i < numTroves; ++i) {
            uint256 troveId = c.troveManager.getTroveFromTroveIdsArray(i);
            uint256 debt = c.troveManager.getTroveEntireDebt(troveId);
            totalDebt += debt;
        }
    }
    assertApproxEqAbsDecimal((totalBold + totalPendingInterest) + totalPendingBatchManagementFees, totalDebt, 1e-10 ether, 18, "Total Bold !~= total debt");
}
```

## Related Implementations

### assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 17272:268:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)`

```solidity
function assertApproxEqAbsDecimal(uint256 left, uint256 right, uint256 maxDelta, uint256 decimals, string memory err) virtual internal pure {
    vm.assertApproxEqAbsDecimal(left, right, maxDelta, decimals, err);
}
```

## External Calls

- **IBoldToken::totalSupply()**
- **ITroveManagerTester::getTroveIdsCount()**
- **IActivePool::calcPendingAggInterest()**
- **IActivePool::aggBatchManagementFees()**
- **IActivePool::calcPendingAggBatchManagementFee()**
- **ITroveManagerTester::getTroveFromTroveIdsArray(uint256)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTest.invariant_AllBoldBackedByTroveDebt() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 1)
      💬 Args: [(totalBold + totalPendingInterest) + totalPendingBatchManagementFees, totalDebt, 1e-10 ether, 18, "Total Bold !~= total debt"]
      👁️  Def: internal
```
