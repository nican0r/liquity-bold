# Function: setUpdatedAt(uint256)

**Contract**: [test/TestContracts/GasGuzzlerOracle.sol/contract_GasGuzzlerOracle.md]

## Metadata

- **Contract**: GasGuzzlerOracle
- **Signature**: `setUpdatedAt(uint256)`
- **Visibility**: external
- **Source Range**: 1150:95:264

## Implementation

```solidity
function setUpdatedAt(uint256 _updatedAt) external {
    lastUpdateTime = _updatedAt;
}
```

## State Variable Writes

- **lastUpdateTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GasGuzzlerOracle.setUpdatedAt(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
