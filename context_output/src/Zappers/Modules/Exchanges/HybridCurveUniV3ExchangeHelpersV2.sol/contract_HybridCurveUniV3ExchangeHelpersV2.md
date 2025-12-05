# Contract: HybridCurveUniV3ExchangeHelpersV2

## Metadata

- **Name**: HybridCurveUniV3ExchangeHelpersV2
- **Type**: Contract
- **Path**: src/Zappers/Modules/Exchanges/HybridCurveUniV3ExchangeHelpersV2.sol

## Implements Interfaces

- **IExchangeHelpersV2** [src/Zappers/Interfaces/IExchangeHelpersV2.sol/interface_IExchangeHelpersV2.md]

## State Variables

### USDC

```solidity
address public immutable USDC
```

### WETH

```solidity
address public immutable WETH
```

### curvePool

```solidity
ICurveStableswapNGPool public immutable curvePool
```

**ICurveStableswapNGPool**: [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGPool.sol/interface_ICurveStableswapNGPool.md]

### USDC_INDEX

```solidity
int128 public immutable USDC_INDEX
```

### BOLD_TOKEN_INDEX

```solidity
int128 public immutable BOLD_TOKEN_INDEX
```

### feeUsdcWeth

```solidity
uint24 public immutable feeUsdcWeth
```

### feeWethColl

```solidity
uint24 public immutable feeWethColl
```

### uniV3Quoter

```solidity
IQuoterV2 public immutable uniV3Quoter
```

**IQuoterV2**: [src/Zappers/Modules/Exchanges/UniswapV3/IQuoterV2.sol/interface_IQuoterV2.md]

## Public/External Functions

### constructor(address,address,contract ICurveStableswapNGPool,int128,int128,uint24,uint24,contract IQuoterV2)

- **Signature**: `constructor(address,address,contract ICurveStableswapNGPool,int128,int128,uint24,uint24,contract IQuoterV2)`
- **Visibility**: public
- **Source Range**: 703:586:214
- **Details**: [function_constructor_address_address_contract_ICurveStableswapNGPool_int128_int128_uint24_uint24_contract_IQuoterV2.md](./function_constructor_address_address_contract_ICurveStableswapNGPool_int128_int128_uint24_uint24_contract_IQuoterV2.md)

**Signature:**
```solidity
constructor(address _usdc, address _weth, ICurveStableswapNGPool _curvePool, int128 _usdcIndex, int128 _boldIndex, uint24 _feeUsdcWeth, uint24 _feeWethColl, IQuoterV2 _uniV3Quoter);
```

### quoteExactInput(uint256,bool,address)

- **Signature**: `quoteExactInput(uint256,bool,address)`
- **Visibility**: external
- **Source Range**: 1295:1248:214
- **Details**: [function_quoteExactInput_uint256_bool_address.md](./function_quoteExactInput_uint256_bool_address.md)

**Signature:**
```solidity
function quoteExactInput(uint256 _inputAmount, bool _collToBold, address _collToken) external returns (uint256 outputAmount);
```

### quoteExactOutput(uint256,bool,address)

- **Signature**: `quoteExactOutput(uint256,bool,address)`
- **Visibility**: external
- **Source Range**: 2549:1405:214
- **Details**: [function_quoteExactOutput_uint256_bool_address.md](./function_quoteExactOutput_uint256_bool_address.md)

**Signature:**
```solidity
function quoteExactOutput(uint256 _outputAmount, bool _collToBold, address _collToken) external returns (uint256 inputAmount);
```
