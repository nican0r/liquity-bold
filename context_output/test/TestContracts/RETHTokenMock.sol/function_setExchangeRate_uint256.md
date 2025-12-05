# Function: setExchangeRate(uint256)

**Contract**: [test/TestContracts/RETHTokenMock.sol/contract_RETHTokenMock.md]

## Metadata

- **Contract**: RETHTokenMock
- **Signature**: `setExchangeRate(uint256)`
- **Visibility**: external
- **Source Range**: 307:96:279

## Implementation

```solidity
function setExchangeRate(uint256 _ethPerReth) external {
    ethPerReth = _ethPerReth;
}
```

## State Variable Writes

- **ethPerReth** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RETHTokenMock.setExchangeRate(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
