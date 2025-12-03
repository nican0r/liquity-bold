# Function: exchangeHelpersV2_quoteExactOutput_throw(uint256,bool,address)

**Contract**: [test/ExchangeHelpers.t.sol/contract_ExchangeHelpersTest.md]

## Metadata

- **Contract**: ExchangeHelpersTest
- **Signature**: `exchangeHelpersV2_quoteExactOutput_throw(uint256,bool,address)`
- **Visibility**: external
- **Source Range**: 10133:205:232

## Implementation

```solidity
function exchangeHelpersV2_quoteExactOutput_throw(uint256 dy, bool collToBold, address collToken) external {
    revert QuoteResult(exchangeHelpersV2.quoteExactOutput(dy, collToBold, collToken));
}
```

## External Calls

- **IExchangeHelpersV2::quoteExactOutput(uint256,bool,address)**

## State Variable Reads

- **exchangeHelpersV2** (`contract IExchangeHelpersV2`) [src/Zappers/Interfaces/IExchangeHelpersV2.sol/interface_IExchangeHelpersV2.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ExchangeHelpersTest.exchangeHelpersV2_quoteExactOutput_throw(uint256,bool,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
