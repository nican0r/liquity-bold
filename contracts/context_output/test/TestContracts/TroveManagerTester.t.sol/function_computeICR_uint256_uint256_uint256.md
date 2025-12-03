# Function: computeICR(uint256,uint256,uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `computeICR(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3082:166:282

## Implementation

```solidity
function computeICR(uint256 _coll, uint256 _debt, uint256 _price) external pure returns (uint256) {
    return LiquityMath._computeCR(_coll, _debt, _price);
}
```

## Related Implementations

### _computeCR(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 2640:414:137
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_computeCR(uint256,uint256,uint256)`

```solidity
function _computeCR(uint256 _coll, uint256 _debt, uint256 _price) internal pure returns (uint256) {
    if (_debt > 0) {
        uint256 newCollRatio = (_coll * _price) / _debt;
        return newCollRatio;
    } else {
        return (2 ** 256) - 1;
    }
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.computeICR(uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 1)
      💬 Args: [_coll, _debt, _price]
      👁️  Def: internal
```
