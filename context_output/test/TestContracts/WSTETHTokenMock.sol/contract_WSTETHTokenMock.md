# Contract: WSTETHTokenMock

## Metadata

- **Name**: WSTETHTokenMock
- **Type**: Contract
- **Path**: test/TestContracts/WSTETHTokenMock.sol

## Implements Interfaces

- **IWSTETH** [src/Interfaces/IWSTETH.sol/interface_IWSTETH.md]

## Public/External Functions

### stEthPerToken()

- **Signature**: `stEthPerToken()`
- **Visibility**: external
- **Source Range**: 138:82:285
- **Details**: [function_stEthPerToken.md](./function_stEthPerToken.md)

**Signature:**
```solidity
function stEthPerToken() external pure returns (uint256);
```

### wrap(uint256)

- **Signature**: `wrap(uint256)`
- **Visibility**: external
- **Source Range**: 226:104:285
- **Details**: [function_wrap_uint256.md](./function_wrap_uint256.md)

**Signature:**
```solidity
function wrap(uint256 _stETHAmount) external pure returns (uint256);
```

### unwrap(uint256)

- **Signature**: `unwrap(uint256)`
- **Visibility**: external
- **Source Range**: 336:108:285
- **Details**: [function_unwrap_uint256.md](./function_unwrap_uint256.md)

**Signature:**
```solidity
function unwrap(uint256 _wstETHAmount) external pure returns (uint256);
```

### getWstETHByStETH(uint256)

- **Signature**: `getWstETHByStETH(uint256)`
- **Visibility**: external
- **Source Range**: 450:116:285
- **Details**: [function_getWstETHByStETH_uint256.md](./function_getWstETHByStETH_uint256.md)

**Signature:**
```solidity
function getWstETHByStETH(uint256 _stETHAmount) external pure returns (uint256);
```

### getStETHByWstETH(uint256)

- **Signature**: `getStETHByWstETH(uint256)`
- **Visibility**: external
- **Source Range**: 572:118:285
- **Details**: [function_getStETHByWstETH_uint256.md](./function_getStETHByWstETH_uint256.md)

**Signature:**
```solidity
function getStETHByWstETH(uint256 _wstETHAmount) external pure returns (uint256);
```

### tokensPerStEth()

- **Signature**: `tokensPerStEth()`
- **Visibility**: external
- **Source Range**: 696:83:285
- **Details**: [function_tokensPerStEth.md](./function_tokensPerStEth.md)

**Signature:**
```solidity
function tokensPerStEth() external pure returns (uint256);
```
