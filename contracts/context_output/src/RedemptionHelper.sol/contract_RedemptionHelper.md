# Contract: RedemptionHelper

## Metadata

- **Name**: RedemptionHelper
- **Type**: Contract
- **Path**: src/RedemptionHelper.sol

## Implements Interfaces

- **IRedemptionHelper** [src/Interfaces/IRedemptionHelper.sol/interface_IRedemptionHelper.md]

## State Variables

### numBranches

```solidity
uint256 public immutable numBranches
```

### collateralRegistry

```solidity
ICollateralRegistry public immutable collateralRegistry
```

**ICollateralRegistry**: [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

### boldToken

```solidity
IBoldToken public immutable boldToken
```

**IBoldToken**: [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

### addresses

```solidity
IAddressesRegistry[] public addresses
```

**IAddressesRegistry**: [src/Interfaces/IAddressesRegistry.sol/interface_IAddressesRegistry.md]

## Structs

### SimulationContext (inherited from IRedemptionHelper)

```solidity
struct SimulationContext {
    address troveManager;
    address sortedTroves;
    bool redeemable;
    uint256 price;
    uint256 proportion;
    uint256 attemptedBold;
    uint256 redeemedBold;
    uint256 iterations;
}
```

### Redeemed (inherited from IRedemptionHelper)

```solidity
struct Redeemed {
    uint256 bold;
    uint256 coll;
}
```

### RedemptionContext

```solidity
struct RedemptionContext {
    IERC20 collToken;
    uint256 collBalanceBefore;
}
```

## Public/External Functions

### constructor(contract ICollateralRegistry,contract IAddressesRegistry[])

- **Signature**: `constructor(contract ICollateralRegistry,contract IAddressesRegistry[])`
- **Visibility**: public
- **Source Range**: 1276:659:185
- **Details**: [function_constructor_contract_ICollateralRegistry_contract_IAddressesRegistry[].md](./function_constructor_contract_ICollateralRegistry_contract_IAddressesRegistry[].md)

**Signature:**
```solidity
constructor(ICollateralRegistry _collateralRegistry, IAddressesRegistry[] memory _addresses);
```

### simulateRedemption(uint256,uint256)

- **Signature**: `simulateRedemption(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 2035:2842:185
- **Details**: [function_simulateRedemption_uint256_uint256.md](./function_simulateRedemption_uint256_uint256.md)

**Signature:**
```solidity
function simulateRedemption(uint256 _bold, uint256 _maxIterationsPerCollateral) public returns (SimulationContext[] memory branch, uint256 totalProportions);
```

### truncateRedemption(uint256,uint256)

- **Signature**: `truncateRedemption(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4977:2055:185
- **Details**: [function_truncateRedemption_uint256_uint256.md](./function_truncateRedemption_uint256_uint256.md)

**Signature:**
```solidity
function truncateRedemption(uint256 _bold, uint256 _maxIterationsPerCollateral) external returns (uint256 truncatedBold, uint256 feePct, Redeemed[] memory redeemed);
```

### redeemCollateral(uint256,uint256,uint256,uint256[])

- **Signature**: `redeemCollateral(uint256,uint256,uint256,uint256[])`
- **Visibility**: external
- **Source Range**: 7038:1339:185
- **Details**: [function_redeemCollateral_uint256_uint256_uint256_uint256[].md](./function_redeemCollateral_uint256_uint256_uint256_uint256[].md)

**Signature:**
```solidity
function redeemCollateral(uint256 _bold, uint256 _maxIterationsPerCollateral, uint256 _maxFeePct, uint256[] memory _minCollRedeemed) external;
```
