# Function: getTroveIdFromBatch(uint256,address,uint256)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `getTroveIdFromBatch(uint256,address,uint256)`
- **Visibility**: external
- **Source Range**: 15667:168:270

## Implementation

```solidity
function getTroveIdFromBatch(uint256 i, address batchManager, uint256 j) external view returns (uint256) {
    return _batches[i][batchManager].troves.get(j);
}
```

## Related Implementations

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

- **_batches** (`mapping(uint256 => mapping(address => struct InvariantsTestHandler.Batch))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.getTroveIdFromBatch(uint256,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: EnumerableSetMethods.get(struct EnumerableSet,uint256) (NodeID: 1)
      💬 Args: [_batches[i][batchManager].troves, j]
      👁️  Def: internal
```
