# Function: setPrice(int256)

**Contract**: [test/TestContracts/ChainlinkOracleMock.sol/contract_ChainlinkOracleMock.md]

## Metadata

- **Contract**: ChainlinkOracleMock
- **Signature**: `setPrice(int256)`
- **Visibility**: external
- **Source Range**: 1021:73:257

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
┌─ [0] ⚙️ FUNCTION: ChainlinkOracleMock.setPrice(int256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
