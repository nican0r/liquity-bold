# Function: invariant_SortedTroves_OrderedByInterestRate()

**Contract**: [test/Invariants.t.sol/contract_InvariantsTest.md]

## Metadata

- **Contract**: InvariantsTest
- **Signature**: `invariant_SortedTroves_OrderedByInterestRate()`
- **Visibility**: external
- **Source Range**: 15119:1915:243

## Implementation

```solidity
function invariant_SortedTroves_OrderedByInterestRate() external view {
    for (uint256 j = 0; j < branches.length; ++j) {
        ITroveManager troveManager = branches[j].troveManager;
        ISortedTroves sortedTroves = branches[j].sortedTroves;
        uint256 i = 0;
        uint256 size = sortedTroves.getSize();
        uint256[] memory troveIds = new uint256[](size);
        uint256 curr = sortedTroves.getFirst();
        if (curr == 0) {
            assertEq(size, 0, "SortedTroves forward node count doesn't match size");
            assertEq(sortedTroves.getLast(), 0, "SortedTroves reverse node count doesn't match size");
            continue;
        }
        troveIds[i++] = curr;
        uint256 prevAnnualInterestRate = troveManager.getTroveAnnualInterestRate(curr);
        curr = sortedTroves.getNext(curr);
        while (curr != 0) {
            uint256 currAnnualInterestRate = troveManager.getTroveAnnualInterestRate(curr);
            assertLeDecimal(currAnnualInterestRate, prevAnnualInterestRate, 18, "SortedTroves ordering is broken");
            troveIds[i++] = curr;
            prevAnnualInterestRate = currAnnualInterestRate;
            curr = sortedTroves.getNext(curr);
        }
        assertEq(i, size, "SortedTroves forward node count doesn't match size");
        curr = sortedTroves.getLast();
        while (i > 0) {
            assertNotEq(curr, 0, "SortedTroves reverse node count doesn't match size");
            assertEq(curr, troveIds[--i], "SortedTroves reverse ordering is broken");
            curr = sortedTroves.getPrev(curr);
        }
        assertEq(curr, 0, "SortedTroves reverse node count doesn't match size");
    }
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

### assertLeDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 14710:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLeDecimal(uint256,uint256,uint256,string)`

```solidity
function assertLeDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertLeDecimal(left, right, decimals, err);
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

- **ISortedTroves::getSize()**
- **ISortedTroves::getFirst()**
- **ISortedTroves::getLast()**
- **ITroveManager::getTroveAnnualInterestRate(uint256)**
- **ISortedTroves::getNext(uint256)**
- **ISortedTroves::getPrev(uint256)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTest.invariant_SortedTroves_OrderedByInterestRate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [size, 0, "SortedTroves forward node count doesn't match size"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [sortedTroves.getLast(), 0, "SortedTroves reverse node count doesn't match size"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLeDecimal(uint256,uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [currAnnualInterestRate, prevAnnualInterestRate, 18, "SortedTroves ordering is broken"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [i, size, "SortedTroves forward node count doesn't match size"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [curr, 0, "SortedTroves reverse node count doesn't match size"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
  │   💬 Args: [curr, troveIds[--i], "SortedTroves reverse ordering is broken"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
      💬 Args: [curr, 0, "SortedTroves reverse node count doesn't match size"]
      👁️  Def: internal
```
