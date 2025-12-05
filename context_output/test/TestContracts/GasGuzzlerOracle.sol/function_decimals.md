# Function: decimals()

**Contract**: [test/TestContracts/GasGuzzlerOracle.sol/contract_GasGuzzlerOracle.md]

## Metadata

- **Contract**: GasGuzzlerOracle
- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 466:81:264

## Implementation

```solidity
function decimals() external view returns (uint8) {
    return decimal;
}
```

## State Variable Reads

- **decimal** (`uint8`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GasGuzzlerOracle.decimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
