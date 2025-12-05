# Contract: PriceFeedTestnet

## Metadata

- **Name**: PriceFeedTestnet
- **Type**: Contract
- **Path**: test/TestContracts/PriceFeedTestnet.sol

## Implements Interfaces

- **IPriceFeedTestnet** [test/TestContracts/Interfaces/IPriceFeedTestnet.sol/interface_IPriceFeedTestnet.md]
- **IPriceFeed** [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]

## State Variables

### _price

```solidity
uint256 private _price = 200 * 1e18
```

## Events

### LastGoodPriceUpdated

```solidity
event LastGoodPriceUpdated(uint256 _lastGoodPrice);
```

## Public/External Functions

### getPrice()

- **Signature**: `getPrice()`
- **Visibility**: external
- **Source Range**: 520:91:278
- **Details**: [function_getPrice.md](./function_getPrice.md)

**Signature:**
```solidity
function getPrice() override external view returns (uint256);
```

### lastGoodPrice()

- **Signature**: `lastGoodPrice()`
- **Visibility**: external
- **Source Range**: 617:87:278
- **Details**: [function_lastGoodPrice.md](./function_lastGoodPrice.md)

**Signature:**
```solidity
function lastGoodPrice() external view returns (uint256);
```

### fetchPrice()

- **Signature**: `fetchPrice()`
- **Visibility**: external
- **Source Range**: 710:311:278
- **Details**: [function_fetchPrice.md](./function_fetchPrice.md)

**Signature:**
```solidity
function fetchPrice() override external returns (uint256, bool);
```

### fetchRedemptionPrice()

- **Signature**: `fetchRedemptionPrice()`
- **Visibility**: external
- **Source Range**: 1027:321:278
- **Details**: [function_fetchRedemptionPrice.md](./function_fetchRedemptionPrice.md)

**Signature:**
```solidity
function fetchRedemptionPrice() override external returns (uint256, bool);
```

### setPrice(uint256)

- **Signature**: `setPrice(uint256)`
- **Visibility**: external
- **Source Range**: 1391:109:278
- **Details**: [function_setPrice_uint256.md](./function_setPrice_uint256.md)

**Signature:**
```solidity
function setPrice(uint256 price) external returns (bool);
```
