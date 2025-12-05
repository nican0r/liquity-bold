# Function: setUpdatedAt(uint256)

**Contract**: [test/TestContracts/ChainlinkOracleMock.sol/contract_ChainlinkOracleMock.md]

## Metadata

- **Contract**: ChainlinkOracleMock
- **Signature**: `setUpdatedAt(uint256)`
- **Visibility**: external
- **Source Range**: 1100:95:257

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
┌─ [0] ⚙️ FUNCTION: ChainlinkOracleMock.setUpdatedAt(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
