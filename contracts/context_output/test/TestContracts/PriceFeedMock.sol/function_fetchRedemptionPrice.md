# Function: fetchRedemptionPrice()

**Contract**: [test/TestContracts/PriceFeedMock.sol/contract_PriceFeedMock.md]

## Metadata

- **Contract**: PriceFeedMock
- **Signature**: `fetchRedemptionPrice()`
- **Visibility**: external
- **Source Range**: 454:108:277

## Implementation

```solidity
function fetchRedemptionPrice() external view returns (uint256, bool) {
    return (PRICE, false);
}
```

## State Variable Reads

- **PRICE** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PriceFeedMock.fetchRedemptionPrice() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
