# Function: isApprovedForAll(address,address)

**Contract**: [lib/forge-std/src/mocks/MockERC721.sol/contract_MockERC721.md]

## Metadata

- **Contract**: MockERC721
- **Signature**: `isApprovedForAll(address,address)`
- **Visibility**: public
- **Source Range**: 2075:161:68

## Implementation

```solidity
function isApprovedForAll(address owner, address operator) virtual override public view returns (bool) {
    return _isApprovedForAll[owner][operator];
}
```

## State Variable Reads

- **_isApprovedForAll** (`mapping(address => mapping(address => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC721.isApprovedForAll(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

@notice Query if an address is an authorized operator for another address
 @param _owner The address that owns the NFTs
 @param _operator The address that acts on behalf of the owner
 @return True if `_operator` is an approved operator for `_owner`, false otherwise
