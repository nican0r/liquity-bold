# Function: initialize(string,string)

**Contract**: [lib/forge-std/src/mocks/MockERC721.sol/contract_MockERC721.md]

## Metadata

- **Contract**: MockERC721
- **Signature**: `initialize(string,string)`
- **Visibility**: public
- **Source Range**: 2728:212:68

## Implementation

```solidity
/// @dev To hide constructor warnings across solc versions due to different constructor visibility requirements and
///  syntaxes, we add an initialization function that can be called only once.
function initialize(string memory name_, string memory symbol_) public {
    require(!initialized, "ALREADY_INITIALIZED");
    _name = name_;
    _symbol = symbol_;
    initialized = true;
}
```

## State Variable Reads

- **initialized** (`bool`)

## State Variable Writes

- **_name** (`string`)
- **_symbol** (`string`)
- **initialized** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC721.initialize(string,string) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@dev To hide constructor warnings across solc versions due to different constructor visibility requirements and
 syntaxes, we add an initialization function that can be called only once.
