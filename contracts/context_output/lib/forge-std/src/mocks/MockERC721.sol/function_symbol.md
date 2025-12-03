# Function: symbol()

**Contract**: [lib/forge-std/src/mocks/MockERC721.sol/contract_MockERC721.md]

## Metadata

- **Contract**: MockERC721
- **Signature**: `symbol()`
- **Visibility**: external
- **Source Range**: 791:96:68

## Implementation

```solidity
function symbol() override external view returns (string memory) {
    return _symbol;
}
```

## State Variable Reads

- **_symbol** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC721.symbol() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice An abbreviated name for NFTs in this contract
