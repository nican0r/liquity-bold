# Function: constructor(string,string)

**Contract**: [test/TestContracts/ERC20Faucet.sol/contract_ERC20Faucet.md]

## Metadata

- **Contract**: ERC20Faucet
- **Signature**: `constructor(string,string)`
- **Visibility**: public
- **Source Range**: 1980:113:78
- **Inherited From**: ERC20

## Implementation

```solidity
///  @dev Sets the values for {name} and {symbol}.
///  All two of these values are immutable: they can only be set once during
///  construction.
constructor(string memory name_, string memory symbol_) {
    _name = name_;
    _symbol = symbol_;
}
```

## Call Tree

```
No call tree available
```

## Documentation

### Function Documentation

 @dev Sets the values for {name} and {symbol}.
 All two of these values are immutable: they can only be set once during
 construction.
