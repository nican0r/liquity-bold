# Function: getPrice()

**Contract**: [test/TestContracts/PriceFeedTestnet.sol/contract_PriceFeedTestnet.md]

## Metadata

- **Contract**: PriceFeedTestnet
- **Signature**: `getPrice()`
- **Visibility**: external
- **Source Range**: 520:91:278

## Implementation

```solidity
function getPrice() override external view returns (uint256) {
    return _price;
}
```

## State Variable Reads

- **_price** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PriceFeedTestnet.getPrice() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
