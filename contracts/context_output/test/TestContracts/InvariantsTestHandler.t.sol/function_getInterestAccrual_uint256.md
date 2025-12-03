# Function: getInterestAccrual(uint256)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `getInterestAccrual(uint256)`
- **Visibility**: external
- **Source Range**: 16470:295:270

## Implementation

```solidity
function getInterestAccrual(uint256 i) external view returns (uint256 interestAccrual) {
    for (uint256 j = 0; j < _troveIds[i].size(); ++j) {
        Trove storage trove = _troves[i][_troveIds[i].get(j)];
        interestAccrual += trove.debt * trove.interestRate;
    }
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

### get(struct EnumerableSet,uint256)

- **Kind**: internal
- **Source**: 514:127:288
- **Link**: `test/Utils/EnumerableSet.sol:EnumerableSetMethods:get(struct EnumerableSet,uint256)`

```solidity
function get(EnumerableSet storage set, uint256 i) internal view returns (uint256) {
    return set._elements[i + 1];
}
```

## State Variable Reads

- **_troveIds** (`mapping(uint256 => struct EnumerableSet)`)
- **_troves** (`mapping(uint256 => mapping(uint256 => struct Trove))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.getInterestAccrual(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 1)
  │   💬 Args: [_troveIds[i]]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 2)
      💬 Args: [_troveIds[i], j]
      👁️  Def: internal
```
