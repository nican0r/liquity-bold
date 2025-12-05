# Function: getTroveFromTroveIdsArray(uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `getTroveFromTroveIdsArray(uint256)`
- **Visibility**: external
- **Source Range**: 8480:132:188
- **Inherited From**: TroveManager

## Implementation

```solidity
function getTroveFromTroveIdsArray(uint256 _index) override external view returns (uint256) {
    return TroveIds[_index];
}
```

## State Variable Reads

- **TroveIds** (`uint256[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.getTroveFromTroveIdsArray(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
