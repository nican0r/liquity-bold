# Function: exchangeHelpersV2_quoteExactInput_throw(uint256,bool,address)

**Contract**: [test/ExchangeHelpers.t.sol/contract_ExchangeHelpersTest.md]

## Metadata

- **Contract**: ExchangeHelpersTest
- **Signature**: `exchangeHelpersV2_quoteExactInput_throw(uint256,bool,address)`
- **Visibility**: external
- **Source Range**: 10732:203:232

## Implementation

```solidity
function exchangeHelpersV2_quoteExactInput_throw(uint256 dx, bool collToBold, address collToken) external {
    revert QuoteResult(exchangeHelpersV2.quoteExactInput(dx, collToBold, collToken));
}
```

## External Calls

- **IExchangeHelpersV2::quoteExactInput(uint256,bool,address)**

## State Variable Reads

- **exchangeHelpersV2** (`contract IExchangeHelpersV2`) [src/Zappers/Interfaces/IExchangeHelpersV2.sol/interface_IExchangeHelpersV2.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ExchangeHelpersTest.exchangeHelpersV2_quoteExactInput_throw(uint256,bool,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
