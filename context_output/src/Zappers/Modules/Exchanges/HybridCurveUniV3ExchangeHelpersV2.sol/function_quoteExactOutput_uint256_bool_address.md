# Function: quoteExactOutput(uint256,bool,address)

**Contract**: [src/Zappers/Modules/Exchanges/HybridCurveUniV3ExchangeHelpersV2.sol/contract_HybridCurveUniV3ExchangeHelpersV2.md]

## Metadata

- **Contract**: HybridCurveUniV3ExchangeHelpersV2
- **Signature**: `quoteExactOutput(uint256,bool,address)`
- **Visibility**: external
- **Source Range**: 2549:1405:214

## Implementation

```solidity
function quoteExactOutput(uint256 _outputAmount, bool _collToBold, address _collToken) external returns (uint256 inputAmount) {
    if (_collToBold) {
        uint256 intermediateAmount = curvePool.get_dx(USDC_INDEX, BOLD_TOKEN_INDEX, _outputAmount);
        bytes memory path;
        if (WETH == _collToken) {
            path = abi.encodePacked(USDC, feeUsdcWeth, WETH);
        } else {
            path = abi.encodePacked(USDC, feeUsdcWeth, WETH, feeWethColl, _collToken);
        }
        (inputAmount, , , ) = uniV3Quoter.quoteExactOutput(path, intermediateAmount);
    } else {
        bytes memory path;
        if (WETH == _collToken) {
            path = abi.encodePacked(WETH, feeUsdcWeth, USDC);
        } else {
            path = abi.encodePacked(_collToken, feeWethColl, WETH, feeUsdcWeth, USDC);
        }
        (uint256 intermediateAmount, , , ) = uniV3Quoter.quoteExactOutput(path, _outputAmount);
        inputAmount = curvePool.get_dx(BOLD_TOKEN_INDEX, USDC_INDEX, intermediateAmount);
    }
}
```

## External Calls

- **ICurveStableswapNGPool::get_dx(int128,int128,uint256)**
- **IQuoterV2::quoteExactOutput(bytes,uint256)**

## State Variable Reads

- **curvePool** (`contract ICurveStableswapNGPool`) [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGPool.sol/interface_ICurveStableswapNGPool.md]
- **USDC_INDEX** (`int128`)
- **BOLD_TOKEN_INDEX** (`int128`)
- **WETH** (`address`)
- **USDC** (`address`)
- **feeUsdcWeth** (`uint24`)
- **feeWethColl** (`uint24`)
- **uniV3Quoter** (`contract IQuoterV2`) [src/Zappers/Modules/Exchanges/UniswapV3/IQuoterV2.sol/interface_IQuoterV2.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HybridCurveUniV3ExchangeHelpersV2.quoteExactOutput(uint256,bool,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
