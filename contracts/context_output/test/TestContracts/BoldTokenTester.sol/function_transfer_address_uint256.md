# Function: transfer(address,uint256)

**Contract**: [test/TestContracts/BoldTokenTester.sol/contract_BoldTokenTester.md]

## Metadata

- **Contract**: BoldTokenTester
- **Signature**: `transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 3740:189:78
- **Inherited From**: ERC20

## Implementation

```solidity
///  @dev See {IERC20-transfer}.
///  Requirements:
///  - `to` cannot be the zero address.
///  - the caller must have a balance of at least `amount`.
function transfer(address to, uint256 amount) virtual override public returns (bool) {
    address owner = _msgSender();
    _transfer(owner, to, amount);
    return true;
}
```

## Call Tree

```
No call tree available
```

## Documentation

### Function Documentation

 @dev See {IERC20-transfer}.
 Requirements:
 - `to` cannot be the zero address.
 - the caller must have a balance of at least `amount`.

### Interface Documentation

 @dev Moves `amount` tokens from the caller's account to `to`.
 Returns a boolean value indicating whether the operation succeeded.
 Emits a {Transfer} event.
