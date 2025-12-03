# Contract: PriceFeedMock

## Metadata

- **Name**: PriceFeedMock
- **Type**: Contract
- **Path**: test/TestContracts/PriceFeedMock.sol

## Implements Interfaces

- **IPriceFeedMock** [test/TestContracts/Interfaces/IPriceFeedMock.sol/interface_IPriceFeedMock.md]
- **IPriceFeed** [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]

## State Variables

### PRICE

```solidity
uint256 private PRICE
```

## Public/External Functions

### setPrice(uint256)

- **Signature**: `setPrice(uint256)`
- **Visibility**: external
- **Source Range**: 176:74:277
- **Details**: [function_setPrice_uint256.md](./function_setPrice_uint256.md)

**Signature:**
```solidity
function setPrice(uint256 _price) external;
```

### getPrice()

- **Signature**: `getPrice()`
- **Visibility**: external
- **Source Range**: 256:88:277
- **Details**: [function_getPrice.md](./function_getPrice.md)

**Signature:**
```solidity
function getPrice() external view returns (uint256 _price);
```

### fetchPrice()

- **Signature**: `fetchPrice()`
- **Visibility**: external
- **Source Range**: 350:98:277
- **Details**: [function_fetchPrice.md](./function_fetchPrice.md)

**Signature:**
```solidity
function fetchPrice() external view returns (uint256, bool);
```

### fetchRedemptionPrice()

- **Signature**: `fetchRedemptionPrice()`
- **Visibility**: external
- **Source Range**: 454:108:277
- **Details**: [function_fetchRedemptionPrice.md](./function_fetchRedemptionPrice.md)

**Signature:**
```solidity
function fetchRedemptionPrice() external view returns (uint256, bool);
```

### lastGoodPrice()

- **Signature**: `lastGoodPrice()`
- **Visibility**: external
- **Source Range**: 568:86:277
- **Details**: [function_lastGoodPrice.md](./function_lastGoodPrice.md)

**Signature:**
```solidity
function lastGoodPrice() external view returns (uint256);
```

### getEthUsdStalenessThreshold()

- **Signature**: `getEthUsdStalenessThreshold()`
- **Visibility**: external
- **Source Range**: 660:96:277
- **Details**: [function_getEthUsdStalenessThreshold.md](./function_getEthUsdStalenessThreshold.md)

**Signature:**
```solidity
function getEthUsdStalenessThreshold() external pure returns (uint256);
```
