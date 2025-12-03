# Function: _getBatchOf(TroveId)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_getBatchOf(TroveId)`
- **Visibility**: external
- **Source Range**: 3235:116:247

## Implementation

```solidity
function _getBatchOf(TroveId id) external view returns (BatchId batchId) {
    return _troves[id].batchId;
}
```

## State Variable Reads

- **_troves** (`mapping(TroveId => struct MockTroveManager.Trove)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._getBatchOf(TroveId) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
