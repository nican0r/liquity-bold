# Function: mint(address,uint256)

**Contract**: [src/BoldToken.sol/contract_BoldToken.md]

## Metadata

- **Contract**: BoldToken
- **Signature**: `mint(address,uint256)`
- **Visibility**: external
- **Source Range**: 2760:142:127

## Implementation

```solidity
function mint(address _account, uint256 _amount) override external {
    _requireCallerIsBOorAP();
    _mint(_account, _amount);
}
```

## Related Implementations

### _requireCallerIsBOorAP()

- **Kind**: internal
- **Source**: 4291:219:127
- **Link**: `src/BoldToken.sol:BoldToken:_requireCallerIsBOorAP()`

```solidity
function _requireCallerIsBOorAP() internal view {
    require(borrowerOperationsAddresses[msg.sender] || activePoolAddresses[msg.sender], "BoldToken: Caller is not BO or AP");
}
```

### _mint(address,uint256)

- **Kind**: internal
- **Source**: 8520:535:78
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_mint(address,uint256)`

```solidity
/// @dev Creates `amount` tokens and assigns them to `account`, increasing
///  the total supply.
///  Emits a {Transfer} event with `from` set to the zero address.
///  Requirements:
///  - `account` cannot be the zero address.
function _mint(address account, uint256 amount) virtual internal {
    require(account != address(0), "ERC20: mint to the zero address");
    _beforeTokenTransfer(address(0), account, amount);
    _totalSupply += amount;
    unchecked {
        _balances[account] += amount;
    }
    emit Transfer(address(0), account, amount);
    _afterTokenTransfer(address(0), account, amount);
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

## State Variable Reads

- **borrowerOperationsAddresses** (`mapping(address => bool)`)
- **activePoolAddresses** (`mapping(address => bool)`)

## State Variable Writes

- **_totalSupply** (`uint256`)
- **_balances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BoldToken.mint(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BoldToken._requireCallerIsBOorAP() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC20._mint(address,uint256) (NodeID: 2)
      💬 Args: [_account, _amount]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC20._beforeTokenTransfer(address,address,uint256) (NodeID: 3)
    │   💬 Args: [address(0), account, amount]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC20._afterTokenTransfer(address,address,uint256) (NodeID: 4)
        💬 Args: [address(0), account, amount]
        👁️  Def: internal
```
