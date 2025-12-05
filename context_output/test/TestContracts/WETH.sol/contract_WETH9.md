# Contract: WETH9

## Metadata

- **Name**: WETH9
- **Type**: Contract
- **Path**: test/TestContracts/WETH.sol

## Implements Interfaces

- **IWETH** [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **IERC20Metadata** [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **IERC20** [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## State Variables

### name

```solidity
string public name = "Wrapped Ether"
```

### symbol

```solidity
string public symbol = "WETH"
```

### decimals

```solidity
uint8 public decimals = 18
```

### balanceOf

```solidity
mapping(address => uint256) public balanceOf
```

### allowance

```solidity
mapping(address => mapping(address => uint256)) public allowance
```

## Events

### Transfer (inherited from IERC20)

```solidity
///  @dev Emitted when `value` tokens are moved from one account (`from`) to
///  another (`to`).
///  Note that `value` may be zero.
event Transfer(address indexed from, address indexed to, uint256 value);
```

### Approval (inherited from IERC20)

```solidity
///  @dev Emitted when the allowance of a `spender` for an `owner` is set by
///  a call to {approve}. `value` is the new allowance.
event Approval(address indexed owner, address indexed spender, uint256 value);
```

### Deposit

```solidity
event Deposit(address indexed dst, uint256 wad);
```

### Withdrawal

```solidity
event Withdrawal(address indexed src, uint256 wad);
```

## Public/External Functions

### receive()

- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 1378:53:283
- **Details**: [function_receive.md](./function_receive.md)

**Signature:**
```solidity
receive() external payable;
```

### deposit()

- **Signature**: `deposit()`
- **Visibility**: public
- **Source Range**: 1437:130:283
- **Details**: [function_deposit.md](./function_deposit.md)

**Signature:**
```solidity
function deposit() public payable;
```

### withdraw(uint256)

- **Signature**: `withdraw(uint256)`
- **Visibility**: public
- **Source Range**: 1573:215:283
- **Details**: [function_withdraw_uint256.md](./function_withdraw_uint256.md)

**Signature:**
```solidity
function withdraw(uint256 wad) public;
```

### totalSupply()

- **Signature**: `totalSupply()`
- **Visibility**: public
- **Source Range**: 1794:98:283
- **Details**: [function_totalSupply.md](./function_totalSupply.md)

**Signature:**
```solidity
function totalSupply() public view returns (uint256);
```

### approve(address,uint256)

- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 1898:180:283
- **Details**: [function_approve_address_uint256.md](./function_approve_address_uint256.md)

**Signature:**
```solidity
function approve(address guy, uint256 wad) public returns (bool);
```

### transfer(address,uint256)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 2084:124:283
- **Details**: [function_transfer_address_uint256.md](./function_transfer_address_uint256.md)

**Signature:**
```solidity
function transfer(address dst, uint256 wad) public returns (bool);
```

### transferFrom(address,address,uint256)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 2214:452:283
- **Details**: [function_transferFrom_address_address_uint256.md](./function_transferFrom_address_address_uint256.md)

**Signature:**
```solidity
function transferFrom(address src, address dst, uint256 wad) public returns (bool);
```
