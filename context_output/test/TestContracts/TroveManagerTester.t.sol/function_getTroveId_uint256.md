# Function: getTroveId(uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `getTroveId(uint256)`
- **Visibility**: external
- **Source Range**: 2688:108:282

## Implementation

```solidity
function getTroveId(uint256 _index) external view returns (uint256) {
    return TroveIds[_index];
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.getTroveId(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
