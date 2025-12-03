# Function: transferFrom(address,address,uint256)

**Contract**: [test/TestContracts/BoldTokenTester.sol/contract_BoldTokenTester.md]

## Metadata

- **Contract**: BoldTokenTester
- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 5203:256:78
- **Inherited From**: ERC20

## Implementation

```solidity
///  @dev See {IERC20-transferFrom}.
///  Emits an {Approval} event indicating the updated allowance. This is not
///  required by the EIP. See the note at the beginning of {ERC20}.
///  NOTE: Does not update the allowance if the current allowance
///  is the maximum `uint256`.
///  Requirements:
///  - `from` and `to` cannot be the zero address.
///  - `from` must have a balance of at least `amount`.
///  - the caller must have allowance for ``from``'s tokens of at least
///  `amount`.
function transferFrom(address from, address to, uint256 amount) virtual override public returns (bool) {
    address spender = _msgSender();
    _spendAllowance(from, spender, amount);
    _transfer(from, to, amount);
    return true;
}
```

## Call Tree

```
No call tree available
```

## Documentation

### Function Documentation

 @dev See {IERC20-transferFrom}.
 Emits an {Approval} event indicating the updated allowance. This is not
 required by the EIP. See the note at the beginning of {ERC20}.
 NOTE: Does not update the allowance if the current allowance
 is the maximum `uint256`.
 Requirements:
 - `from` and `to` cannot be the zero address.
 - `from` must have a balance of at least `amount`.
 - the caller must have allowance for ``from``'s tokens of at least
 `amount`.

### Interface Documentation

 @dev Moves `amount` tokens from `from` to `to` using the
 allowance mechanism. `amount` is then deducted from the caller's
 allowance.
 Returns a boolean value indicating whether the operation succeeded.
 Emits a {Transfer} event.
