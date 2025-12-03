# Contract: NonPayableSwitch

## Metadata

- **Name**: NonPayableSwitch
- **Type**: Contract
- **Path**: test/TestContracts/NonPayableSwitch.sol

## State Variables

### isPayable

```solidity
bool internal isPayable
```

### collToken

```solidity
IERC20 public collToken
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Public/External Functions

### setColl(contract IERC20)

- **Signature**: `setColl(contract IERC20)`
- **Visibility**: external
- **Source Range**: 285:72:276
- **Details**: [function_setColl_contract_IERC20.md](./function_setColl_contract_IERC20.md)

**Signature:**
```solidity
function setColl(IERC20 _eth) external;
```

### setPayable(bool)

- **Signature**: `setPayable(bool)`
- **Visibility**: external
- **Source Range**: 363:85:276
- **Details**: [function_setPayable_bool.md](./function_setPayable_bool.md)

**Signature:**
```solidity
function setPayable(bool _isPayable) external;
```

### forward(address,bytes)

- **Signature**: `forward(address,bytes)`
- **Visibility**: external
- **Source Range**: 454:380:276
- **Details**: [function_forward_address_bytes.md](./function_forward_address_bytes.md)

**Signature:**
```solidity
function forward(address _dest, bytes calldata _data) external payable;
```

### receiveColl(uint256)

- **Signature**: `receiveColl(uint256)`
- **Visibility**: external
- **Source Range**: 840:166:276
- **Details**: [function_receiveColl_uint256.md](./function_receiveColl_uint256.md)

**Signature:**
```solidity
function receiveColl(uint256 _amount) external;
```

### receive()

- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 1012:62:276
- **Details**: [function_receive.md](./function_receive.md)

**Signature:**
```solidity
receive() external payable;
```
