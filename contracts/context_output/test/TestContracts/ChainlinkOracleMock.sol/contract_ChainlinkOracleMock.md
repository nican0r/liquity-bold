# Contract: ChainlinkOracleMock

## Metadata

- **Name**: ChainlinkOracleMock
- **Type**: Contract
- **Path**: test/TestContracts/ChainlinkOracleMock.sol

## Implements Interfaces

- **AggregatorV3Interface** [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]

## State Variables

### decimal

```solidity
uint8 internal decimal
```

### price

```solidity
int256 internal price
```

### lastUpdateTime

```solidity
uint256 internal lastUpdateTime
```

## Public/External Functions

### decimals()

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 432:81:257
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
function decimals() external view returns (uint8);
```

### latestRoundData()

- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 519:407:257
- **Details**: [function_latestRoundData.md](./function_latestRoundData.md)

**Signature:**
```solidity
function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
```

### setDecimals(uint8)

- **Signature**: `setDecimals(uint8)`
- **Visibility**: external
- **Source Range**: 932:83:257
- **Details**: [function_setDecimals_uint8.md](./function_setDecimals_uint8.md)

**Signature:**
```solidity
function setDecimals(uint8 _decimals) external;
```

### setPrice(int256)

- **Signature**: `setPrice(int256)`
- **Visibility**: external
- **Source Range**: 1021:73:257
- **Details**: [function_setPrice_int256.md](./function_setPrice_int256.md)

**Signature:**
```solidity
function setPrice(int256 _price) external;
```

### setUpdatedAt(uint256)

- **Signature**: `setUpdatedAt(uint256)`
- **Visibility**: external
- **Source Range**: 1100:95:257
- **Details**: [function_setUpdatedAt_uint256.md](./function_setUpdatedAt_uint256.md)

**Signature:**
```solidity
function setUpdatedAt(uint256 _updatedAt) external;
```
