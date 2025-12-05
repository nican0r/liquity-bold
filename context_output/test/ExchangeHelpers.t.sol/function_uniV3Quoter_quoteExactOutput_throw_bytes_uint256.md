# Function: uniV3Quoter_quoteExactOutput_throw(bytes,uint256)

**Contract**: [test/ExchangeHelpers.t.sol/contract_ExchangeHelpersTest.md]

## Metadata

- **Contract**: ExchangeHelpersTest
- **Signature**: `uniV3Quoter_quoteExactOutput_throw(bytes,uint256)`
- **Visibility**: external
- **Source Range**: 9576:215:232

## Implementation

```solidity
function uniV3Quoter_quoteExactOutput_throw(bytes memory path, uint256 amountOut) external {
    (uint256 amountIn, , , ) = uniV3Quoter.quoteExactOutput(path, amountOut);
    revert QuoteResult(amountIn);
}
```

## External Calls

- **IQuoterV2::quoteExactOutput(bytes,uint256)**

## State Variable Reads

- **uniV3Quoter** (`contract IQuoterV2`) [src/Zappers/Modules/Exchanges/UniswapV3/IQuoterV2.sol/interface_IQuoterV2.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ExchangeHelpersTest.uniV3Quoter_quoteExactOutput_throw(bytes,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
