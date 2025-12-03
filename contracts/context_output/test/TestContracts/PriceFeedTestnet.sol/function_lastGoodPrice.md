# Function: lastGoodPrice()

**Contract**: [test/TestContracts/PriceFeedTestnet.sol/contract_PriceFeedTestnet.md]

## Metadata

- **Contract**: PriceFeedTestnet
- **Signature**: `lastGoodPrice()`
- **Visibility**: external
- **Source Range**: 617:87:278

## Implementation

```solidity
function lastGoodPrice() external view returns (uint256) {
    return _price;
}
```

## State Variable Reads

- **_price** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PriceFeedTestnet.lastGoodPrice() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
