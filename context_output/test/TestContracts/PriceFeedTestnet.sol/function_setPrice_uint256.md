# Function: setPrice(uint256)

**Contract**: [test/TestContracts/PriceFeedTestnet.sol/contract_PriceFeedTestnet.md]

## Metadata

- **Contract**: PriceFeedTestnet
- **Signature**: `setPrice(uint256)`
- **Visibility**: external
- **Source Range**: 1391:109:278

## Implementation

```solidity
function setPrice(uint256 price) external returns (bool) {
    _price = price;
    return true;
}
```

## State Variable Writes

- **_price** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PriceFeedTestnet.setPrice(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
