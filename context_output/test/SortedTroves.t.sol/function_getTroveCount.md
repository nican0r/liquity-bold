# Function: getTroveCount()

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `getTroveCount()`
- **Visibility**: external
- **Source Range**: 983:97:247

## Implementation

```solidity
/// 
///  Partial implementation of TroveManager interface
///  Just the parts needed by SortedTroves
function getTroveCount() external view returns (uint256) {
    return _troveIds.length;
}
```

## State Variable Reads

- **_troveIds** (`TroveId[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager.getTroveCount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation


 Partial implementation of TroveManager interface
 Just the parts needed by SortedTroves
