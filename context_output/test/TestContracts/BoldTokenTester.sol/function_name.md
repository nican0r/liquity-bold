# Function: name()

**Contract**: [test/TestContracts/BoldTokenTester.sol/contract_BoldTokenTester.md]

## Metadata

- **Contract**: BoldTokenTester
- **Signature**: `name()`
- **Visibility**: public
- **Source Range**: 2158:98:78
- **Inherited From**: ERC20

## Implementation

```solidity
///  @dev Returns the name of the token.
function name() virtual override public view returns (string memory) {
    return _name;
}
```

## State Variable Reads

- **_name** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20.name() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev Returns the name of the token.

### Interface Documentation

 @dev Returns the name of the token.
