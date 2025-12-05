# Function: getTroveLastDebtUpdateTime(uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `getTroveLastDebtUpdateTime(uint256)`
- **Visibility**: external
- **Source Range**: 10155:350:282

## Implementation

```solidity
function getTroveLastDebtUpdateTime(uint256 _troveId) external view returns (uint256) {
    Trove memory trove = Troves[_troveId];
    address batchAddress = _getBatchManager(trove);
    if (batchAddress != address(0)) {
        return batches[batchAddress].lastDebtUpdateTime;
    }
    return trove.lastDebtUpdateTime;
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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.getTroveLastDebtUpdateTime(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: TroveManager._getBatchManager(struct TroveManager.Trove) (NodeID: 1)
      💬 Args: [trove]
      👁️  Def: internal
```
