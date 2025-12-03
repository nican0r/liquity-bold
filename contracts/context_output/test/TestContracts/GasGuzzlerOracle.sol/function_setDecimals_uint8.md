# Function: setDecimals(uint8)

**Contract**: [test/TestContracts/GasGuzzlerOracle.sol/contract_GasGuzzlerOracle.md]

## Metadata

- **Contract**: GasGuzzlerOracle
- **Signature**: `setDecimals(uint8)`
- **Visibility**: external
- **Source Range**: 982:83:264

## Implementation

```solidity
function setDecimals(uint8 _decimals) external {
    decimal = _decimals;
}
```

## State Variable Writes

- **decimal** (`uint8`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GasGuzzlerOracle.setDecimals(uint8) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
