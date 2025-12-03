# Function: getBatchSize(uint256,address)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `getBatchSize(uint256,address)`
- **Visibility**: external
- **Source Range**: 15511:150:270

## Implementation

```solidity
function getBatchSize(uint256 i, address batchManager) external view returns (uint256) {
    return _batches[i][batchManager].troves.size();
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

- **_batches** (`mapping(uint256 => mapping(address => struct InvariantsTestHandler.Batch))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.getBatchSize(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: EnumerableSetMethods.size(struct EnumerableSet) (NodeID: 1)
      💬 Args: [_batches[i][batchManager].troves]
      👁️  Def: internal
```
