# Contract: UniPriceConverterLog

## Metadata

- **Name**: UniPriceConverterLog
- **Type**: Contract
- **Path**: test/Utils/UniPriceConverterLog.sol

## Public/External Functions

### priceToSqrtPrice(uint256)

- **Signature**: `priceToSqrtPrice(uint256)`
- **Visibility**: public
- **Source Range**: 523:895:295
- **Details**: [function_priceToSqrtPrice_uint256.md](./function_priceToSqrtPrice_uint256.md)

**Signature:**
```solidity
function priceToSqrtPrice(uint256 _price) public pure returns (uint256, uint256, uint256);
```

### sqrtPriceToPrice(uint160)

- **Signature**: `sqrtPriceToPrice(uint160)`
- **Visibility**: public
- **Source Range**: 1424:421:295
- **Details**: [function_sqrtPriceToPrice_uint160.md](./function_sqrtPriceToPrice_uint160.md)

**Signature:**
```solidity
function sqrtPriceToPrice(uint160 _sqrtPriceX96) public pure returns (uint256 price);
```

### priceToSqrtPriceX96(uint256) (inherited from UniPriceConverter)

- **Signature**: `priceToSqrtPriceX96(uint256)`
- **Visibility**: public
- **Source Range**: 230:378:222
- **Details**: [function_priceToSqrtPriceX96_uint256.md](./function_priceToSqrtPriceX96_uint256.md)

**Signature:**
```solidity
function priceToSqrtPriceX96(uint256 _price) public pure returns (uint160 sqrtPriceX96);
```

### sqrtPriceX96ToPrice(uint160) (inherited from UniPriceConverter)

- **Signature**: `sqrtPriceX96ToPrice(uint160)`
- **Visibility**: public
- **Source Range**: 614:539:222
- **Details**: [function_sqrtPriceX96ToPrice_uint160.md](./function_sqrtPriceX96ToPrice_uint160.md)

**Signature:**
```solidity
function sqrtPriceX96ToPrice(uint160 _sqrtPriceX96) public pure returns (uint256 price);
```
