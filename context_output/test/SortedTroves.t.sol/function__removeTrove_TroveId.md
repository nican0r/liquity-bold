# Function: _removeTrove(TroveId)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_removeTrove(TroveId)`
- **Visibility**: external
- **Source Range**: 2620:399:247

## Implementation

```solidity
function _removeTrove(TroveId id) external {
    TroveId poppedId = _troveIds[_troveIds.length - 1];
    _troveIds.pop();
    if (poppedId != id) {
        uint256 removedTroveArrayIndex = _troves[id].arrayIndex;
        _troveIds[removedTroveArrayIndex] = poppedId;
        _troves[poppedId].arrayIndex = removedTroveArrayIndex;
    }
    delete _troves[id];
}
```

## State Variable Reads

- **_troveIds** (`TroveId[]`)
- **_troves** (`mapping(TroveId => struct MockTroveManager.Trove)`)

## State Variable Writes

- **_troveIds** (`TroveId[]`)
- **_troves** (`mapping(TroveId => struct MockTroveManager.Trove)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._removeTrove(TroveId) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
