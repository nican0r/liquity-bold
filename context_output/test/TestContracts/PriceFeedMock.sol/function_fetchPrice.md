# Function: fetchPrice()

**Contract**: [test/TestContracts/PriceFeedMock.sol/contract_PriceFeedMock.md]

## Metadata

- **Contract**: PriceFeedMock
- **Signature**: `fetchPrice()`
- **Visibility**: external
- **Source Range**: 350:98:277

## Implementation

```solidity
function fetchPrice() external view returns (uint256, bool) {
    return (PRICE, false);
}
```

## State Variable Reads

- **PRICE** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PriceFeedMock.fetchPrice() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
