# Function: getGasPool(uint256)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `getGasPool(uint256)`
- **Visibility**: external
- **Source Range**: 15966:122:270

## Implementation

```solidity
function getGasPool(uint256 i) external view returns (uint256) {
    return numTroves(i) * ETH_GAS_COMPENSATION;
}
```

## Related Implementations

### numTroves(uint256)

- **Kind**: internal
- **Source**: 13995:103:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:numTroves(uint256)`

```solidity
function numTroves(uint256 i) public view returns (uint256) {
    return _troveIds[i].size();
}
```

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
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.getGasPool(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: InvariantsTestHandler.numTroves(uint256) (NodeID: 1)
      💬 Args: [i]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 2)
        💬 Args: [_troveIds[i]]
        👁️  Def: internal
```
