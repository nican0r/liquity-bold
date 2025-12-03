# Function: getPrice()

**Contract**: [test/TestContracts/PriceFeedMock.sol/contract_PriceFeedMock.md]

## Metadata

- **Contract**: PriceFeedMock
- **Signature**: `getPrice()`
- **Visibility**: external
- **Source Range**: 256:88:277

## Implementation

```solidity
function getPrice() external view returns (uint256 _price) {
    return PRICE;
}
```

## State Variable Reads

- **PRICE** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PriceFeedMock.getPrice() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
