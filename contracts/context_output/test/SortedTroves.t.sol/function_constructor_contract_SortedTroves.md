# Function: constructor(contract SortedTroves)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `constructor(contract SortedTroves)`
- **Visibility**: public
- **Source Range**: 773:84:247

## Implementation

```solidity
constructor(SortedTroves sortedTroves) {
    _sortedTroves = sortedTroves;
}
```

## State Variable Writes

- **_sortedTroves** (`contract SortedTroves`) [src/SortedTroves.sol/contract_SortedTroves.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockTroveManager.constructor(contract SortedTroves) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockTroveManager
```
