# Function: lastGoodPrice()

**Contract**: [test/TestContracts/PriceFeedMock.sol/contract_PriceFeedMock.md]

## Metadata

- **Contract**: PriceFeedMock
- **Signature**: `lastGoodPrice()`
- **Visibility**: external
- **Source Range**: 568:86:277

## Implementation

```solidity
function lastGoodPrice() external view returns (uint256) {
    return PRICE;
}
```

## State Variable Reads

- **PRICE** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PriceFeedMock.lastGoodPrice() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
