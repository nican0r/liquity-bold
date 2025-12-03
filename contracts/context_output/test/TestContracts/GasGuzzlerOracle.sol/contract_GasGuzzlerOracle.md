# Contract: GasGuzzlerOracle

## Metadata

- **Name**: GasGuzzlerOracle
- **Type**: Contract
- **Path**: test/TestContracts/GasGuzzlerOracle.sol

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

### pointlessStorageVar

```solidity
uint256 internal pointlessStorageVar = 42
```

## Public/External Functions

### decimals()

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 466:81:264
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
function decimals() external view returns (uint8);
```

### latestRoundData()

- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 553:423:264
- **Details**: [function_latestRoundData.md](./function_latestRoundData.md)

**Signature:**
```solidity
function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
```

### setDecimals(uint8)

- **Signature**: `setDecimals(uint8)`
- **Visibility**: external
- **Source Range**: 982:83:264
- **Details**: [function_setDecimals_uint8.md](./function_setDecimals_uint8.md)

**Signature:**
```solidity
function setDecimals(uint8 _decimals) external;
```

### setPrice(int256)

- **Signature**: `setPrice(int256)`
- **Visibility**: external
- **Source Range**: 1071:73:264
- **Details**: [function_setPrice_int256.md](./function_setPrice_int256.md)

**Signature:**
```solidity
function setPrice(int256 _price) external;
```

### setUpdatedAt(uint256)

- **Signature**: `setUpdatedAt(uint256)`
- **Visibility**: external
- **Source Range**: 1150:95:264
- **Details**: [function_setUpdatedAt_uint256.md](./function_setUpdatedAt_uint256.md)

**Signature:**
```solidity
function setUpdatedAt(uint256 _updatedAt) external;
```
