# Contract: AddRemoveManagersTester

## Metadata

- **Name**: AddRemoveManagersTester
- **Type**: Contract
- **Path**: test/TestContracts/AddRemoveManagersTester.sol

## Implements Interfaces

- **IAddRemoveManagers** [src/Interfaces/IAddRemoveManagers.sol/interface_IAddRemoveManagers.md]

## State Variables

### troveNFT (inherited from AddRemoveManagers)

```solidity
ITroveNFT internal immutable troveNFT
```

**ITroveNFT**: [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

### addManagerOf (inherited from AddRemoveManagers)

```solidity
mapping(uint256 => address) public addManagerOf
```

### removeManagerReceiverOf (inherited from AddRemoveManagers)

```solidity
mapping(uint256 => RemoveManagerReceiver) public removeManagerReceiverOf
```

## Structs

### RemoveManagerReceiver (inherited from AddRemoveManagers)

```solidity
struct RemoveManagerReceiver {
    address manager;
    address receiver;
}
```

## Errors

### EmptyManager (inherited from AddRemoveManagers)

```solidity
error EmptyManager();
```

### NotBorrower (inherited from AddRemoveManagers)

```solidity
error NotBorrower();
```

### NotOwnerNorAddManager (inherited from AddRemoveManagers)

```solidity
error NotOwnerNorAddManager();
```

### NotOwnerNorRemoveManager (inherited from AddRemoveManagers)

```solidity
error NotOwnerNorRemoveManager();
```

## Events

### TroveNFTAddressChanged (inherited from AddRemoveManagers)

```solidity
event TroveNFTAddressChanged(address _newTroveNFTAddress);
```

### AddManagerUpdated (inherited from AddRemoveManagers)

```solidity
event AddManagerUpdated(uint256 indexed _troveId, address _newAddManager);
```

### RemoveManagerAndReceiverUpdated (inherited from AddRemoveManagers)

```solidity
event RemoveManagerAndReceiverUpdated(uint256 indexed _troveId, address _newRemoveManager, address _newReceiver);
```

## Public/External Functions

### constructor(contract IAddressesRegistry)

- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 168:91:249
- **Details**: [function_constructor_contract_IAddressesRegistry.md](./function_constructor_contract_IAddressesRegistry.md)

**Signature:**
```solidity
constructor(IAddressesRegistry _addressesRegistry) AddRemoveManagers(_addressesRegistry);
```

### setRemoveManagerWithReceiverPermissionless(uint256,address,address)

- **Signature**: `setRemoveManagerWithReceiverPermissionless(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 265:190:249
- **Details**: [function_setRemoveManagerWithReceiverPermissionless_uint256_address_address.md](./function_setRemoveManagerWithReceiverPermissionless_uint256_address_address.md)

**Signature:**
```solidity
function setRemoveManagerWithReceiverPermissionless(uint256 _troveId, address _manager, address _receiver) public;
```

### requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address)

- **Signature**: `requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address)`
- **Visibility**: external
- **Source Range**: 461:245:249
- **Details**: [function_requireSenderIsOwnerOrRemoveManagerAndGetReceiver_uint256_address.md](./function_requireSenderIsOwnerOrRemoveManagerAndGetReceiver_uint256_address.md)

**Signature:**
```solidity
function requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256 _troveId, address _owner) external view returns (address);
```

### setAddManager(uint256,address) (inherited from AddRemoveManagers)

- **Signature**: `setAddManager(uint256,address)`
- **Visibility**: external
- **Source Range**: 2158:163:133
- **Details**: [function_setAddManager_uint256_address.md](./function_setAddManager_uint256_address.md)

**Signature:**
```solidity
function setAddManager(uint256 _troveId, address _manager) external;
```

### setRemoveManager(uint256,address) (inherited from AddRemoveManagers)

- **Signature**: `setRemoveManager(uint256,address)`
- **Visibility**: external
- **Source Range**: 2504:164:133
- **Details**: [function_setRemoveManager_uint256_address.md](./function_setRemoveManager_uint256_address.md)

**Signature:**
```solidity
function setRemoveManager(uint256 _troveId, address _manager) external;
```

### setRemoveManagerWithReceiver(uint256,address,address) (inherited from AddRemoveManagers)

- **Signature**: `setRemoveManagerWithReceiver(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 2674:220:133
- **Details**: [function_setRemoveManagerWithReceiver_uint256_address_address.md](./function_setRemoveManagerWithReceiver_uint256_address_address.md)

**Signature:**
```solidity
function setRemoveManagerWithReceiver(uint256 _troveId, address _manager, address _receiver) public;
```
