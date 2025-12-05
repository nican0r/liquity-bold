# Function: tokenURI(uint256)

**Contract**: [lib/forge-std/src/mocks/MockERC721.sol/contract_MockERC721.md]

## Metadata

- **Contract**: MockERC721
- **Signature**: `tokenURI(uint256)`
- **Visibility**: public
- **Source Range**: 893:85:68

## Implementation

```solidity
function tokenURI(uint256 id) virtual override public view returns (string memory) {}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC721.tokenURI(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

@notice A distinct Uniform Resource Identifier (URI) for a given asset.
 @dev Throws if `_tokenId` is not a valid NFT. URIs are defined in RFC
 3986. The URI may point to a JSON file that conforms to the "ERC721
 Metadata JSON Schema".
