# Function: decimals()

**Contract**: [test/TestContracts/ChainlinkOracleMock.sol/contract_ChainlinkOracleMock.md]

## Metadata

- **Contract**: ChainlinkOracleMock
- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 432:81:257

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
┌─ [0] ⚙️ FUNCTION: ChainlinkOracleMock.decimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
