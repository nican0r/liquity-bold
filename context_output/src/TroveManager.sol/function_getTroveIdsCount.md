# Function: getTroveIdsCount()

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `getTroveIdsCount()`
- **Visibility**: external
- **Source Range**: 8366:108:188

## Implementation

```solidity
function getTroveIdsCount() override external view returns (uint256) {
    return TroveIds.length;
}
```

## State Variable Reads

- **TroveIds** (`uint256[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.getTroveIdsCount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
