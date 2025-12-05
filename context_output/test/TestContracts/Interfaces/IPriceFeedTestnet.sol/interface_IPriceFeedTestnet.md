# Interface: IPriceFeedTestnet

## Metadata

- **Name**: IPriceFeedTestnet
- **Type**: Interface
- **Path**: test/TestContracts/Interfaces/IPriceFeedTestnet.sol

## Implements Interfaces

- **IPriceFeed** [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]

## Public/External Functions

### setPrice(uint256)

- **Signature**: `setPrice(uint256)`
- **Visibility**: external
- **Source Range**: 147:58:268

**Signature:**
```solidity
function setPrice(uint256 _price) external returns (bool);;
```

### getPrice()

- **Signature**: `getPrice()`
- **Visibility**: external
- **Source Range**: 210:52:268

**Signature:**
```solidity
function getPrice() external view returns (uint256);;
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
