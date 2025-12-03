# Contract: BoldToken

## Metadata

- **Name**: BoldToken
- **Type**: Contract
- **Path**: src/BoldToken.sol

## Implements Interfaces

- **IBoldToken** [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **IERC5267** [lib/openzeppelin-contracts/contracts/interfaces/IERC5267.sol/interface_IERC5267.md]
- **IERC20Permit** [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol/interface_IERC20Permit.md]
- **IERC20Metadata** [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **IERC20** [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## State Variables

### _owner (inherited from Ownable)

```solidity
address private _owner
```

### _balances (inherited from ERC20)

```solidity
mapping(address => uint256) private _balances
```

### _allowances (inherited from ERC20)

```solidity
mapping(address => mapping(address => uint256)) private _allowances
```

### _totalSupply (inherited from ERC20)

```solidity
uint256 private _totalSupply
```

### _name (inherited from ERC20)

```solidity
string private _name
```

### _symbol (inherited from ERC20)

```solidity
string private _symbol
```

### _TYPE_HASH (inherited from EIP712)

```solidity
bytes32 private constant _TYPE_HASH = keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)")
```

### _cachedDomainSeparator (inherited from EIP712)

```solidity
bytes32 private immutable _cachedDomainSeparator
```

### _cachedChainId (inherited from EIP712)

```solidity
uint256 private immutable _cachedChainId
```

### _cachedThis (inherited from EIP712)

```solidity
address private immutable _cachedThis
```

### _hashedName (inherited from EIP712)

```solidity
bytes32 private immutable _hashedName
```

### _hashedVersion (inherited from EIP712)

```solidity
bytes32 private immutable _hashedVersion
```

### _name (inherited from EIP712)

```solidity
ShortString private immutable _name
```

### _version (inherited from EIP712)

```solidity
ShortString private immutable _version
```

### _nameFallback (inherited from EIP712)

```solidity
string private _nameFallback
```

### _versionFallback (inherited from EIP712)

```solidity
string private _versionFallback
```

### _nonces (inherited from ERC20Permit)

```solidity
mapping(address => Counters.Counter) private _nonces
```

### _PERMIT_TYPEHASH (inherited from ERC20Permit)

```solidity
bytes32 private constant _PERMIT_TYPEHASH = keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)")
```

### _PERMIT_TYPEHASH_DEPRECATED_SLOT (inherited from ERC20Permit)

```solidity
///  @dev In previous versions `_PERMIT_TYPEHASH` was declared as `immutable`.
///  However, to ensure consistency with the upgradeable transpiler, we will continue
///  to reserve a slot.
///  @custom:oz-renamed-from _PERMIT_TYPEHASH
bytes32 private _PERMIT_TYPEHASH_DEPRECATED_SLOT
```

### _NAME

```solidity
string internal constant _NAME = "BOLD Stablecoin"
```

### _SYMBOL

```solidity
string internal constant _SYMBOL = "BOLD"
```

### collateralRegistryAddress

```solidity
address public collateralRegistryAddress
```

### troveManagerAddresses

```solidity
mapping(address => bool) internal troveManagerAddresses
```

### stabilityPoolAddresses

```solidity
mapping(address => bool) internal stabilityPoolAddresses
```

### borrowerOperationsAddresses

```solidity
mapping(address => bool) internal borrowerOperationsAddresses
```

### activePoolAddresses

```solidity
mapping(address => bool) internal activePoolAddresses
```

## Events

### OwnershipTransferred (inherited from Ownable)

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
```

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

### CollateralRegistryAddressChanged

```solidity
event CollateralRegistryAddressChanged(address _newCollateralRegistryAddress);
```

### TroveManagerAddressAdded

```solidity
event TroveManagerAddressAdded(address _newTroveManagerAddress);
```

### StabilityPoolAddressAdded

```solidity
event StabilityPoolAddressAdded(address _newStabilityPoolAddress);
```

### BorrowerOperationsAddressAdded

```solidity
event BorrowerOperationsAddressAdded(address _newBorrowerOperationsAddress);
```

### ActivePoolAddressAdded

```solidity
event ActivePoolAddressAdded(address _newActivePoolAddress);
```

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 1600:87:127
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
constructor(address _owner) Ownable(_owner) ERC20(_NAME,_SYMBOL) ERC20Permit(_NAME);
```

### setBranchAddresses(address,address,address,address)

- **Signature**: `setBranchAddresses(address,address,address,address)`
- **Visibility**: external
- **Source Range**: 1693:733:127
- **Details**: [function_setBranchAddresses_address_address_address_address.md](./function_setBranchAddresses_address_address_address_address.md)

**Signature:**
```solidity
function setBranchAddresses(address _troveManagerAddress, address _stabilityPoolAddress, address _borrowerOperationsAddress, address _activePoolAddress) override external onlyOwner();
```

### setCollateralRegistry(address)

- **Signature**: `setCollateralRegistry(address)`
- **Visibility**: external
- **Source Range**: 2432:272:127
- **Details**: [function_setCollateralRegistry_address.md](./function_setCollateralRegistry_address.md)

**Signature:**
```solidity
function setCollateralRegistry(address _collateralRegistryAddress) override external onlyOwner();
```

### mint(address,uint256)

- **Signature**: `mint(address,uint256)`
- **Visibility**: external
- **Source Range**: 2760:142:127
- **Details**: [function_mint_address_uint256.md](./function_mint_address_uint256.md)

**Signature:**
```solidity
function mint(address _account, uint256 _amount) override external;
```

### burn(address,uint256)

- **Signature**: `burn(address,uint256)`
- **Visibility**: external
- **Source Range**: 2908:150:127
- **Details**: [function_burn_address_uint256.md](./function_burn_address_uint256.md)

**Signature:**
```solidity
function burn(address _account, uint256 _amount) override external;
```

### sendToPool(address,address,uint256)

- **Signature**: `sendToPool(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 3064:193:127
- **Details**: [function_sendToPool_address_address_uint256.md](./function_sendToPool_address_address_uint256.md)

**Signature:**
```solidity
function sendToPool(address _sender, address _poolAddress, uint256 _amount) override external;
```

### returnFromPool(address,address,uint256)

- **Signature**: `returnFromPool(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 3263:201:127
- **Details**: [function_returnFromPool_address_address_uint256.md](./function_returnFromPool_address_address_uint256.md)

**Signature:**
```solidity
function returnFromPool(address _poolAddress, address _receiver, uint256 _amount) override external;
```

### transfer(address,uint256)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 3505:199:127
- **Details**: [function_transfer_address_uint256.md](./function_transfer_address_uint256.md)

**Signature:**
```solidity
function transfer(address recipient, uint256 amount) override(ERC20, IERC20) public returns (bool);
```

### transferFrom(address,address,uint256)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 3710:259:127
- **Details**: [function_transferFrom_address_address_uint256.md](./function_transferFrom_address_address_uint256.md)

**Signature:**
```solidity
function transferFrom(address sender, address recipient, uint256 amount) override(ERC20, IERC20) public returns (bool);
```

### owner() (inherited from Ownable)

- **Signature**: `owner()`
- **Visibility**: public
- **Source Range**: 1015:77:138
- **Details**: [function_owner.md](./function_owner.md)

**Signature:**
```solidity
///  @dev Returns the address of the current owner.
function owner() public view returns (address);
```

### isOwner() (inherited from Ownable)

- **Signature**: `isOwner()`
- **Visibility**: public
- **Source Range**: 1366:90:138
- **Details**: [function_isOwner.md](./function_isOwner.md)

**Signature:**
```solidity
///  @dev Returns true if the caller is the current owner.
function isOwner() public view returns (bool);
```

### constructor(string,string) (inherited from ERC20)

- **Signature**: `constructor(string,string)`
- **Visibility**: public
- **Source Range**: 1980:113:78
- **Details**: [function_constructor_string_string.md](./function_constructor_string_string.md)

**Signature:**
```solidity
///  @dev Sets the values for {name} and {symbol}.
///  All two of these values are immutable: they can only be set once during
///  construction.
constructor(string memory name_, string memory symbol_);
```

### name() (inherited from ERC20)

- **Signature**: `name()`
- **Visibility**: public
- **Source Range**: 2158:98:78
- **Details**: [function_name.md](./function_name.md)

**Signature:**
```solidity
///  @dev Returns the name of the token.
function name() virtual override public view returns (string memory);
```

### symbol() (inherited from ERC20)

- **Signature**: `symbol()`
- **Visibility**: public
- **Source Range**: 2369:102:78
- **Details**: [function_symbol.md](./function_symbol.md)

**Signature:**
```solidity
///  @dev Returns the symbol of the token, usually a shorter version of the
///  name.
function symbol() virtual override public view returns (string memory);
```

### decimals() (inherited from ERC20)

- **Signature**: `decimals()`
- **Visibility**: public
- **Source Range**: 3104:91:78
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
///  @dev Returns the number of decimals used to get its user representation.
///  For example, if `decimals` equals `2`, a balance of `505` tokens should
///  be displayed to a user as `5.05` (`505 / 10 ** 2`).
///  Tokens usually opt for a value of 18, imitating the relationship between
///  Ether and Wei. This is the default value returned by this function, unless
///  it's overridden.
///  NOTE: This information is only used for _display_ purposes: it in
///  no way affects any of the arithmetic of the contract, including
///  {IERC20-balanceOf} and {IERC20-transfer}.
function decimals() virtual override public view returns (uint8);
```

### totalSupply() (inherited from ERC20)

- **Signature**: `totalSupply()`
- **Visibility**: public
- **Source Range**: 3255:106:78
- **Details**: [function_totalSupply.md](./function_totalSupply.md)

**Signature:**
```solidity
///  @dev See {IERC20-totalSupply}.
function totalSupply() virtual override public view returns (uint256);
```

### balanceOf(address) (inherited from ERC20)

- **Signature**: `balanceOf(address)`
- **Visibility**: public
- **Source Range**: 3419:125:78
- **Details**: [function_balanceOf_address.md](./function_balanceOf_address.md)

**Signature:**
```solidity
///  @dev See {IERC20-balanceOf}.
function balanceOf(address account) virtual override public view returns (uint256);
```

### allowance(address,address) (inherited from ERC20)

- **Signature**: `allowance(address,address)`
- **Visibility**: public
- **Source Range**: 3987:149:78
- **Details**: [function_allowance_address_address.md](./function_allowance_address_address.md)

**Signature:**
```solidity
///  @dev See {IERC20-allowance}.
function allowance(address owner, address spender) virtual override public view returns (uint256);
```

### approve(address,uint256) (inherited from ERC20)

- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 4444:197:78
- **Details**: [function_approve_address_uint256.md](./function_approve_address_uint256.md)

**Signature:**
```solidity
///  @dev See {IERC20-approve}.
///  NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
///  `transferFrom`. This is semantically equivalent to an infinite approval.
///  Requirements:
///  - `spender` cannot be the zero address.
function approve(address spender, uint256 amount) virtual override public returns (bool);
```

### increaseAllowance(address,uint256) (inherited from ERC20)

- **Signature**: `increaseAllowance(address,uint256)`
- **Visibility**: public
- **Source Range**: 5854:234:78
- **Details**: [function_increaseAllowance_address_uint256.md](./function_increaseAllowance_address_uint256.md)

**Signature:**
```solidity
///  @dev Atomically increases the allowance granted to `spender` by the caller.
///  This is an alternative to {approve} that can be used as a mitigation for
///  problems described in {IERC20-approve}.
///  Emits an {Approval} event indicating the updated allowance.
///  Requirements:
///  - `spender` cannot be the zero address.
function increaseAllowance(address spender, uint256 addedValue) virtual public returns (bool);
```

### decreaseAllowance(address,uint256) (inherited from ERC20)

- **Signature**: `decreaseAllowance(address,uint256)`
- **Visibility**: public
- **Source Range**: 6575:427:78
- **Details**: [function_decreaseAllowance_address_uint256.md](./function_decreaseAllowance_address_uint256.md)

**Signature:**
```solidity
///  @dev Atomically decreases the allowance granted to `spender` by the caller.
///  This is an alternative to {approve} that can be used as a mitigation for
///  problems described in {IERC20-approve}.
///  Emits an {Approval} event indicating the updated allowance.
///  Requirements:
///  - `spender` cannot be the zero address.
///  - `spender` must have allowance for the caller of at least
///  `subtractedValue`.
function decreaseAllowance(address spender, uint256 subtractedValue) virtual public returns (bool);
```

### eip712Domain() (inherited from EIP712)

- **Signature**: `eip712Domain()`
- **Visibility**: public
- **Source Range**: 5021:633:98
- **Details**: [function_eip712Domain.md](./function_eip712Domain.md)

**Signature:**
```solidity
///  @dev See {EIP-5267}.
///  _Available since v4.9._
function eip712Domain() virtual override public view returns (bytes1 fields, string memory name, string memory version, uint256 chainId, address verifyingContract, bytes32 salt, uint256[] memory extensions);
```

### permit(address,address,uint256,uint256,uint8,bytes32,bytes32) (inherited from ERC20Permit)

- **Signature**: `permit(address,address,uint256,uint256,uint8,bytes32,bytes32)`
- **Visibility**: public
- **Source Range**: 1923:626:82
- **Details**: [function_permit_address_address_uint256_uint256_uint8_bytes32_bytes32.md](./function_permit_address_address_uint256_uint256_uint8_bytes32_bytes32.md)

**Signature:**
```solidity
///  @inheritdoc IERC20Permit
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) virtual override public;
```

### nonces(address) (inherited from ERC20Permit)

- **Signature**: `nonces(address)`
- **Visibility**: public
- **Source Range**: 2603:126:82
- **Details**: [function_nonces_address.md](./function_nonces_address.md)

**Signature:**
```solidity
///  @inheritdoc IERC20Permit
function nonces(address owner) virtual override public view returns (uint256);
```

### DOMAIN_SEPARATOR() (inherited from ERC20Permit)

- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: external
- **Source Range**: 2836:113:82
- **Details**: [function_DOMAIN_SEPARATOR.md](./function_DOMAIN_SEPARATOR.md)

**Signature:**
```solidity
///  @inheritdoc IERC20Permit
function DOMAIN_SEPARATOR() override external view returns (bytes32);
```
