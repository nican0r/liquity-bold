# Function: _addBatch(uint256)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_addBatch(uint256)`
- **Visibility**: external
- **Source Range**: 2138:155:247

## Implementation

```solidity
function _addBatch(uint256 annualInterestRate) external returns (BatchId id) {
    _batches[id = _allocateBatchId()] = Batch(annualInterestRate);
}
```

## Related Implementations

### _allocateBatchId()

- **Kind**: internal
- **Source**: 1630:133:247
- **Link**: `test/SortedTroves.t.sol:MockTroveManager:_allocateBatchId()`

```solidity
function _allocateBatchId() internal returns (BatchId id) {
    _batchIds.push(id = BatchId.wrap(address(_nextBatchId++)));
}
```

## State Variable Writes

- **_batches** (`mapping(BatchId => struct MockTroveManager.Batch)`)
- **_batchIds** (`BatchId[]`)
- **_nextBatchId** (`uint160`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._addBatch(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: MockTroveManager._allocateBatchId() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
