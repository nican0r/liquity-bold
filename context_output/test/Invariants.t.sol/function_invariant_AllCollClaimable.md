# Function: invariant_AllCollClaimable()

**Contract**: [test/Invariants.t.sol/contract_InvariantsTest.md]

## Metadata

- **Contract**: InvariantsTest
- **Signature**: `invariant_AllCollClaimable()`
- **Visibility**: external
- **Source Range**: 12535:654:243

## Implementation

```solidity
function invariant_AllCollClaimable() external view {
    for (uint256 j = 0; j < branches.length; ++j) {
        ITroveManagerTester troveManager = branches[j].troveManager;
        uint256 numTroves = troveManager.getTroveIdsCount();
        uint256 systemColl = troveManager.getEntireBranchColl();
        uint256 trovesColl = 0;
        for (uint256 i = 0; i < numTroves; ++i) {
            trovesColl += troveManager.getTroveEntireColl(troveManager.getTroveFromTroveIdsArray(i));
        }
        assertApproxEqAbsDecimal(systemColl, trovesColl, 1e-10 ether, 18, "System coll !~= Troves coll");
    }
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

- **ITroveManagerTester::getTroveIdsCount()**
- **ITroveManagerTester::getEntireBranchColl()**
- **ITroveManagerTester::getTroveEntireColl(uint256)**
- **ITroveManagerTester::getTroveFromTroveIdsArray(uint256)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTest.invariant_AllCollClaimable() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 1)
      💬 Args: [systemColl, trovesColl, 1e-10 ether, 18, "System coll !~= Troves coll"]
      👁️  Def: internal
```
