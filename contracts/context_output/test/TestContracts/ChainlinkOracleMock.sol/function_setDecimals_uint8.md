# Function: setDecimals(uint8)

**Contract**: [test/TestContracts/ChainlinkOracleMock.sol/contract_ChainlinkOracleMock.md]

## Metadata

- **Contract**: ChainlinkOracleMock
- **Signature**: `setDecimals(uint8)`
- **Visibility**: external
- **Source Range**: 932:83:257

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
┌─ [0] ⚙️ FUNCTION: ChainlinkOracleMock.setDecimals(uint8) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
