# Function: _getBatchId(uint256)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_getBatchId(uint256)`
- **Visibility**: external
- **Source Range**: 3129:100:247

## Implementation

```solidity
function _getBatchId(uint256 i) external view returns (BatchId) {
    return _batchIds[i];
}
```

## State Variable Reads

- **_batchIds** (`BatchId[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._getBatchId(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
