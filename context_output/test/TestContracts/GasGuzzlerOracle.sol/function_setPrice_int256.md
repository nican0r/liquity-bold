# Function: setPrice(int256)

**Contract**: [test/TestContracts/GasGuzzlerOracle.sol/contract_GasGuzzlerOracle.md]

## Metadata

- **Contract**: GasGuzzlerOracle
- **Signature**: `setPrice(int256)`
- **Visibility**: external
- **Source Range**: 1071:73:264

## Implementation

```solidity
function setPrice(int256 _price) external {
    price = _price;
}
```

## State Variable Writes

- **price** (`int256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GasGuzzlerOracle.setPrice(int256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
