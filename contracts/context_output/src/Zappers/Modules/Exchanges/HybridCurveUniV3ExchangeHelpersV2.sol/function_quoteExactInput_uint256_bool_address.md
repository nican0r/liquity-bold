# Function: quoteExactInput(uint256,bool,address)

**Contract**: [src/Zappers/Modules/Exchanges/HybridCurveUniV3ExchangeHelpersV2.sol/contract_HybridCurveUniV3ExchangeHelpersV2.md]

## Metadata

- **Contract**: HybridCurveUniV3ExchangeHelpersV2
- **Signature**: `quoteExactInput(uint256,bool,address)`
- **Visibility**: external
- **Source Range**: 1295:1248:214

## Implementation

```solidity
function quoteExactInput(uint256 _inputAmount, bool _collToBold, address _collToken) external returns (uint256 outputAmount) {
    if (_collToBold) {
        bytes memory path;
        if (WETH == _collToken) {
            path = abi.encodePacked(WETH, feeUsdcWeth, USDC);
        } else {
            path = abi.encodePacked(_collToken, feeWethColl, WETH, feeUsdcWeth, USDC);
        }
        (uint256 intermediateAmount, , , ) = uniV3Quoter.quoteExactInput(path, _inputAmount);
        outputAmount = curvePool.get_dy(USDC_INDEX, BOLD_TOKEN_INDEX, intermediateAmount);
    } else {
        uint256 intermediateAmount = curvePool.get_dy(BOLD_TOKEN_INDEX, USDC_INDEX, _inputAmount);
        bytes memory path;
        if (WETH == _collToken) {
            path = abi.encodePacked(USDC, feeUsdcWeth, WETH);
        } else {
            path = abi.encodePacked(USDC, feeUsdcWeth, WETH, feeWethColl, _collToken);
        }
        (outputAmount, , , ) = uniV3Quoter.quoteExactInput(path, intermediateAmount);
    }
}
```

## External Calls

- **IQuoterV2::quoteExactInput(bytes,uint256)**
- **ICurveStableswapNGPool::get_dy(int128,int128,uint256)**

## State Variable Reads

- **WETH** (`address`)
- **feeUsdcWeth** (`uint24`)
- **USDC** (`address`)
- **feeWethColl** (`uint24`)
- **uniV3Quoter** (`contract IQuoterV2`) [src/Zappers/Modules/Exchanges/UniswapV3/IQuoterV2.sol/interface_IQuoterV2.md]
- **curvePool** (`contract ICurveStableswapNGPool`) [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGPool.sol/interface_ICurveStableswapNGPool.md]
- **USDC_INDEX** (`int128`)
- **BOLD_TOKEN_INDEX** (`int128`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HybridCurveUniV3ExchangeHelpersV2.quoteExactInput(uint256,bool,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
