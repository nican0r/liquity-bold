# Function: _getBatchCount()

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_getBatchCount()`
- **Visibility**: external
- **Source Range**: 3025:98:247

## Implementation

```solidity
function _getBatchCount() external view returns (uint256) {
    return _batchIds.length;
}
```

## State Variable Reads

- **_batchIds** (`BatchId[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._getBatchCount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
