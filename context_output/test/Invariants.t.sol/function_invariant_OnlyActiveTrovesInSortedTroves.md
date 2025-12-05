# Function: invariant_OnlyActiveTrovesInSortedTroves()

**Contract**: [test/Invariants.t.sol/contract_InvariantsTest.md]

## Metadata

- **Contract**: InvariantsTest
- **Signature**: `invariant_OnlyActiveTrovesInSortedTroves()`
- **Visibility**: external
- **Source Range**: 9887:1008:243

## Implementation

```solidity
function invariant_OnlyActiveTrovesInSortedTroves() external view {
    for (uint256 j = 0; j < branches.length; ++j) {
        TestDeployer.LiquityContractsDev memory c = branches[j];
        uint256 numTroves = c.troveManager.getTroveIdsCount();
        for (uint256 i = 0; i < numTroves; ++i) {
            uint256 troveId = c.troveManager.getTroveFromTroveIdsArray(i);
            ITroveManager.Status status = c.troveManager.getTroveStatus(troveId);
            assertTrue((status == ITroveManager.Status.active) || (status == ITroveManager.Status.zombie), "Unexpected status");
            if (status == ITroveManager.Status.active) {
                assertTrue(c.sortedTroves.contains(troveId), "SortedTroves should contain active Troves");
            } else {
                assertFalse(c.sortedTroves.contains(troveId), "SortedTroves shouldn't contain zombie Troves");
            }
        }
    }
}
```

## Related Implementations

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1689:113:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    vm.assertTrue(data, err);
}
```

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 1905:115:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    vm.assertFalse(data, err);
}
```

## External Calls

- **ITroveManagerTester::getTroveIdsCount()**
- **ITroveManagerTester::getTroveFromTroveIdsArray(uint256)**
- **ITroveManagerTester::getTroveStatus(uint256)**
- **ISortedTroves::contains(uint256)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTest.invariant_OnlyActiveTrovesInSortedTroves() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [(status == ITroveManager.Status.active) || (status == ITroveManager.Status.zombie), "Unexpected status"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [c.sortedTroves.contains(troveId), "SortedTroves should contain active Troves"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 3)
      💬 Args: [c.sortedTroves.contains(troveId), "SortedTroves shouldn't contain zombie Troves"]
      👁️  Def: internal
```
