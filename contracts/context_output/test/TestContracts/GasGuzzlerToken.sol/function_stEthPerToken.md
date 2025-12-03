# Function: stEthPerToken()

**Contract**: [test/TestContracts/GasGuzzlerToken.sol/contract_GasGuzzlerToken.md]

## Metadata

- **Contract**: GasGuzzlerToken
- **Signature**: `stEthPerToken()`
- **Visibility**: external
- **Source Range**: 688:281:265

## Implementation

```solidity
function stEthPerToken() external view returns (uint256) {
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
┌─ [0] ⚙️ FUNCTION: GasGuzzlerToken.stEthPerToken() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
