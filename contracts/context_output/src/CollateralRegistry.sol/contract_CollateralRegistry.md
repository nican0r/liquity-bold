# Contract: CollateralRegistry

## Metadata

- **Name**: CollateralRegistry
- **Type**: Contract
- **Path**: src/CollateralRegistry.sol

## Implements Interfaces

- **ICollateralRegistry** [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

## State Variables

### totalCollaterals

```solidity
uint256 public immutable totalCollaterals
```

### token0

```solidity
IERC20Metadata internal immutable token0
```

**IERC20Metadata**: [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]

### token1

```solidity
IERC20Metadata internal immutable token1
```

**IERC20Metadata**: [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]

### token2

```solidity
IERC20Metadata internal immutable token2
```

**IERC20Metadata**: [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]

### token3

```solidity
IERC20Metadata internal immutable token3
```

**IERC20Metadata**: [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]

### token4

```solidity
IERC20Metadata internal immutable token4
```

**IERC20Metadata**: [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]

### token5

```solidity
IERC20Metadata internal immutable token5
```

**IERC20Metadata**: [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]

### token6

```solidity
IERC20Metadata internal immutable token6
```

**IERC20Metadata**: [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]

### token7

```solidity
IERC20Metadata internal immutable token7
```

**IERC20Metadata**: [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]

### token8

```solidity
IERC20Metadata internal immutable token8
```

**IERC20Metadata**: [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]

### token9

```solidity
IERC20Metadata internal immutable token9
```

**IERC20Metadata**: [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]

### troveManager0

```solidity
ITroveManager internal immutable troveManager0
```

**ITroveManager**: [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

### troveManager1

```solidity
ITroveManager internal immutable troveManager1
```

**ITroveManager**: [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

### troveManager2

```solidity
ITroveManager internal immutable troveManager2
```

**ITroveManager**: [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

### troveManager3

```solidity
ITroveManager internal immutable troveManager3
```

**ITroveManager**: [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

### troveManager4

```solidity
ITroveManager internal immutable troveManager4
```

**ITroveManager**: [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

### troveManager5

```solidity
ITroveManager internal immutable troveManager5
```

**ITroveManager**: [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

### troveManager6

```solidity
ITroveManager internal immutable troveManager6
```

**ITroveManager**: [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

### troveManager7

```solidity
ITroveManager internal immutable troveManager7
```

**ITroveManager**: [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

### troveManager8

```solidity
ITroveManager internal immutable troveManager8
```

**ITroveManager**: [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

### troveManager9

```solidity
ITroveManager internal immutable troveManager9
```

**ITroveManager**: [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

### boldToken

```solidity
IBoldToken public immutable boldToken
```

**IBoldToken**: [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

### baseRate

```solidity
uint256 public baseRate
```

### lastFeeOperationTime

```solidity
uint256 public lastFeeOperationTime = block.timestamp
```

## Structs

### RedemptionTotals

```solidity
struct RedemptionTotals {
    uint256 numCollaterals;
    uint256 boldSupplyAtStart;
    uint256 unbacked;
    uint256 redeemedAmount;
}
```

## Events

### BaseRateUpdated

```solidity
event BaseRateUpdated(uint256 _baseRate);
```

### LastFeeOpTimeUpdated

```solidity
event LastFeeOpTimeUpdated(uint256 _lastFeeOpTime);
```

## Public/External Functions

### constructor(contract IBoldToken,contract IERC20Metadata[],contract ITroveManager[])

- **Signature**: `constructor(contract IBoldToken,contract IERC20Metadata[],contract ITroveManager[])`
- **Visibility**: public
- **Source Range**: 1826:2019:130
- **Details**: [function_constructor_contract_IBoldToken_contract_IERC20Metadata[]_contract_ITroveManager[].md](./function_constructor_contract_IBoldToken_contract_IERC20Metadata[]_contract_ITroveManager[].md)

**Signature:**
```solidity
constructor(IBoldToken _boldToken, IERC20Metadata[] memory _tokens, ITroveManager[] memory _troveManagers);
```

### redeemCollateral(uint256,uint256,uint256)

- **Signature**: `redeemCollateral(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4013:4508:130
- **Details**: [function_redeemCollateral_uint256_uint256_uint256.md](./function_redeemCollateral_uint256_uint256_uint256.md)

**Signature:**
```solidity
function redeemCollateral(uint256 _boldAmount, uint256 _maxIterationsPerCollateral, uint256 _maxFeePercentage) external;
```

### getRedemptionRate()

- **Signature**: `getRedemptionRate()`
- **Visibility**: external
- **Source Range**: 11451:123:130
- **Details**: [function_getRedemptionRate.md](./function_getRedemptionRate.md)

**Signature:**
```solidity
function getRedemptionRate() override external view returns (uint256);
```

### getRedemptionRateWithDecay()

- **Signature**: `getRedemptionRateWithDecay()`
- **Visibility**: public
- **Source Range**: 11580:144:130
- **Details**: [function_getRedemptionRateWithDecay.md](./function_getRedemptionRateWithDecay.md)

**Signature:**
```solidity
function getRedemptionRateWithDecay() override public view returns (uint256);
```

### getRedemptionRateForRedeemedAmount(uint256)

- **Signature**: `getRedemptionRateForRedeemedAmount(uint256)`
- **Visibility**: external
- **Source Range**: 11730:311:130
- **Details**: [function_getRedemptionRateForRedeemedAmount_uint256.md](./function_getRedemptionRateForRedeemedAmount_uint256.md)

**Signature:**
```solidity
function getRedemptionRateForRedeemedAmount(uint256 _redeemAmount) external view returns (uint256);
```

### getRedemptionFeeWithDecay(uint256)

- **Signature**: `getRedemptionFeeWithDecay(uint256)`
- **Visibility**: external
- **Source Range**: 12047:178:130
- **Details**: [function_getRedemptionFeeWithDecay_uint256.md](./function_getRedemptionFeeWithDecay_uint256.md)

**Signature:**
```solidity
function getRedemptionFeeWithDecay(uint256 _ETHDrawn) override external view returns (uint256);
```

### getEffectiveRedemptionFeeInBold(uint256)

- **Signature**: `getEffectiveRedemptionFeeInBold(uint256)`
- **Visibility**: external
- **Source Range**: 12231:352:130
- **Details**: [function_getEffectiveRedemptionFeeInBold_uint256.md](./function_getEffectiveRedemptionFeeInBold_uint256.md)

**Signature:**
```solidity
function getEffectiveRedemptionFeeInBold(uint256 _redeemAmount) override external view returns (uint256);
```

### getToken(uint256)

- **Signature**: `getToken(uint256)`
- **Visibility**: external
- **Source Range**: 12605:563:130
- **Details**: [function_getToken_uint256.md](./function_getToken_uint256.md)

**Signature:**
```solidity
function getToken(uint256 _index) external view returns (IERC20Metadata);
```

### getTroveManager(uint256)

- **Signature**: `getTroveManager(uint256)`
- **Visibility**: public
- **Source Range**: 13174:637:130
- **Details**: [function_getTroveManager_uint256.md](./function_getTroveManager_uint256.md)

**Signature:**
```solidity
function getTroveManager(uint256 _index) public view returns (ITroveManager);
```
