# Function: getExchangeRate()

**Contract**: [test/TestContracts/RETHTokenMock.sol/contract_RETHTokenMock.md]

## Metadata

- **Contract**: RETHTokenMock
- **Signature**: `getExchangeRate()`
- **Visibility**: external
- **Source Range**: 208:93:279

## Implementation

```solidity
function getExchangeRate() external view returns (uint256) {
    return ethPerReth;
}
```

## State Variable Reads

- **ethPerReth** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RETHTokenMock.getExchangeRate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
