# Function: troveIdOf(uint256,address)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `troveIdOf(uint256,address)`
- **Visibility**: external
- **Source Range**: 14222:121:270

## Implementation

```solidity
function troveIdOf(uint256 i, address owner) external view returns (uint256) {
    return _troveIdOf(i, owner);
}
```

## Related Implementations

### _troveIdOf(uint256,address)

- **Kind**: internal
- **Source**: 109113:171:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_troveIdOf(uint256,address)`

```solidity
function _troveIdOf(uint256 i, address owner) internal view returns (uint256) {
    return uint256(keccak256(abi.encode(owner, owner, _troveIndexOf[i][owner])));
}
```

## State Variable Reads

- **_troveIndexOf** (`mapping(uint256 => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.troveIdOf(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: InvariantsTestHandler._troveIdOf(uint256,address) (NodeID: 1)
      💬 Args: [i, owner]
      👁️  Def: internal
```
