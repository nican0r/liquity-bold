# Function: troveIsStale(uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `troveIsStale(uint256)`
- **Visibility**: external
- **Source Range**: 10511:415:282

## Implementation

```solidity
function troveIsStale(uint256 _troveId) external view returns (bool) {
    Trove memory trove = Troves[_troveId];
    address batchAddress = _getBatchManager(trove);
    if (batchAddress != address(0)) {
        return (block.timestamp - batches[batchAddress].lastDebtUpdateTime) > STALE_TROVE_DURATION;
    }
    return (block.timestamp - trove.lastDebtUpdateTime) > STALE_TROVE_DURATION;
}
```

## Related Implementations

### _getBatchManager(struct TroveManager.Trove)

- **Kind**: internal
- **Source**: 47706:128:188
- **Link**: `src/TroveManager.sol:TroveManager:_getBatchManager(struct TroveManager.Trove)`

```solidity
function _getBatchManager(Trove memory trove) internal pure returns (address) {
    return trove.interestBatchManager;
}
```

## State Variable Reads

- **STALE_TROVE_DURATION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.troveIsStale(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: TroveManager._getBatchManager(struct TroveManager.Trove) (NodeID: 1)
      💬 Args: [trove]
      👁️  Def: internal
```
