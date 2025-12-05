# Function: _addIndividualTrove(uint256)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_addIndividualTrove(uint256)`
- **Visibility**: external
- **Source Range**: 1769:197:247

## Implementation

```solidity
function _addIndividualTrove(uint256 annualInterestRate) external returns (TroveId id) {
    _troves[id = _allocateTroveId()] = Trove(_troveIds.length, annualInterestRate, BATCH_ID_ZERO);
}
```

## Related Implementations

### _allocateTroveId()

- **Kind**: internal
- **Source**: 1500:124:247
- **Link**: `test/SortedTroves.t.sol:MockTroveManager:_allocateTroveId()`

```solidity
/// 
///  Mock-only functions
function _allocateTroveId() internal returns (TroveId id) {
    _troveIds.push(id = TroveId.wrap(_nextTroveId++));
}
```

## State Variable Reads

- **_troveIds** (`TroveId[]`)

## State Variable Writes

- **_troves** (`mapping(TroveId => struct MockTroveManager.Trove)`)
- **_troveIds** (`TroveId[]`)
- **_nextTroveId** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._addIndividualTrove(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: MockTroveManager._allocateTroveId() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
