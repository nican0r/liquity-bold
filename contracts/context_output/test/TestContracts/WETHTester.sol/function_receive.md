# Function: receive()

**Contract**: [test/TestContracts/WETHTester.sol/contract_WETHTester.md]

## Metadata

- **Contract**: WETHTester
- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 440:53:284

## Implementation

```solidity
receive() external payable {
    deposit();
}
```

## Related Implementations

### deposit()

- **Kind**: internal
- **Source**: 499:124:284
- **Link**: `test/TestContracts/WETHTester.sol:WETHTester:deposit()`

```solidity
function deposit() public payable {
    _mint(msg.sender, msg.value);
    emit Deposit(msg.sender, msg.value);
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

## State Variable Writes

- **_totalSupply** (`uint256`)
- **_balances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: WETHTester.receive() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: WETHTester.deposit() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: ERC20._mint(address,uint256) (NodeID: 2)
        💬 Args: [msg.sender, msg.value]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ERC20._beforeTokenTransfer(address,address,uint256) (NodeID: 3)
      │   💬 Args: [address(0), account, amount]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: ERC20._afterTokenTransfer(address,address,uint256) (NodeID: 4)
          💬 Args: [address(0), account, amount]
          👁️  Def: internal
```
