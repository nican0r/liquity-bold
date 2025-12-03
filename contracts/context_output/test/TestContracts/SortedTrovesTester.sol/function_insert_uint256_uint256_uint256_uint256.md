# Function: insert(uint256,uint256,uint256,uint256)

**Contract**: [test/TestContracts/SortedTrovesTester.sol/contract_SortedTrovesTester.md]

## Metadata

- **Contract**: SortedTrovesTester
- **Signature**: `insert(uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 438:181:281

## Implementation

```solidity
function insert(uint256 _id, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) external {
    sortedTroves.insert(_id, _annualInterestRate, _prevId, _nextId);
}
```

## External Calls

- **ISortedTroves::insert(uint256,uint256,uint256,uint256)**

## State Variable Reads

- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTrovesTester.insert(uint256,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
