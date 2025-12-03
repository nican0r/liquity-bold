# Function: add(BatchId)

**Contract**: [test/SortedTroves.t.sol/contract_BatchIdSet.md]

## Metadata

- **Contract**: BatchIdSet
- **Signature**: `add(BatchId)`
- **Visibility**: external
- **Source Range**: 7441:65:247

## Implementation

```solidity
function add(BatchId id) external {
    has[id] = true;
}
```

## State Variable Writes

- **has** (`mapping(BatchId => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BatchIdSet.add(BatchId) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
