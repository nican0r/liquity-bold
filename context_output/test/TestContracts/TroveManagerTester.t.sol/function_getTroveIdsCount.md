# Function: getTroveIdsCount()

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `getTroveIdsCount()`
- **Visibility**: external
- **Source Range**: 8366:108:188
- **Inherited From**: TroveManager

## Implementation

```solidity
function getTroveIdsCount() override external view returns (uint256) {
    return TroveIds.length;
}
```

## State Variable Reads

- **TroveIds** (`uint256[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.getTroveIdsCount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
