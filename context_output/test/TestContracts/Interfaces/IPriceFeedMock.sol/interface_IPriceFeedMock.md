# Interface: IPriceFeedMock

## Metadata

- **Name**: IPriceFeedMock
- **Type**: Interface
- **Path**: test/TestContracts/Interfaces/IPriceFeedMock.sol

## Implements Interfaces

- **IPriceFeed** [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]

## Public/External Functions

### setPrice(uint256)

- **Signature**: `setPrice(uint256)`
- **Visibility**: external
- **Source Range**: 145:43:267

**Signature:**
```solidity
function setPrice(uint256 _price) external;;
```

### fetchPrice() (inherited from IPriceFeed)

- **Signature**: `fetchPrice()`
- **Visibility**: external
- **Source Range**: 85:55:159

**Signature:**
```solidity
function fetchPrice() external returns (uint256, bool);;
```

### fetchRedemptionPrice() (inherited from IPriceFeed)

- **Signature**: `fetchRedemptionPrice()`
- **Visibility**: external
- **Source Range**: 145:65:159

**Signature:**
```solidity
function fetchRedemptionPrice() external returns (uint256, bool);;
```

### lastGoodPrice() (inherited from IPriceFeed)

- **Signature**: `lastGoodPrice()`
- **Visibility**: external
- **Source Range**: 215:57:159

**Signature:**
```solidity
function lastGoodPrice() external view returns (uint256);;
```
