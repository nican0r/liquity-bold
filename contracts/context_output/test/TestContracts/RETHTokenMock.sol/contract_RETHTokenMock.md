# Contract: RETHTokenMock

## Metadata

- **Name**: RETHTokenMock
- **Type**: Contract
- **Path**: test/TestContracts/RETHTokenMock.sol

## Implements Interfaces

- **IRETHToken** [src/Interfaces/IRETHToken.sol/interface_IRETHToken.md]

## State Variables

### ethPerReth

```solidity
uint256 internal ethPerReth
```

## Public/External Functions

### getExchangeRate()

- **Signature**: `getExchangeRate()`
- **Visibility**: external
- **Source Range**: 208:93:279
- **Details**: [function_getExchangeRate.md](./function_getExchangeRate.md)

**Signature:**
```solidity
function getExchangeRate() external view returns (uint256);
```

### setExchangeRate(uint256)

- **Signature**: `setExchangeRate(uint256)`
- **Visibility**: external
- **Source Range**: 307:96:279
- **Details**: [function_setExchangeRate_uint256.md](./function_setExchangeRate_uint256.md)

**Signature:**
```solidity
function setExchangeRate(uint256 _ethPerReth) external;
```
