# Contract: LiquityBase

## Metadata

- **Name**: LiquityBase
- **Type**: Contract
- **Path**: src/Dependencies/LiquityBase.sol

## Implements Interfaces

- **ILiquityBase** [src/Interfaces/ILiquityBase.sol/interface_ILiquityBase.md]

## State Variables

### activePool

```solidity
IActivePool public activePool
```

**IActivePool**: [src/Interfaces/IActivePool.sol/interface_IActivePool.md]

### defaultPool

```solidity
IDefaultPool internal defaultPool
```

**IDefaultPool**: [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]

### priceFeed

```solidity
IPriceFeed internal priceFeed
```

**IPriceFeed**: [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]

## Events

### ActivePoolAddressChanged

```solidity
event ActivePoolAddressChanged(address _newActivePoolAddress);
```

### DefaultPoolAddressChanged

```solidity
event DefaultPoolAddressChanged(address _newDefaultPoolAddress);
```

### PriceFeedAddressChanged

```solidity
event PriceFeedAddressChanged(address _newPriceFeedAddress);
```

## Public/External Functions

### constructor(contract IAddressesRegistry)

- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 816:401:136
- **Details**: [function_constructor_contract_IAddressesRegistry.md](./function_constructor_contract_IAddressesRegistry.md)

**Signature:**
```solidity
constructor(IAddressesRegistry _addressesRegistry);
```

### getEntireBranchColl()

- **Signature**: `getEntireBranchColl()`
- **Visibility**: public
- **Source Range**: 1265:251:136
- **Details**: [function_getEntireBranchColl.md](./function_getEntireBranchColl.md)

**Signature:**
```solidity
function getEntireBranchColl() public view returns (uint256 entireSystemColl);
```

### getEntireBranchDebt()

- **Signature**: `getEntireBranchDebt()`
- **Visibility**: public
- **Source Range**: 1522:237:136
- **Details**: [function_getEntireBranchDebt.md](./function_getEntireBranchDebt.md)

**Signature:**
```solidity
function getEntireBranchDebt() public view returns (uint256 entireSystemDebt);
```
