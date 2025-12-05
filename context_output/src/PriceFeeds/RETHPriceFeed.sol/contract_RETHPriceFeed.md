# Contract: RETHPriceFeed

## Metadata

- **Name**: RETHPriceFeed
- **Type**: Contract
- **Path**: src/PriceFeeds/RETHPriceFeed.sol

## Implements Interfaces

- **IRETHPriceFeed** [src/Interfaces/IRETHPriceFeed.sol/interface_IRETHPriceFeed.md]
- **IMainnetPriceFeed** [src/Interfaces/IMainnetPriceFeed.sol/interface_IMainnetPriceFeed.md]
- **IPriceFeed** [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]

## State Variables

### priceSource (inherited from MainnetPriceFeedBase)

```solidity
PriceSource public priceSource
```

### lastGoodPrice (inherited from MainnetPriceFeedBase)

```solidity
uint256 public lastGoodPrice
```

### ethUsdOracle (inherited from MainnetPriceFeedBase)

```solidity
Oracle public ethUsdOracle
```

### borrowerOperations (inherited from MainnetPriceFeedBase)

```solidity
IBorrowerOperations internal borrowerOperations
```

**IBorrowerOperations**: [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]

### rateProviderAddress (inherited from CompositePriceFeed)

```solidity
address public rateProviderAddress
```

### rEthEthOracle

```solidity
Oracle public rEthEthOracle
```

### RETH_ETH_DEVIATION_THRESHOLD

```solidity
uint256 public constant RETH_ETH_DEVIATION_THRESHOLD = 2e16
```

## Structs

### Oracle (inherited from MainnetPriceFeedBase)

```solidity
struct Oracle {
    AggregatorV3Interface aggregator;
    uint256 stalenessThreshold;
    uint8 decimals;
}
```

### ChainlinkResponse (inherited from MainnetPriceFeedBase)

```solidity
struct ChainlinkResponse {
    uint80 roundId;
    int256 answer;
    uint256 timestamp;
    bool success;
}
```

## Errors

### InsufficientGasForExternalCall (inherited from MainnetPriceFeedBase)

```solidity
error InsufficientGasForExternalCall();
```

## Events

### ShutDownFromOracleFailure (inherited from MainnetPriceFeedBase)

```solidity
event ShutDownFromOracleFailure(address _failedOracleAddr);
```

## Enums

### PriceSource (inherited from IMainnetPriceFeed)

```solidity
enum PriceSource {
    primary,
    ETHUSDxCanonical,
    lastGoodPrice
}
```

## Public/External Functions

### constructor(address,address,address,uint256,uint256,address)

- **Signature**: `constructor(address,address,address,uint256,uint256,address)`
- **Visibility**: public
- **Source Range**: 280:787:182
- **Details**: [function_constructor_address_address_address_uint256_uint256_address.md](./function_constructor_address_address_address_uint256_uint256_address.md)

**Signature:**
```solidity
constructor(address _ethUsdOracleAddress, address _rEthEthOracleAddress, address _rEthTokenAddress, uint256 _ethUsdStalenessThreshold, uint256 _rEthEthStalenessThreshold, address _borrowerOperationsAddress) CompositePriceFeed(_ethUsdOracleAddress,_rEthTokenAddress,_ethUsdStalenessThreshold,_borrowerOperationsAddress);
```

### fetchPrice() (inherited from CompositePriceFeed)

- **Signature**: `fetchPrice()`
- **Visibility**: public
- **Source Range**: 1086:277:180
- **Details**: [function_fetchPrice.md](./function_fetchPrice.md)

**Signature:**
```solidity
function fetchPrice() public returns (uint256, bool);
```

### fetchRedemptionPrice() (inherited from CompositePriceFeed)

- **Signature**: `fetchRedemptionPrice()`
- **Visibility**: external
- **Source Range**: 1369:288:180
- **Details**: [function_fetchRedemptionPrice.md](./function_fetchRedemptionPrice.md)

**Signature:**
```solidity
function fetchRedemptionPrice() external returns (uint256, bool);
```
