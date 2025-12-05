# Function: fetchRedemptionPrice()

**Contract**: [test/TestContracts/PriceFeedTestnet.sol/contract_PriceFeedTestnet.md]

## Metadata

- **Contract**: PriceFeedTestnet
- **Signature**: `fetchRedemptionPrice()`
- **Visibility**: external
- **Source Range**: 1027:321:278

## Implementation

```solidity
function fetchRedemptionPrice() override external returns (uint256, bool) {
    emit LastGoodPriceUpdated(_price);
    return (_price, false);
}
```

## State Variable Reads

- **_price** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PriceFeedTestnet.fetchRedemptionPrice() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
