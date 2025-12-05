# Function: mint(address,uint256)

**Contract**: [test/TestContracts/WETHTester.sol/contract_WETHTester.md]

## Metadata

- **Contract**: WETHTester
- **Signature**: `mint(address,uint256)`
- **Visibility**: external
- **Source Range**: 804:99:262
- **Inherited From**: ERC20Faucet

## Implementation

```solidity
function mint(address _to, uint256 _amount) external onlyOwner() {
    _mint(_to, _amount);
}
```

## Related Implementations

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

### onlyOwner()

- **Kind**: modifier
- **Source**: 1063:62:74
- **Link**: `lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:onlyOwner()`

```solidity
///  @dev Throws if called by any account other than the owner.
modifier onlyOwner() {
    _checkOwner();
    _;
}
```

### _checkOwner()

- **Kind**: internal
- **Source**: 1359:130:74
- **Link**: `lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:_checkOwner()`

```solidity
///  @dev Throws if the sender is not the owner.
function _checkOwner() virtual internal view {
    require(owner() == _msgSender(), "Ownable: caller is not the owner");
}
```

### _msgSender()

- **Kind**: internal
- **Source**: 655:96:92
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
}
```

### owner()

- **Kind**: internal
- **Source**: 1201:85:74
- **Link**: `lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:owner()`

```solidity
///  @dev Returns the address of the current owner.
function owner() virtual public view returns (address) {
    return _owner;
}
```

## State Variable Reads

- **_owner** (`address`)

## State Variable Writes

- **_totalSupply** (`uint256`)
- **_balances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20Faucet.mint(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: ERC20._mint(address,uint256) (NodeID: 1)
  │   💬 Args: [_to, _amount]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ERC20._beforeTokenTransfer(address,address,uint256) (NodeID: 2)
  │ │   💬 Args: [address(0), account, amount]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ERC20._afterTokenTransfer(address,address,uint256) (NodeID: 3)
  │     💬 Args: [address(0), account, amount]
  │     👁️  Def: internal
  └─ [1] 🔒 MODIFIER: Ownable.onlyOwner() (NodeID: 4)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: Ownable._checkOwner() (NodeID: 5)
        💬 Args: [no args]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Context._msgSender() (NodeID: 6)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Ownable.owner() (NodeID: 7)
          💬 Args: [no args]
          👁️  Def: public
```
