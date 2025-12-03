# Function: setPrice(uint256)

**Contract**: [test/TestContracts/PriceFeedMock.sol/contract_PriceFeedMock.md]

## Metadata

- **Contract**: PriceFeedMock
- **Signature**: `setPrice(uint256)`
- **Visibility**: external
- **Source Range**: 176:74:277

## Implementation

```solidity
function setPrice(uint256 _price) external {
    PRICE = _price;
}
```

## State Variable Writes

- **PRICE** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PriceFeedMock.setPrice(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
