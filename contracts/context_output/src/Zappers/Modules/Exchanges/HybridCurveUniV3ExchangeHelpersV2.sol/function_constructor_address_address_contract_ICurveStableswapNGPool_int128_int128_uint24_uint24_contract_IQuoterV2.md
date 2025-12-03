# Function: constructor(address,address,contract ICurveStableswapNGPool,int128,int128,uint24,uint24,contract IQuoterV2)

**Contract**: [src/Zappers/Modules/Exchanges/HybridCurveUniV3ExchangeHelpersV2.sol/contract_HybridCurveUniV3ExchangeHelpersV2.md]

## Metadata

- **Contract**: HybridCurveUniV3ExchangeHelpersV2
- **Signature**: `constructor(address,address,contract ICurveStableswapNGPool,int128,int128,uint24,uint24,contract IQuoterV2)`
- **Visibility**: public
- **Source Range**: 703:586:214

## Implementation

```solidity
constructor(address _usdc, address _weth, ICurveStableswapNGPool _curvePool, int128 _usdcIndex, int128 _boldIndex, uint24 _feeUsdcWeth, uint24 _feeWethColl, IQuoterV2 _uniV3Quoter) {
    USDC = _usdc;
    WETH = _weth;
    curvePool = _curvePool;
    USDC_INDEX = _usdcIndex;
    BOLD_TOKEN_INDEX = _boldIndex;
    feeUsdcWeth = _feeUsdcWeth;
    feeWethColl = _feeWethColl;
    uniV3Quoter = _uniV3Quoter;
}
```

## State Variable Writes

- **USDC** (`address`)
- **WETH** (`address`)
- **curvePool** (`contract ICurveStableswapNGPool`) [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGPool.sol/interface_ICurveStableswapNGPool.md]
- **USDC_INDEX** (`int128`)
- **BOLD_TOKEN_INDEX** (`int128`)
- **feeUsdcWeth** (`uint24`)
- **feeWethColl** (`uint24`)
- **uniV3Quoter** (`contract IQuoterV2`) [src/Zappers/Modules/Exchanges/UniswapV3/IQuoterV2.sol/interface_IQuoterV2.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: HybridCurveUniV3ExchangeHelpersV2.constructor(address,address,contract ICurveStableswapNGPool,int128,int128,uint24,uint24,contract IQuoterV2) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: HybridCurveUniV3ExchangeHelpersV2
```
