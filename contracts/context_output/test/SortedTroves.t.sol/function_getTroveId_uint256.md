# Function: getTroveId(uint256)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `getTroveId(uint256)`
- **Visibility**: external
- **Source Range**: 1086:99:247

## Implementation

```solidity
function getTroveId(uint256 i) external view returns (TroveId) {
    return _troveIds[i];
}
```

## State Variable Reads

- **_troveIds** (`TroveId[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager.getTroveId(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
