# Interface: IAddressesRegistry

## Metadata

- **Name**: IAddressesRegistry
- **Type**: Interface
- **Path**: src/Interfaces/IAddressesRegistry.sol

## Structs

### AddressVars

```solidity
struct AddressVars {
    IERC20Metadata collToken;
    IBorrowerOperations borrowerOperations;
    ITroveManager troveManager;
    ITroveNFT troveNFT;
    IMetadataNFT metadataNFT;
    IStabilityPool stabilityPool;
    IPriceFeed priceFeed;
    IActivePool activePool;
    IDefaultPool defaultPool;
    address gasPoolAddress;
    ICollSurplusPool collSurplusPool;
    ISortedTroves sortedTroves;
    IInterestRouter interestRouter;
    IHintHelpers hintHelpers;
    IMultiTroveGetter multiTroveGetter;
    ICollateralRegistry collateralRegistry;
    IBoldToken boldToken;
    IWETH WETH;
}
```

## Public/External Functions

### CCR()

- **Signature**: `CCR()`
- **Visibility**: external
- **Source Range**: 1255:42:143

**Signature:**
```solidity
function CCR() external returns (uint256);;
```

### SCR()

- **Signature**: `SCR()`
- **Visibility**: external
- **Source Range**: 1302:42:143

**Signature:**
```solidity
function SCR() external returns (uint256);;
```

### MCR()

- **Signature**: `MCR()`
- **Visibility**: external
- **Source Range**: 1349:42:143

**Signature:**
```solidity
function MCR() external returns (uint256);;
```

### BCR()

- **Signature**: `BCR()`
- **Visibility**: external
- **Source Range**: 1396:42:143

**Signature:**
```solidity
function BCR() external returns (uint256);;
```

### LIQUIDATION_PENALTY_SP()

- **Signature**: `LIQUIDATION_PENALTY_SP()`
- **Visibility**: external
- **Source Range**: 1443:61:143

**Signature:**
```solidity
function LIQUIDATION_PENALTY_SP() external returns (uint256);;
```

### LIQUIDATION_PENALTY_REDISTRIBUTION()

- **Signature**: `LIQUIDATION_PENALTY_REDISTRIBUTION()`
- **Visibility**: external
- **Source Range**: 1509:73:143

**Signature:**
```solidity
function LIQUIDATION_PENALTY_REDISTRIBUTION() external returns (uint256);;
```

### collToken()

- **Signature**: `collToken()`
- **Visibility**: external
- **Source Range**: 1588:60:143

**Signature:**
```solidity
function collToken() external view returns (IERC20Metadata);;
```

### borrowerOperations()

- **Signature**: `borrowerOperations()`
- **Visibility**: external
- **Source Range**: 1653:74:143

**Signature:**
```solidity
function borrowerOperations() external view returns (IBorrowerOperations);;
```

### troveManager()

- **Signature**: `troveManager()`
- **Visibility**: external
- **Source Range**: 1732:62:143

**Signature:**
```solidity
function troveManager() external view returns (ITroveManager);;
```

### troveNFT()

- **Signature**: `troveNFT()`
- **Visibility**: external
- **Source Range**: 1799:54:143

**Signature:**
```solidity
function troveNFT() external view returns (ITroveNFT);;
```

### metadataNFT()

- **Signature**: `metadataNFT()`
- **Visibility**: external
- **Source Range**: 1858:60:143

**Signature:**
```solidity
function metadataNFT() external view returns (IMetadataNFT);;
```

### stabilityPool()

- **Signature**: `stabilityPool()`
- **Visibility**: external
- **Source Range**: 1923:64:143

**Signature:**
```solidity
function stabilityPool() external view returns (IStabilityPool);;
```

### priceFeed()

- **Signature**: `priceFeed()`
- **Visibility**: external
- **Source Range**: 1992:56:143

**Signature:**
```solidity
function priceFeed() external view returns (IPriceFeed);;
```

### activePool()

- **Signature**: `activePool()`
- **Visibility**: external
- **Source Range**: 2053:58:143

**Signature:**
```solidity
function activePool() external view returns (IActivePool);;
```

### defaultPool()

- **Signature**: `defaultPool()`
- **Visibility**: external
- **Source Range**: 2116:60:143

**Signature:**
```solidity
function defaultPool() external view returns (IDefaultPool);;
```

### gasPoolAddress()

- **Signature**: `gasPoolAddress()`
- **Visibility**: external
- **Source Range**: 2181:58:143

**Signature:**
```solidity
function gasPoolAddress() external view returns (address);;
```

### collSurplusPool()

- **Signature**: `collSurplusPool()`
- **Visibility**: external
- **Source Range**: 2244:68:143

**Signature:**
```solidity
function collSurplusPool() external view returns (ICollSurplusPool);;
```

### sortedTroves()

- **Signature**: `sortedTroves()`
- **Visibility**: external
- **Source Range**: 2317:62:143

**Signature:**
```solidity
function sortedTroves() external view returns (ISortedTroves);;
```

### interestRouter()

- **Signature**: `interestRouter()`
- **Visibility**: external
- **Source Range**: 2384:66:143

**Signature:**
```solidity
function interestRouter() external view returns (IInterestRouter);;
```

### hintHelpers()

- **Signature**: `hintHelpers()`
- **Visibility**: external
- **Source Range**: 2455:60:143

**Signature:**
```solidity
function hintHelpers() external view returns (IHintHelpers);;
```

### multiTroveGetter()

- **Signature**: `multiTroveGetter()`
- **Visibility**: external
- **Source Range**: 2520:70:143

**Signature:**
```solidity
function multiTroveGetter() external view returns (IMultiTroveGetter);;
```

### collateralRegistry()

- **Signature**: `collateralRegistry()`
- **Visibility**: external
- **Source Range**: 2595:74:143

**Signature:**
```solidity
function collateralRegistry() external view returns (ICollateralRegistry);;
```

### boldToken()

- **Signature**: `boldToken()`
- **Visibility**: external
- **Source Range**: 2674:56:143

**Signature:**
```solidity
function boldToken() external view returns (IBoldToken);;
```

### WETH()

- **Signature**: `WETH()`
- **Visibility**: external
- **Source Range**: 2735:41:143

**Signature:**
```solidity
function WETH() external returns (IWETH);;
```

### setAddresses(struct IAddressesRegistry.AddressVars)

- **Signature**: `setAddresses(struct IAddressesRegistry.AddressVars)`
- **Visibility**: external
- **Source Range**: 2782:57:143

**Signature:**
```solidity
function setAddresses(AddressVars memory _vars) external;;
```
