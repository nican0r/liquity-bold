# Function: callInternalRemoveTroveId(uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `callInternalRemoveTroveId(uint256)`
- **Visibility**: external
- **Source Range**: 5597:185:282

## Implementation

```solidity
function callInternalRemoveTroveId(uint256 _troveId) external {
    uint256 troveOwnersArrayLength = TroveIds.length;
    _removeTroveId(_troveId, troveOwnersArrayLength);
}
```

## Related Implementations

### _removeTroveId(uint256,uint256)

- **Kind**: internal
- **Source**: 53448:382:188
- **Link**: `src/TroveManager.sol:TroveManager:_removeTroveId(uint256,uint256)`

```solidity
function _removeTroveId(uint256 _troveId, uint256 TroveIdsArrayLength) internal {
    uint64 index = Troves[_troveId].arrayIndex;
    uint256 idxLast = TroveIdsArrayLength - 1;
    uint256 idToMove = TroveIds[idxLast];
    TroveIds[index] = idToMove;
    Troves[idToMove].arrayIndex = index;
    TroveIds.pop();
}
```

## State Variable Reads

- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)
- **TroveIds** (`uint256[]`)

## State Variable Writes

- **TroveIds** (`uint256[]`)
- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.callInternalRemoveTroveId(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: TroveManager._removeTroveId(uint256,uint256) (NodeID: 1)
      💬 Args: [_troveId, troveOwnersArrayLength]
      👁️  Def: internal
```
