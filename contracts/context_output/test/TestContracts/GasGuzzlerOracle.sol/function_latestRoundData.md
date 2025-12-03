# Function: latestRoundData()

**Contract**: [test/TestContracts/GasGuzzlerOracle.sol/contract_GasGuzzlerOracle.md]

## Metadata

- **Contract**: GasGuzzlerOracle
- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 553:423:264

## Implementation

```solidity
function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) {
    for (uint256 i = 0; i < 1000000; i++) {
        uint256 unusedVar = pointlessStorageVar + i;
    }
    return (0, price, 0, lastUpdateTime, 0);
}
```

## State Variable Reads

- **pointlessStorageVar** (`uint256`)
- **price** (`int256`)
- **lastUpdateTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GasGuzzlerOracle.latestRoundData() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
