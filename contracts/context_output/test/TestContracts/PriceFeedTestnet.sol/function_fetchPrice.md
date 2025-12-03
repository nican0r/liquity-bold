# Function: fetchPrice()

**Contract**: [test/TestContracts/PriceFeedTestnet.sol/contract_PriceFeedTestnet.md]

## Metadata

- **Contract**: PriceFeedTestnet
- **Signature**: `fetchPrice()`
- **Visibility**: external
- **Source Range**: 710:311:278

## Implementation

```solidity
function fetchPrice() override external returns (uint256, bool) {
    emit LastGoodPriceUpdated(_price);
    return (_price, false);
}
```

## State Variable Reads

- **_price** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PriceFeedTestnet.fetchPrice() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
