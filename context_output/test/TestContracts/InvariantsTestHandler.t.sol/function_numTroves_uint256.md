# Function: numTroves(uint256)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `numTroves(uint256)`
- **Visibility**: public
- **Source Range**: 13995:103:270

## Implementation

```solidity
function numTroves(uint256 i) public view returns (uint256) {
    return _troveIds[i].size();
}
```

## Related Implementations

### size(struct EnumerableSet)

- **Kind**: internal
- **Source**: 647:153:288
- **Link**: `test/Utils/EnumerableSet.sol:EnumerableSetMethods:size(struct EnumerableSet)`

```solidity
function size(EnumerableSet storage set) internal view returns (uint256) {
    return (set._elements.length >= 1) ? (set._elements.length - 1) : 0;
}
```

## State Variable Reads

- **_troveIds** (`mapping(uint256 => struct EnumerableSet)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.numTroves(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 1)
      💬 Args: [_troveIds[i]]
      👁️  Def: internal
```
