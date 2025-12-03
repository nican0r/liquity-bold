# Function: totalSupply()

**Contract**: [test/TestContracts/WETHTester.sol/contract_WETHTester.md]

## Metadata

- **Contract**: WETHTester
- **Signature**: `totalSupply()`
- **Visibility**: public
- **Source Range**: 3255:106:78
- **Inherited From**: ERC20

## Implementation

```solidity
///  @dev See {IERC20-totalSupply}.
function totalSupply() virtual override public view returns (uint256) {
    return _totalSupply;
}
```

## State Variable Reads

- **_totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20.totalSupply() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev See {IERC20-totalSupply}.

### Interface Documentation

 @dev Returns the amount of tokens in existence.
