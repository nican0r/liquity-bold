# Function: setSortedTroves(address)

**Contract**: [test/TestContracts/SortedTrovesTester.sol/contract_SortedTrovesTester.md]

## Metadata

- **Contract**: SortedTrovesTester
- **Signature**: `setSortedTroves(address)`
- **Visibility**: external
- **Source Range**: 301:131:281

## Implementation

```solidity
function setSortedTroves(address _sortedTrovesAddress) external {
    sortedTroves = ISortedTroves(_sortedTrovesAddress);
}
```

## State Variable Writes

- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTrovesTester.setSortedTroves(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
