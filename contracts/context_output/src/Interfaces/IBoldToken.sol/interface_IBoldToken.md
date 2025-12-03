# Interface: IBoldToken

## Metadata

- **Name**: IBoldToken
- **Type**: Interface
- **Path**: src/Interfaces/IBoldToken.sol

## Implements Interfaces

- **IERC5267** [lib/openzeppelin-contracts/contracts/interfaces/IERC5267.sol/interface_IERC5267.md]
- **IERC20Permit** [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol/interface_IERC20Permit.md]
- **IERC20Metadata** [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **IERC20** [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

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

### EIP712DomainChanged (inherited from IERC5267)

```solidity
///  @dev MAY be emitted to signal that the domain could have changed.
event EIP712DomainChanged();
```

## Public/External Functions

### setBranchAddresses(address,address,address,address)

- **Signature**: `setBranchAddresses(address,address,address,address)`
- **Visibility**: external
- **Source Range**: 363:200:145

**Signature:**
```solidity
function setBranchAddresses(address _troveManagerAddress, address _stabilityPoolAddress, address _borrowerOperationsAddress, address _activePoolAddress) external;;
```

### setCollateralRegistry(address)

- **Signature**: `setCollateralRegistry(address)`
- **Visibility**: external
- **Source Range**: 569:76:145

**Signature:**
```solidity
function setCollateralRegistry(address _collateralRegistryAddress) external;;
```

### mint(address,uint256)

- **Signature**: `mint(address,uint256)`
- **Visibility**: external
- **Source Range**: 651:58:145

**Signature:**
```solidity
function mint(address _account, uint256 _amount) external;;
```

### burn(address,uint256)

- **Signature**: `burn(address,uint256)`
- **Visibility**: external
- **Source Range**: 715:58:145

**Signature:**
```solidity
function burn(address _account, uint256 _amount) external;;
```

### sendToPool(address,address,uint256)

- **Signature**: `sendToPool(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 779:84:145

**Signature:**
```solidity
function sendToPool(address _sender, address poolAddress, uint256 _amount) external;;
```

### returnFromPool(address,address,uint256)

- **Signature**: `returnFromPool(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 869:85:145

**Signature:**
```solidity
function returnFromPool(address poolAddress, address user, uint256 _amount) external;;
```

### totalSupply() (inherited from IERC20)

- **Signature**: `totalSupply()`
- **Visibility**: external
- **Source Range**: 774:55:79

**Signature:**
```solidity
///  @dev Returns the amount of tokens in existence.
function totalSupply() external view returns (uint256);;
```

### balanceOf(address) (inherited from IERC20)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 912:68:79

**Signature:**
```solidity
///  @dev Returns the amount of tokens owned by `account`.
function balanceOf(address account) external view returns (uint256);;
```

### transfer(address,uint256) (inherited from IERC20)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: external
- **Source Range**: 1193:70:79

**Signature:**
```solidity
///  @dev Moves `amount` tokens from the caller's account to `to`.
///  Returns a boolean value indicating whether the operation succeeded.
///  Emits a {Transfer} event.
function transfer(address to, uint256 amount) external returns (bool);;
```

### allowance(address,address) (inherited from IERC20)

- **Signature**: `allowance(address,address)`
- **Visibility**: external
- **Source Range**: 1538:83:79

**Signature:**
```solidity
///  @dev Returns the remaining number of tokens that `spender` will be
///  allowed to spend on behalf of `owner` through {transferFrom}. This is
///  zero by default.
///  This value changes when {approve} or {transferFrom} are called.
function allowance(address owner, address spender) external view returns (uint256);;
```

### approve(address,uint256) (inherited from IERC20)

- **Signature**: `approve(address,uint256)`
- **Visibility**: external
- **Source Range**: 2274:74:79

**Signature:**
```solidity
///  @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
///  Returns a boolean value indicating whether the operation succeeded.
///  IMPORTANT: Beware that changing an allowance with this method brings the risk
///  that someone may use both the old and the new allowance by unfortunate
///  transaction ordering. One possible solution to mitigate this race
///  condition is to first reduce the spender's allowance to 0 and set the
///  desired value afterwards:
///  https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
///  Emits an {Approval} event.
function approve(address spender, uint256 amount) external returns (bool);;
```

### transferFrom(address,address,uint256) (inherited from IERC20)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 2646:88:79

**Signature:**
```solidity
///  @dev Moves `amount` tokens from `from` to `to` using the
///  allowance mechanism. `amount` is then deducted from the caller's
///  allowance.
///  Returns a boolean value indicating whether the operation succeeded.
///  Emits a {Transfer} event.
function transferFrom(address from, address to, uint256 amount) external returns (bool);;
```

### name() (inherited from IERC20Metadata)

- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 377:54:83

**Signature:**
```solidity
///  @dev Returns the name of the token.
function name() external view returns (string memory);;
```

### symbol() (inherited from IERC20Metadata)

- **Signature**: `symbol()`
- **Visibility**: external
- **Source Range**: 498:56:83

**Signature:**
```solidity
///  @dev Returns the symbol of the token.
function symbol() external view returns (string memory);;
```

### decimals() (inherited from IERC20Metadata)

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 630:50:83

**Signature:**
```solidity
///  @dev Returns the decimals places of the token.
function decimals() external view returns (uint8);;
```

### permit(address,address,uint256,uint256,uint8,bytes32,bytes32) (inherited from IERC20Permit)

- **Signature**: `permit(address,address,uint256,uint256,uint8,bytes32,bytes32)`
- **Visibility**: external
- **Source Range**: 2996:183:84

**Signature:**
```solidity
///  @dev Sets `value` as the allowance of `spender` over ``owner``'s tokens,
///  given ``owner``'s signed approval.
///  IMPORTANT: The same issues {IERC20-approve} has related to transaction
///  ordering also apply here.
///  Emits an {Approval} event.
///  Requirements:
///  - `spender` cannot be the zero address.
///  - `deadline` must be a timestamp in the future.
///  - `v`, `r` and `s` must be a valid `secp256k1` signature from `owner`
///  over the EIP712-formatted function arguments.
///  - the signature must use ``owner``'s current nonce (see {nonces}).
///  For more information on the signature format, see the
///  https://eips.ethereum.org/EIPS/eip-2612#specification[relevant EIP
///  section].
///  CAUTION: See Security Considerations above.
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external;;
```

### nonces(address) (inherited from IERC20Permit)

- **Signature**: `nonces(address)`
- **Visibility**: external
- **Source Range**: 3484:63:84

**Signature:**
```solidity
///  @dev Returns the current nonce for `owner`. This value must be
///  included whenever a signature is generated for {permit}.
///  Every successful call to {permit} increases ``owner``'s nonce by one. This
///  prevents a signature from being used multiple times.
function nonces(address owner) external view returns (uint256);;
```

### DOMAIN_SEPARATOR() (inherited from IERC20Permit)

- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: external
- **Source Range**: 3739:60:84

**Signature:**
```solidity
///  @dev Returns the domain separator used in the encoding of the signature for {permit}, as defined by {EIP712}.
function DOMAIN_SEPARATOR() external view returns (bytes32);;
```

### eip712Domain() (inherited from IERC5267)

- **Signature**: `eip712Domain()`
- **Visibility**: external
- **Source Range**: 425:310:75

**Signature:**
```solidity
///  @dev returns the fields and values that describe the domain separator used by this contract for EIP-712
///  signature.
function eip712Domain() external view returns (bytes1 fields, string memory name, string memory version, uint256 chainId, address verifyingContract, bytes32 salt, uint256[] memory extensions);;
```
