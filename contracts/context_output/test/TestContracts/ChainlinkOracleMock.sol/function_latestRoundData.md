# Function: latestRoundData()

**Contract**: [test/TestContracts/ChainlinkOracleMock.sol/contract_ChainlinkOracleMock.md]

## Metadata

- **Contract**: ChainlinkOracleMock
- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 519:407:257

## Implementation

```solidity
function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) {
    return (0, price, 0, lastUpdateTime, 0);
}
```

## State Variable Reads

- **price** (`int256`)
- **lastUpdateTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ChainlinkOracleMock.latestRoundData() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
