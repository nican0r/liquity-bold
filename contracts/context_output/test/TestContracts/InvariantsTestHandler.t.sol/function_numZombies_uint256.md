# Function: numZombies(uint256)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `numZombies(uint256)`
- **Visibility**: external
- **Source Range**: 14104:112:270

## Implementation

```solidity
function numZombies(uint256 i) external view returns (uint256) {
    return _zombieTroveIds[i].size();
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

- **_zombieTroveIds** (`mapping(uint256 => struct EnumerableSet)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.numZombies(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 1)
      💬 Args: [_zombieTroveIds[i]]
      👁️  Def: internal
```
