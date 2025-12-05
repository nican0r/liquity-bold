# Function: reInsert(uint256,uint256,uint256,uint256)

**Contract**: [test/TestContracts/SortedTrovesTester.sol/contract_SortedTrovesTester.md]

## Metadata

- **Contract**: SortedTrovesTester
- **Signature**: `reInsert(uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 710:191:281

## Implementation

```solidity
function reInsert(uint256 _id, uint256 _newAnnualInterestRate, uint256 _prevId, uint256 _nextId) external {
    sortedTroves.reInsert(_id, _newAnnualInterestRate, _prevId, _nextId);
}
```

## External Calls

- **ISortedTroves::reInsert(uint256,uint256,uint256,uint256)**

## State Variable Reads

- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTrovesTester.reInsert(uint256,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
