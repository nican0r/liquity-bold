# Function: getCollGasCompensation(uint256,uint256,uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `getCollGasCompensation(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3254:451:282

## Implementation

```solidity
function getCollGasCompensation(uint256 _entireColl, uint256 _entireDebt, uint256 _boldInSPForOffsets) external pure returns (uint256) {
    uint256 collSubjectToGasCompensation = _entireColl;
    if (_boldInSPForOffsets < _entireDebt) {
        collSubjectToGasCompensation = (_entireColl * _boldInSPForOffsets) / _entireDebt;
    }
    return _getCollGasCompensation(collSubjectToGasCompensation);
}
```

## Related Implementations

### _getCollGasCompensation(uint256)

- **Kind**: internal
- **Source**: 13526:298:188
- **Link**: `src/TroveManager.sol:TroveManager:_getCollGasCompensation(uint256)`

```solidity
function _getCollGasCompensation(uint256 _coll) internal pure returns (uint256) {
    return LiquityMath._min(_coll / COLL_GAS_COMPENSATION_DIVISOR, COLL_GAS_COMPENSATION_CAP);
}
```

### _min(uint256,uint256)

- **Kind**: internal
- **Source**: 136:113:137
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_min(uint256,uint256)`

```solidity
function _min(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a < _b) ? _a : _b;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.getCollGasCompensation(uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: TroveManager._getCollGasCompensation(uint256) (NodeID: 1)
      💬 Args: [collSubjectToGasCompensation]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 2)
        💬 Args: [_coll / COLL_GAS_COMPENSATION_DIVISOR, COLL_GAS_COMPENSATION_CAP]
        👁️  Def: internal
```
