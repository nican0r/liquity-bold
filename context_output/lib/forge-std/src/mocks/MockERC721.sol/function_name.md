# Function: name()

**Contract**: [lib/forge-std/src/mocks/MockERC721.sol/contract_MockERC721.md]

## Metadata

- **Contract**: MockERC721
- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 693:92:68

## Implementation

```solidity
function name() override external view returns (string memory) {
    return _name;
}
```

## State Variable Reads

- **_name** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC721.name() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice A descriptive name for a collection of NFTs in this contract
