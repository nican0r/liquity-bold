# Function: withdraw(uint256)

**Contract**: [test/TestContracts/WETHTester.sol/contract_WETHTester.md]

## Metadata

- **Contract**: WETHTester
- **Signature**: `withdraw(uint256)`
- **Visibility**: public
- **Source Range**: 629:209:284

## Implementation

```solidity
function withdraw(uint256 wad) public {
    require(balanceOf(msg.sender) >= wad);
    _burn(msg.sender, wad);
    payable(msg.sender).transfer(wad);
    emit Withdrawal(msg.sender, wad);
}
```

## Related Implementations

### balanceOf(address)

- **Kind**: internal
- **Source**: 3419:125:78
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:balanceOf(address)`

```solidity
///  @dev See {IERC20-balanceOf}.
function balanceOf(address account) virtual override public view returns (uint256) {
    return _balances[account];
}
```

### _burn(address,uint256)

- **Kind**: internal
- **Source**: 9375:659:78
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_burn(address,uint256)`

```solidity
///  @dev Destroys `amount` tokens from `account`, reducing the
///  total supply.
///  Emits a {Transfer} event with `to` set to the zero address.
///  Requirements:
///  - `account` cannot be the zero address.
///  - `account` must have at least `amount` tokens.
function _burn(address account, uint256 amount) virtual internal {
    require(account != address(0), "ERC20: burn from the zero address");
    _beforeTokenTransfer(account, address(0), amount);
    uint256 accountBalance = _balances[account];
    require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
    unchecked {
        _balances[account] = accountBalance - amount;
        _totalSupply -= amount;
    }
    emit Transfer(account, address(0), amount);
    _afterTokenTransfer(account, address(0), amount);
}
```

### _beforeTokenTransfer(address,address,uint256)

- **Kind**: internal
- **Source**: 12073:91:78
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_beforeTokenTransfer(address,address,uint256)`

```solidity
///  @dev Hook that is called before any transfer of tokens. This includes
///  minting and burning.
///  Calling conditions:
///  - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
///  will be transferred to `to`.
///  - when `from` is zero, `amount` tokens will be minted for `to`.
///  - when `to` is zero, `amount` of ``from``'s tokens will be burned.
///  - `from` and `to` are never both zero.
///  To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
function _beforeTokenTransfer(address from, address to, uint256 amount) virtual internal {}
```

### _afterTokenTransfer(address,address,uint256)

- **Kind**: internal
- **Source**: 12752:90:78
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_afterTokenTransfer(address,address,uint256)`

```solidity
///  @dev Hook that is called after any transfer of tokens. This includes
///  minting and burning.
///  Calling conditions:
///  - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
///  has been transferred to `to`.
///  - when `from` is zero, `amount` tokens have been minted for `to`.
///  - when `to` is zero, `amount` of ``from``'s tokens have been burned.
///  - `from` and `to` are never both zero.
///  To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
function _afterTokenTransfer(address from, address to, uint256 amount) virtual internal {}
```

## Native Transfers

- **unknown** (computed)

## State Variable Reads

- **_balances** (`mapping(address => uint256)`)

## State Variable Writes

- **_balances** (`mapping(address => uint256)`)
- **_totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: WETHTester.withdraw(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC20.balanceOf(address) (NodeID: 1)
  │   💬 Args: [msg.sender]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC20._burn(address,uint256) (NodeID: 2)
      💬 Args: [msg.sender, wad]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC20._beforeTokenTransfer(address,address,uint256) (NodeID: 3)
    │   💬 Args: [account, address(0), amount]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC20._afterTokenTransfer(address,address,uint256) (NodeID: 4)
        💬 Args: [account, address(0), amount]
        👁️  Def: internal
```
