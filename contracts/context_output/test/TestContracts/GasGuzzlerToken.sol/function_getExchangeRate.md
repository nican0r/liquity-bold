# Function: getExchangeRate()

**Contract**: [test/TestContracts/GasGuzzlerToken.sol/contract_GasGuzzlerToken.md]

## Metadata

- **Contract**: GasGuzzlerToken
- **Signature**: `getExchangeRate()`
- **Visibility**: external
- **Source Range**: 364:283:265

## Implementation

```solidity
function getExchangeRate() external view returns (uint256) {
    for (uint256 i = 0; i < 1000000; i++) {
        uint256 unusedVar = pointlessStorageVar + i;
    }
    return 11e17;
}
```

## State Variable Reads

- **pointlessStorageVar** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GasGuzzlerToken.getExchangeRate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
