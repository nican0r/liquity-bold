# Function: remove(uint256)

**Contract**: [test/TestContracts/SortedTrovesTester.sol/contract_SortedTrovesTester.md]

## Metadata

- **Contract**: SortedTrovesTester
- **Signature**: `remove(uint256)`
- **Visibility**: external
- **Source Range**: 625:79:281

## Implementation

```solidity
function remove(uint256 _id) external {
    sortedTroves.remove(_id);
}
```

## External Calls

- **ISortedTroves::remove(uint256)**

## State Variable Writes

- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTrovesTester.remove(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
