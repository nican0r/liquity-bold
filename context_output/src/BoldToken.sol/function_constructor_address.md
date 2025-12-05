# Function: constructor(address)

**Contract**: [src/BoldToken.sol/contract_BoldToken.md]

## Metadata

- **Contract**: BoldToken
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 1600:87:127

## Implementation

```solidity
constructor(address _owner) Ownable(_owner) ERC20(_NAME,_SYMBOL) ERC20Permit(_NAME) {}
```

## Related Implementations

### (string)

- **Kind**: internal
- **Source**: 1817:52:82
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol:ERC20Permit:constructor(string)`

```solidity
///  @dev Initializes the {EIP712} domain separator using the `name` parameter, and setting `version` to `"1"`.
///  It's a good idea to use the same `name` that is defined as the ERC20 token name.
constructor(string memory name) EIP712(name,"1") {}
```

### (string,string)

- **Kind**: internal
- **Source**: 3178:431:98
- **Link**: `lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol:EIP712:constructor(string,string)`

```solidity
///  @dev Initializes the domain separator and parameter caches.
///  The meaning of `name` and `version` is specified in
///  https://eips.ethereum.org/EIPS/eip-712#definition-of-domainseparator[EIP 712]:
///  - `name`: the user readable name of the signing domain, i.e. the name of the DApp or the protocol.
///  - `version`: the current major version of the signing domain.
///  NOTE: These parameters cannot be changed except through a xref:learn::upgrading-smart-contracts.adoc[smart
///  contract upgrade].
constructor(string memory name, string memory version) {
    _name = name.toShortStringWithFallback(_nameFallback);
    _version = version.toShortStringWithFallback(_versionFallback);
    _hashedName = keccak256(bytes(name));
    _hashedVersion = keccak256(bytes(version));
    _cachedChainId = block.chainid;
    _cachedDomainSeparator = _buildDomainSeparator();
    _cachedThis = address(this);
}
```

### toShortStringWithFallback(string,string)

- **Kind**: internal
- **Source**: 2895:341:94
- **Link**: `lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol:ShortStrings:toShortStringWithFallback(string,string)`

```solidity
///  @dev Encode a string into a `ShortString`, or write it to storage if it is too long.
function toShortStringWithFallback(string memory value, string storage store) internal returns (ShortString) {
    if (bytes(value).length < 32) {
        return toShortString(value);
    } else {
        StorageSlot.getStringSlot(store).value = value;
        return ShortString.wrap(_FALLBACK_SENTINEL);
    }
}
```

### toShortString(string)

- **Kind**: internal
- **Source**: 1689:286:94
- **Link**: `lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol:ShortStrings:toShortString(string)`

```solidity
///  @dev Encode a string of at most 31 chars into a `ShortString`.
///  This will trigger a `StringTooLong` error is the input string is too long.
function toShortString(string memory str) internal pure returns (ShortString) {
    bytes memory bstr = bytes(str);
    if (bstr.length > 31) {
        revert StringTooLong(str);
    }
    return ShortString.wrap(bytes32(uint256(bytes32(bstr)) | bstr.length));
}
```

### getStringSlot(string)

- **Kind**: internal
- **Source**: 3310:202:95
- **Link**: `lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol:StorageSlot:getStringSlot(string)`

```solidity
///  @dev Returns an `StringSlot` representation of the string storage pointer `store`.
function getStringSlot(string storage store) internal pure returns (StringSlot storage r) {
    /// @solidity memory-safe-assembly
    assembly {
        r.slot := store.slot
    }
}
```

### _buildDomainSeparator()

- **Kind**: internal
- **Source**: 3963:180:98
- **Link**: `lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol:EIP712:_buildDomainSeparator()`

```solidity
function _buildDomainSeparator() private view returns (bytes32) {
    return keccak256(abi.encode(_TYPE_HASH, _hashedName, _hashedVersion, block.chainid, address(this)));
}
```

### (string,string)

- **Kind**: internal
- **Source**: 1980:113:78
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:constructor(string,string)`

```solidity
///  @dev Sets the values for {name} and {symbol}.
///  All two of these values are immutable: they can only be set once during
///  construction.
constructor(string memory name_, string memory symbol_) {
    _name = name_;
    _symbol = symbol_;
}
```

### (address)

- **Kind**: internal
- **Source**: 806:133:138
- **Link**: `src/Dependencies/Ownable.sol:Ownable:constructor(address)`

```solidity
///  @dev Initializes the contract setting `initialOwner` as the initial owner.
constructor(address initialOwner) {
    _owner = initialOwner;
    emit OwnershipTransferred(address(0), initialOwner);
}
```

## State Variable Reads

- **_nameFallback** (`string`)
- **_versionFallback** (`string`)
- **_FALLBACK_SENTINEL** (`bytes32`)
- **_TYPE_HASH** (`bytes32`)
- **_hashedName** (`bytes32`)
- **_hashedVersion** (`bytes32`)

## State Variable Writes

- **_name** (`ShortString`)
- **_version** (`ShortString`)
- **_hashedName** (`bytes32`)
- **_hashedVersion** (`bytes32`)
- **_cachedChainId** (`uint256`)
- **_cachedDomainSeparator** (`bytes32`)
- **_cachedThis** (`address`)
- **_symbol** (`string`)
- **_owner** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: BoldToken.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: BoldToken
  ├─ [1] 🏗️ CONSTRUCTOR: ERC20Permit.constructor(string) (NodeID: 1)
  │   💬 Args: [_NAME]
  │   🏗️  Contract: ERC20Permit
  │ └─ [2] 🏗️ CONSTRUCTOR: EIP712.constructor(string,string) (NodeID: 2)
  │     💬 Args: [_NAME, "1"]
  │     🏗️  Contract: EIP712
  │   ├─ [3] ⚙️ FUNCTION: ShortStrings.toShortStringWithFallback(string,string) (NodeID: 3)
  │   │   💬 Args: [name, _nameFallback]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: ShortStrings.toShortString(string) (NodeID: 4)
  │   │ │   💬 Args: [value]
  │   │ │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: StorageSlot.getStringSlot(string) (NodeID: 5)
  │   │     💬 Args: [store]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: ShortStrings.toShortStringWithFallback(string,string) (NodeID: 6)
  │   │   💬 Args: [version, _versionFallback]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: ShortStrings.toShortString(string) (NodeID: 7)
  │   │ │   💬 Args: [value]
  │   │ │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: StorageSlot.getStringSlot(string) (NodeID: 8)
  │   │     💬 Args: [store]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EIP712._buildDomainSeparator() (NodeID: 9)
  │       💬 Args: [no args]
  │       👁️  Def: private
  ├─ [1] 🏗️ CONSTRUCTOR: ERC20.constructor(string,string) (NodeID: 10)
  │   💬 Args: [_NAME, _SYMBOL]
  │   🏗️  Contract: ERC20
  └─ [1] 🏗️ CONSTRUCTOR: Ownable.constructor(address) (NodeID: 11)
      💬 Args: [_owner]
      🏗️  Contract: Ownable
```
