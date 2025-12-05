# Contract: WETHPriceFeed

## Metadata

- **Name**: WETHPriceFeed
- **Type**: Contract
- **Path**: src/PriceFeeds/WETHPriceFeed.sol

## Implements Interfaces

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

### constructor(address,uint256,address)

- **Signature**: `constructor(address,uint256,address)`
- **Visibility**: public
- **Source Range**: 186:361:183
- **Details**: [function_constructor_address_uint256_address.md](./function_constructor_address_uint256_address.md)

**Signature:**
```solidity
constructor(address _ethUsdOracleAddress, uint256 _ethUsdStalenessThreshold, address _borrowerOperationsAddress) MainnetPriceFeedBase(_ethUsdOracleAddress,_ethUsdStalenessThreshold,_borrowerOperationsAddress);
```

### fetchPrice()

- **Signature**: `fetchPrice()`
- **Visibility**: public
- **Source Range**: 553:423:183
- **Details**: [function_fetchPrice.md](./function_fetchPrice.md)

**Signature:**
```solidity
function fetchPrice() public returns (uint256, bool);
```

### fetchRedemptionPrice()

- **Signature**: `fetchRedemptionPrice()`
- **Visibility**: external
- **Source Range**: 982:174:183
- **Details**: [function_fetchRedemptionPrice.md](./function_fetchRedemptionPrice.md)

**Signature:**
```solidity
function fetchRedemptionPrice() external returns (uint256, bool);
```
